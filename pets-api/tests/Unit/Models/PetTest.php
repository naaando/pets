<?php

use App\Models\Pet;
use function PHPUnit\Framework\assertEquals;

/**
 * Cobre fillable e cast da prop atributo "atributos" do modelo Pet.
 */
test('consigo ler e escrever atributos', function () {
    $pet = Pet::factory()->create();

    $pet->fill([
        'atributos' => [
            'cor' => 'preto',
            'pelagem' => 'curta',
            'porte' => 'pequeno',
            'temperamento' => 'calmo',
        ],
    ]);

    assertEquals($pet->atributos, [
        'cor' => 'preto',
        'pelagem' => 'curta',
        'porte' => 'pequeno',
        'temperamento' => 'calmo',
    ]);
});
