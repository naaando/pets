<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\PetVacina>
 */
class PetVacinaFactory extends Factory
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
            'fabricante' => $this->faker->company,
            'veterinario' => $this->faker->name(),
            'data' => $this->faker->dateTime,
        ];
    }
}
