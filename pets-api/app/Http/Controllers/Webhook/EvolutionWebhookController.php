<?php

namespace App\Http\Controllers\Webhook;

use App\Http\Controllers\Controller;
use App\Models\WhatsappAccount;
use App\Services\EvolutionApiService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Prism\Prism\Facades\Prism;
use Prism\Prism\Enums\Provider;
use Prism\Prism\Enums\StreamEventType;
use Prism\Prism\Tool;
use Prism\Prism\ValueObjects\Messages\UserMessage;

class EvolutionWebhookController extends Controller
{
    protected EvolutionApiService $evolution;

    public function __construct()
    {
        $this->evolution = new EvolutionApiService();
    }

    public function handle(Request $request, string $instanceName)
    {
        $account = WhatsappAccount::where('instance_name', $instanceName)->first();

        if (!$account) {
            Log::warning("Evolution webhook: Instance not found: {$instanceName}");
            return response()->json(['error' => 'Instance not found'], 404);
        }

        $event = $request->input('event');

        match ($event) {
            'MESSAGES_UPSERT' => $this->handleMessage($request, $account),
            'CONNECTION_UPDATE' => $this->handleConnectionUpdate($request, $account),
            'QRCODE_UPDATED' => $this->handleQrCodeUpdate($request, $account),
            default => Log::info("Evolution webhook: Unhandled event: {$event}"),
        };

        return response()->json(['status' => 'ok']);
    }

    protected function handleMessage(Request $request, WhatsappAccount $account): void
    {
        $messages = $request->input('data.messages', []);

        foreach ($messages as $message) {
            if (isset($message['fromMe']) && $message['fromMe']) {
                continue;
            }

            $remoteJid = $message['key']['remoteJid'] ?? null;
            $text = $message['message']['conversation'] ?? 
                    $message['message']['extendedTextMessage']['text'] ?? 
                    null;

            if (!$remoteJid || !$text) {
                continue;
            }

            $text = trim($text);

            if (str_starts_with($text, '/')) {
                continue;
            }

            Log::info("Whatsapp message from {$remoteJid}: {$text}");

            $this->processMessage($account, $remoteJid, $text);
        }
    }

    protected function processMessage(WhatsappAccount $account, string $remoteJid, string $text): void
    {
        $user = $account->user;

        $tools = $this->getTools($user);
        $systemPrompt = $this->getSystemPrompt();

        try {
            $response = Prism::text()
                ->using(Provider::OpenRouter, 'openai/gpt-4o-mini')
                ->withSystemPrompt($systemPrompt)
                ->withMessages([
                    new UserMessage($text),
                ])
                ->withTools($tools)
                ->withMaxSteps(5)
                ->asText();

            $reply = $response->text;

            if ($reply) {
                $this->evolution->sendText($account->instance_name, $remoteJid, $reply);
                Log::info("Sent reply to {$remoteJid}: " . substr($reply, 0, 50) . '...');
            }
        } catch (\Exception $e) {
            Log::error("Error processing message: " . $e->getMessage());
            $this->evolution->sendText($account->instance_name, $remoteJid, "Desculpe, houve um erro ao processar sua mensagem. Tente novamente.");
        }
    }

    protected function handleConnectionUpdate(Request $request, WhatsappAccount $account): void
    {
        $status = $request->input('data.status');
        $ownerJid = $request->input('data.owner');

        Log::info("Evolution connection update for {$account->instance_name}: {$status}");

        $account->status = match ($status) {
            'open' => 'connected',
            'close' => 'disconnected',
            default => $status,
        };

        if ($ownerJid) {
            $account->owner_jid = $ownerJid;
            $account->phone_number = preg_replace('/@.*$/', '', $ownerJid);
        }

        $account->save();
    }

    protected function handleQrCodeUpdate(Request $request, WhatsappAccount $account): void
    {
        $qrCode = $request->input('data.qrcode');

        if ($qrCode) {
            $account->qr_code = $qrCode;
            $account->status = 'pending';
            $account->save();
        }
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
        $petModel = \App\Models\Pet::class;
        $medicacaoModel = \App\Models\Medicacao::class;
        $especieModel = \App\Models\Especie::class;

        return [
            Tool::as('list_pets')
                ->for('List all pets belonging to the user')
                ->using(function () use ($user, $petModel) {
                    $pets = $petModel::where('user_id', $user->id)->get();
                    if ($pets->isEmpty()) {
                        return "Você ainda não tem nenhum pet. Gostaria de adicionar um?";
                    }
                    return $pets->map(fn($pet) => "• {$pet->nome}" . ($pet->especie ? " ({$pet->especie->nome})" : ""))->implode("\n");
                }),

            Tool::as('get_pet')
                ->for('Get detailed information about a specific pet')
                ->withStringParameter('pet_name', 'The name of the pet')
                ->using(function (string $petName) use ($user, $petModel) {
                    $pet = $petModel::where('user_id', $user->id)
                        ->where('nome', 'like', "%{$petName}%")
                        ->with('especie')
                        ->first();

                    if (!$pet) {
                        return "Pet não encontrado. Use list_pets para ver seus pets.";
                    }

                    $info = [
                        "Nome: {$pet->nome}",
                        "Espécie: " . ($pet->especie?->nome ?? 'Desconhecida'),
                        "Raça: " . ($pet->raca ?? 'Não especificada'),
                        "Sexo: " . ($pet->sexo ?? 'Não especificado'),
                    ];

                    if ($pet->nascimento) {
                        $info[] = "Data de nascimento: " . $pet->nascimento->format('d/m/Y');
                    }

                    return implode("\n", $info);
                }),

            Tool::as('create_pet')
                ->for('Add a new pet to the user\'s account')
                ->withStringParameter('name', 'The name of the pet')
                ->withStringParameter('species', 'The species type (dog, cat, bird, etc.)')
                ->withOptionalStringParameter('breed', 'The breed of the pet')
                ->withOptionalStringParameter('sex', 'The sex of the pet (male/female)')
                ->using(function (string $name, string $species, ?string $breed = null, ?string $sex = null) use ($user, $petModel, $especieModel) {
                    $especie = $especieModel::where('nome', 'like', "%{$species}%")->first();

                    $pet = $petModel::create([
                        'nome' => $name,
                        'user_id' => $user->id,
                        'especie_id' => $especie?->id,
                        'raca' => $breed,
                        'sexo' => $sex,
                    ]);

                    return "Adicionei {$name} aos seus pets!" . ($especie ? " ({$especie->nome})" : "");
                }),

            Tool::as('list_medications')
                ->for('List all medications for a specific pet')
                ->withOptionalStringParameter('pet_name', 'The name of the pet (optional - lists all if not provided)')
                ->using(function (?string $petName = null) use ($user, $petModel, $medicacaoModel) {
                    $query = $medicacaoModel::where('user_id', $user->id)->with('pet');

                    if ($petName) {
                        $query->whereHas('pet', fn($q) => $q->where('nome', 'like', "%{$petName}%"));
                    }

                    $meds = $query->get();

                    if ($meds->isEmpty()) {
                        return "Nenhum medicamento encontrado.";
                    }

                    return $meds->map(function ($med) {
                        $status = $med->completado ? '✅ Concluído' : '⏳ Pendente';
                        $petName = $med->pet?->nome ?? 'Pet desconhecido';
                        return "• {$med->nome} para {$petName} - {$status}" . ($med->quando ? " (due: {$med->quando->format('d/m/Y H:i')})" : "");
                    })->implode("\n");
                }),

            Tool::as('create_medication')
                ->for('Add a new medication or reminder for a pet')
                ->withStringParameter('pet_name', 'The name of the pet')
                ->withStringParameter('medication_name', 'The name of the medication')
                ->withOptionalStringParameter('scheduled_time', 'When to take the medication (ISO 8601 format)')
                ->withOptionalStringParameter('notes', 'Any additional notes')
                ->using(function (string $petName, string $medicationName, ?string $scheduledTime = null, ?string $notes = null) use ($user, $petModel, $medicacaoModel) {
                    $pet = $petModel::where('user_id', $user->id)
                        ->where('nome', 'like', "%{$petName}%")
                        ->first();

                    if (!$pet) {
                        return "Pet não encontrado. Use list_pets para ver seus pets.";
                    }

                    $medicacao = $medicacaoModel::create([
                        'pet_id' => $pet->id,
                        'user_id' => $user->id,
                        'nome' => $medicationName,
                        'quando' => $scheduledTime ? \Carbon\Carbon::parse($scheduledTime) : now()->addHour(),
                        'completado' => false,
                    ]);

                    return "Adicionei {$medicationName} como lembrete para {$petName}!" . ($scheduledTime ? " Agendado para {$scheduledTime}" : " Agendado para 1 hora a partir de agora");
                }),

            Tool::as('get_upcoming_medications')
                ->for('Get upcoming medication reminders for the next 24 hours')
                ->using(function () use ($user, $medicacaoModel) {
                    $meds = $medicacaoModel::where('user_id', $user->id)
                        ->where('completado', false)
                        ->where('quando', '>=', now())
                        ->where('quando', '<=', now()->addDay())
                        ->with('pet')
                        ->orderBy('quando')
                        ->get();

                    if ($meds->isEmpty()) {
                        return "Nenhum medicamento próximo nas próximas 24 horas.";
                    }

                    return $meds->map(function ($med) {
                        $petName = $med->pet?->nome ?? 'Desconhecido';
                        $time = $med->quando->format('d/m/Y H:i');
                        return "• {$med->nome} para {$petName} às {$time}";
                    })->implode("\n");
                }),
        ];
    }
}