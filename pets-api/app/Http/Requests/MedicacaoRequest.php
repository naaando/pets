<?php

namespace App\Http\Requests;

use App\Models\Pet;
use Illuminate\Foundation\Http\FormRequest;

class MedicacaoRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        $medicacao = $this->route('medicacao');
        $pet = Pet::findOrFail($this->input('pet_id'));
        return $this->user()->can('update-medicacao', $pet, $medicacao);
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array|string>
     */
    public function rules(): array
    {
        return [
            'user_id' => 'prohibited',
            'pet_id' => 'required|exists:pets,id',
            'inicial_id' => 'nullable|exists:medicacoes,id',
            'antecessora_id' => 'nullable|required_with:inicial_id|exists:medicacoes,id',
            'tipo' => 'required|string|in:vacina,vermifugo,medicacao',
            'nome' => 'required|string',
            'fabricante' => 'nullable|string',
            'veterinario' => 'nullable|string',
            'quando' => 'required|date',
            'completado' => 'required|boolean',
            'atributos' => 'nullable|array',
        ];
    }
}
