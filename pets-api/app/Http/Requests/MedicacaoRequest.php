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
            'tipo' => 'required|string|in:vacina,vermifugo,medicacao',
            'nome' => 'required|string',
            'fabricante' => 'optional|nullable|string',
            'veterinario' => 'optional|nullable|string',
            'quando' => 'required|date',
            // 'total_doses' => 'required|integer|gte:1|gte:dose_atual',
            // 'dose_atual' => 'required|integer|gte:1|lte:total_doses',
            'proxima_dose' => 'optional|nullable|date|after:quando|after_or_equal:today',
        ];
    }
}
