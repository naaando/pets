<?php

namespace Database\Factories;

use App\Models\Espaco;
use App\Models\Especie;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\=Pet>
 */
class PetFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'nome' => $this->faker->name,
            'imagem' => $this->faker->imageUrl(),
            'user_id' => User::factory(),
            'espaco_id' => Espaco::factory(),
            'especie_id' => Especie::factory(),
            'sexo' => $this->faker->randomElement(['macho', 'femea']),
            'raca' => $this->faker->randomElement(['SRD', 'Poodle', 'Vira-lata']),
            'nascimento' => $this->faker->dateTimeBetween('-10 years', '-1 year'),
            'falecimento' => $this->faker->dateTimeBetween('-1 year', 'now'),
            'castracao' => $this->faker->dateTimeBetween('-1 year', 'now'),
            'atributos' => [
                'cor' => $this->faker->randomElement(['preto', 'branco', 'marrom']),
                'pelagem' => $this->faker->randomElement(['curta', 'longa']),
                'porte' => $this->faker->randomElement(['pequeno', 'medio', 'grande']),
                'temperamento' => $this->faker->randomElement(['calmo', 'agressivo', 'brincalhao']),
            ],
        ];
    }
}
