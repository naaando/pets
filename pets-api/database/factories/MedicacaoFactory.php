<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Medicacao>
 */
class MedicacaoFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'nome' => $this->faker->word,
            'completado' => $this->faker->boolean,
            'atributos' => [
                'fabricante' => $this->faker->company,
                'veterinario' => $this->faker->name(),
            ],
            'quando' => $this->faker->dateTime,
            'tipo' => $this->faker->randomElement(['vacina', 'vermifugo', 'medicacao']),
        ];
    }
}
