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
        Especie::create([
            'id' => 'cachorro',
            'nome' => 'Cachorro',
        ]);

        Especie::create([
            'id' => 'gato',
            'nome' => 'Gato',
        ]);
    }
}
