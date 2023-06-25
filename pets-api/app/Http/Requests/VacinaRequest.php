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
        $vacina = $this->route('vacina');
        $pet = Pet::findOrFail($this->input('pet_id'));
        return $this->user()->can('update-vacine', $pet, $vacina);
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
            'nome' => 'required|string',
            'fabricante' => 'required|string',
            'veterinario' => 'required|string',
            'data' => 'required|date',
        ];
    }
}
