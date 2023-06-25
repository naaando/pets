<?php

use App\Models\Pet;
use App\Models\User;
use App\Models\Vacina;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\deleteJson;
use function Pest\Laravel\getJson;
use function Pest\Laravel\patchJson;
use function Pest\Laravel\postJson;
use function PHPUnit\Framework\assertEquals;

test('consegue listar vacinas dos animais do usuário', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user)->create();

    Vacina::factory()->for($user)->for($pet)->count(3)->create();
    Vacina::factory()->for(User::factory())->for($pet)->count(3)->create();

    $response = getJson("/api/vacinas");
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
                'pet_id',
                'created_at',
                'updated_at',
            ],
        ],
    ]);
});

test('consegue criar a vacina do animal', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $vacinaData = Vacina::factory()->for($pet)->make()->toArray();

    $response = postJson("/api/vacinas", $vacinaData);

    $response->assertStatus(201);
});

test('consegue atualizar a vacina de um animal próprio', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $vacina = Vacina::factory()->for($user)->for($pet)->create();
    $vacinaData = Vacina::factory()->for($pet)->make()->toArray();

    $response = patchJson("/api/vacinas/$vacina->id", $vacinaData);

    $response->assertStatus(200);
});

test('consegue remover a vacina de um animal próprio', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $vacina = Vacina::factory()->for($user)->for($pet)->create();

    $response = deleteJson("/api/vacinas/$vacina->id");

    $response->assertStatus(204);
});

test('impede de atualizar a vacina de um animal alheio', function () {
    actingAs($user = User::factory()->create());
    $outroUsuario = User::factory();

    $pet = Pet::factory()->for($outroUsuario)->create();
    $vacina = Vacina::factory()->for($outroUsuario)->for($pet)->create();
    $vacinaData = Vacina::factory()->for($pet)->make()->toArray();

    $response = patchJson("/api/vacinas/$vacina->id", $vacinaData);

    $response->assertStatus(403);
});
