<?php

namespace App\Http\Controllers\Chatbot;

use App\Http\Controllers\Controller;
use App\Models\Pet;
use App\Models\Medicacao;
use App\Models\Especie;
use Illuminate\Http\Request;
use Prism\Prism\Facades\Prism;
use Prism\Prism\Enums\Provider;
use Prism\Prism\Enums\StreamEventType;
use Prism\Prism\Tool;

class ChatController extends Controller
{
    public function chat(Request $request)
    {
        $request->validate([
            'message' => 'required|string',
        ]);

        $user = $request->user();
        $message = $request->input('message');

        $tools = $this->getTools($user);

        $systemPrompt = $this->getSystemPrompt();

        $response = Prism::text()
            ->using(Provider::OpenRouter, 'openai/gpt-4o-mini')
            ->withSystemPrompt($systemPrompt)
            ->withMessages([
                new \Prism\Prism\ValueObjects\Messages\UserMessage($message),
            ])
            ->withTools($tools)
            ->withMaxSteps(5)
            ->asText();

        return response()->json([
            'response' => $response->text,
            'tool_calls' => collect($response->toolCalls)->map(fn($t) => [
                'name' => $t->name,
                'arguments' => $t->arguments,
            ]),
        ]);
    }

    public function stream(Request $request)
    {
        $request->validate([
            'message' => 'required|string',
        ]);

        $user = $request->user();
        $message = $request->input('message');

        $tools = $this->getTools($user);

        $systemPrompt = $this->getSystemPrompt();

        $stream = Prism::text()
            ->using(Provider::OpenRouter, 'openai/gpt-4o-mini')
            ->withSystemPrompt($systemPrompt)
            ->withMessages([
                new \Prism\Prism\ValueObjects\Messages\UserMessage($message),
            ])
            ->withTools($tools)
            ->withMaxSteps(5)
            ->asStream();

        return response()->stream(function () use ($stream) {
            foreach ($stream as $event) {
                match ($event->type()) {
                    StreamEventType::TextDelta => print "data: " . json_encode(['type' => 'text', 'content' => $event->delta]) . "\n\n",
                    StreamEventType::ToolCall => print "data: " . json_encode(['type' => 'tool_call', 'tool' => $event->toolName, 'arguments' => $event->arguments]) . "\n\n",
                    StreamEventType::ToolResult => print "data: " . json_encode(['type' => 'tool_result', 'tool' => $event->toolName, 'result' => $event->result]) . "\n\n",
                    StreamEventType::Done => print "data: " . json_encode(['type' => 'done']) . "\n\n",
                    default => null,
                };
                ob_flush();
                flush();
            }
        }, 200, [
            'Content-Type' => 'text/event-stream',
            'Cache-Control' => 'no-cache',
            'Connection' => 'keep-alive',
        ]);
    }

    protected function getSystemPrompt(): string
    {
        return <<<'PROMPT'
Você é um assistente útil de cuidados com pets. Você ajuda os usuários a gerenciar seus pets e medicamentos.

SEMPRE responda em português brasileiro (pt-BR).

Quando um usuário pedir para:
- Listar seus pets: Use a ferramenta list_pets
- Obter detalhes sobre um pet: Use a ferramenta get_pet
- Adicionar um novo pet: Use a ferramenta create_pet
- Listar medicamentos: Use a ferramenta list_medications tool
- Adicionar um medicamento/lembrete: Use a ferramenta create_medication
- Ver medicamentos próximos: Use a ferramenta get_upcoming_medications

Seja友好, conciso e útil. Ao criar pets ou medicamentos, peça informações faltantes.
PROMPT;
    }

    protected function getTools($user)
    {
        return [
            (new Tool)->as('list_pets')
                ->for('List all pets belonging to the user')
                ->using(function () use ($user) {
                    $pets = Pet::where('user_id', $user->id)->get();
                    if ($pets->isEmpty()) {
                        return "You don't have any pets yet. Would you like to add one?";
                    }
                    return $pets->map(function ($pet) {
                        return "• {$pet->nome}" . ($pet->especie ? " ({$pet->especie->nome})" : "");
                    })->implode("\n");
                }),

            (new Tool)->as('get_pet')
                ->for('Get detailed information about a specific pet')
                ->withStringParameter('pet_name', 'The name of the pet')
                ->using(function (string $petName) use ($user) {
                    $pet = Pet::where('user_id', $user->id)
                        ->where('nome', 'like', "%{$petName}%")
                        ->with('especie')
                        ->first();

                    if (!$pet) {
                        return "Pet not found. Use list_pets to see your pets.";
                    }

                    $info = [
                        "Name: {$pet->nome}",
                        "Species: " . ($pet->especie?->nome ?? 'Unknown'),
                        "Breed: " . ($pet->raca ?? 'Not specified'),
                        "Sex: " . ($pet->sexo ?? 'Not specified'),
                    ];

                    if ($pet->nascimento) {
                        $info[] = "Birth date: " . $pet->nascimento->format('d/m/Y');
                    }

                    return implode("\n", $info);
                }),

            (new Tool)->as('create_pet')
                ->for('Add a new pet to the user\'s account')
                ->withStringParameter('name', 'The name of the pet')
                ->withStringParameter('species', 'The species type (dog, cat, bird, etc.)')
                ->withStringParameter('breed', 'The breed of the pet', required: false)
                ->withStringParameter('sex', 'The sex of the pet (male/female)', required: false)
                ->using(function (string $name, string $species, ?string $breed = null, ?string $sex = null) use ($user) {
                    $especie = Especie::where('nome', 'like', "%{$species}%")->first();

                    $pet = Pet::create([
                        'nome' => $name,
                        'user_id' => $user->id,
                        'especie_id' => $especie?->id,
                        'raca' => $breed,
                        'sexo' => $sex,
                    ]);

                    return "I've added {$name} to your pets!" . ($especie ? " ({$especie->nome})" : "");
                }),

            (new Tool)->as('list_medications')
                ->for('List all medications for a specific pet')
                ->withStringParameter('pet_name', 'The name of the pet (optional - lists all if not provided)', required: false)
                ->using(function (?string $petName = null) use ($user) {
                    $query = Medicacao::where('user_id', $user->id)->with('pet');

                    if ($petName) {
                        $query->whereHas('pet', function ($q) use ($petName) {
                            $q->where('nome', 'like', "%{$petName}%");
                        });
                    }

                    $meds = $query->get();

                    if ($meds->isEmpty()) {
                        return "No medications found.";
                    }

                    return $meds->map(function ($med) {
                        $status = $med->completado ? '✅ Completed' : '⏳ Pending';
                        $petName = $med->pet?->nome ?? 'Unknown pet';
                        return "• {$med->nome} for {$petName} - {$status}" . ($med->quando ? " (due: {$med->quando->format('d/m/Y H:i')})" : "");
                    })->implode("\n");
                }),

            (new Tool)->as('create_medication')
                ->for('Add a new medication or reminder for a pet')
                ->withStringParameter('pet_name', 'The name of the pet')
                ->withStringParameter('medication_name', 'The name of the medication')
                ->withStringParameter('scheduled_time', 'When to take the medication (ISO 8601 format)', required: false)
                ->withStringParameter('notes', 'Any additional notes', required: false)
                ->using(function (string $petName, string $medicationName, ?string $scheduledTime = null, ?string $notes = null) use ($user) {
                    $pet = Pet::where('user_id', $user->id)
                        ->where('nome', 'like', "%{$petName}%")
                        ->first();

                    if (!$pet) {
                        return "Pet not found. Use list_pets to see your pets.";
                    }

                    $medicacao = Medicacao::create([
                        'pet_id' => $pet->id,
                        'user_id' => $user->id,
                        'nome' => $medicationName,
                        'quando' => $scheduledTime ? \Carbon\Carbon::parse($scheduledTime) : now()->addHour(),
                        'completado' => false,
                    ]);

                    return "I've added {$medicationName} as a reminder for {$petName}!" . ($scheduledTime ? " Scheduled for {$scheduledTime}" : " Scheduled for 1 hour from now");
                }),

            (new Tool)->as('get_upcoming_medications')
                ->for('Get upcoming medication reminders for the next 24 hours')
                ->using(function () use ($user) {
                    $meds = Medicacao::where('user_id', $user->id)
                        ->where('completado', false)
                        ->where('quando', '>=', now())
                        ->where('quando', '<=', now()->addDay())
                        ->with('pet')
                        ->orderBy('quando')
                        ->get();

                    if ($meds->isEmpty()) {
                        return "No upcoming medications in the next 24 hours.";
                    }

                    return $meds->map(function ($med) {
                        $petName = $med->pet?->nome ?? 'Unknown';
                        $time = $med->quando->format('d/m/Y H:i');
                        return "• {$med->nome} for {$petName} at {$time}";
                    })->implode("\n");
                }),
        ];
    }
}