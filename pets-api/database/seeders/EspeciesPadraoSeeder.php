<?php

namespace Database\Seeders;

use App\Models\Especie;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class EspeciesPadraoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Especie::firstOrCreate([
            'id' => 'cachorro',
            'nome' => 'Cachorro',
        ]);

        Especie::firstOrCreate([
            'id' => 'gato',
            'nome' => 'Gato',
        ]);

        Especie::firstOrCreate([
            'id' => 'peixe',
            'nome' => 'Peixe',
        ]);

        Especie::firstOrCreate([
            'id' => 'passaro',
            'nome' => 'Pássaro',
        ]);

        Especie::firstOrCreate([
            'id' => 'roedor',
            'nome' => 'Roedor',
        ]);

        Especie::firstOrCreate([
            'id' => 'reptil',
            'nome' => 'Réptil',
        ]);
    }
}
