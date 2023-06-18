<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;

class PetRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        $pet = $this->route('pet');
        return Gate::allows('save', $pet ?? Pet::class);
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
            'imagem' => 'string',
            'user_id' => 'required|exists:users,id',
            'espaco_id' => 'exists:espacos,id',
            'especie_id' => 'exists:especies,id',
            'raca' => 'string',
            'sexo' => 'in:macho,femea',
            'nascimento' => 'date',
            'falecimento' => 'date',
            'castracao' => 'date',
        ];
    }
}
