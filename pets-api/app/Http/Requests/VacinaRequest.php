<?php

namespace App\Http\Requests;

use App\Models\Pet;
use Illuminate\Foundation\Http\FormRequest;

class VacinaRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        if ($vacina = $this->route('vacina')) {
            return $this->user()->can('update-vacine', $vacina);
        }

        $pet = Pet::findOrFail($this->input('pet_id'));
        return $this->user()->can('create-vacine', $pet);
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array|string>
     */
    public function rules(): array
    {
        if ($this->route('vacina')) {
            return [
                'nome' => 'required|string',
                'fabricante' => 'required|string',
                'veterinario' => 'required|string',
                'data' => 'required|date',
            ];
        }

        return [
            'pet_id' => 'required|exists:pets,id',
            'nome' => 'required|string',
            'fabricante' => 'required|string',
            'veterinario' => 'required|string',
            'data' => 'required|date',
        ];
    }
}
