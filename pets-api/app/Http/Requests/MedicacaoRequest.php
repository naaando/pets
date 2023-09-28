<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class MedicacaoRequest extends FormRequest
{
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
            'fabricante' => 'prohibited',
            'veterinario' => 'prohibited',
            'quando' => 'required|date',
            'completado' => 'required|boolean',
            'atributos' => 'nullable|array',
        ];
    }

    public function messages()
    {
        return [
            'fabricante.prohibited' => 'Use os atributos.',
            'veterinario.prohibited' => 'Use os atributos.',
        ];
    }
}
