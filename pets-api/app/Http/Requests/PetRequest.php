<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PetRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->espacos->contains($this->input('espaco_id'));
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array|string>
     */
    public function rules(): array
    {
        return [
            'nome' => 'required|string',
            'imagem' => 'nullable|string',
            'espaco_id' => 'required|exists:espacos,id',
            'especie_id' => 'nullable|exists:especies,id',
            'raca' => 'nullable|string',
            'sexo' => 'nullable|in:macho,femea',
            'nascimento' => 'nullable|date',
            'falecimento' => 'nullable|date',
            'castracao' => 'nullable|date',
            'mae_id' => 'nullable|exists:pets,id',
            'pai_id' => 'nullable|exists:pets,id',
        ];
    }
}
