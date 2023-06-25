<?php

use App\Models\Pet;
use App\Models\PetVacina;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\deleteJson;
use function Pest\Laravel\getJson;
use function Pest\Laravel\patchJson;
use function Pest\Laravel\postJson;

test('consegue listar vacinas do animal', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->for($user)->create();

    $pet->vacinas()->createMany(
        PetVacina::factory()->for($user)->count(3)->make()->toArray()
    );

    $response = $this->get("/api/pets/$pet->id/vacinas");
    $response->assertStatus(200);
    $response->assertJsonCount(3, 'data');

    $response->assertJsonStructure([
        'data' => [
            '*' => [
                'id',
                'nome',
                'fabricante',
                'veterinario',
                'data',
                'user_id',
                'created_at',
                'updated_at',
            ],
        ],
    ]);
});

test('consegue criar a vacina do animal', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $vacinaData = PetVacina::factory()->make()->toArray();

    $response = postJson("/api/pets/$pet->id/vacinas", $vacinaData);

    $response->assertStatus(201);
});

test('consegue atualizar a vacina de um animal próprio', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $vacina = PetVacina::factory()->for($user)->for($pet)->create();
    $vacinaData = PetVacina::factory()->make()->toArray();

    $response = patchJson("/api/pets/$pet->id/vacinas/$vacina->id", $vacinaData);

    $response->assertStatus(200);
});

test('consegue remover a vacina de um animal próprio', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $vacina = PetVacina::factory()->for($user)->for($pet)->create();

    $response = deleteJson("/api/pets/$pet->id/vacinas/$vacina->id");

    $response->assertStatus(204);
});
