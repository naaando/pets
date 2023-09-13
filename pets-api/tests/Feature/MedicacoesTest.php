<?php

use App\Models\Pet;
use App\Models\User;
use App\Models\Medicacao;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\deleteJson;
use function Pest\Laravel\getJson;
use function Pest\Laravel\patchJson;
use function Pest\Laravel\postJson;

test('consegue listar medicacoes dos animais do usuário', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user)->create();

    Medicacao::factory()->for($user)->for($pet)->count(3)->create();
    Medicacao::factory()->for(User::factory())->for($pet)->count(3)->create();

    $response = getJson("/api/medicacoes");
    $response->assertStatus(200);
    $response->assertJsonCount(3, 'data');

    $response->assertJsonStructure([
        'data' => [
            '*' => [
                'id',
                'nome',
                'fabricante',
                'veterinario',
                'quando',
                'user_id',
                'pet_id',
                'created_at',
                'updated_at',
            ],
        ],
    ]);
});

test('consegue criar a medicacao do animal', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $medicacaoData = Medicacao::factory()->for($pet)->make()->toArray();

    $response = postJson("/api/medicacoes", $medicacaoData);

    $response->assertStatus(201);
});

test('consegue atualizar a medicacao de um animal próprio', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $medicacao = Medicacao::factory()->for($user)->for($pet)->create();
    $medicacaoData = Medicacao::factory()->for($pet)->make()->toArray();

    $response = patchJson("/api/medicacoes/$medicacao->id", $medicacaoData);

    $response->assertStatus(200);
});

test('consegue remover a medicacao de um animal próprio', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $medicacao = Medicacao::factory()->for($user)->for($pet)->create();

    $response = deleteJson("/api/medicacoes/$medicacao->id");

    $response->assertStatus(204);
});

test('impede de atualizar a medicacao de um animal alheio', function () {
    actingAs($user = User::factory()->create());
    $outroUsuario = User::factory();

    $pet = Pet::factory()->for($outroUsuario)->create();
    $medicacao = Medicacao::factory()->for($outroUsuario)->for($pet)->create();
    $medicacaoData = Medicacao::factory()->for($pet)->make()->toArray();

    $response = patchJson("/api/medicacoes/$medicacao->id", $medicacaoData);

    $response->assertStatus(403);
});

test('filtra medicacoes de pets removidos', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    Medicacao::factory()->for($user)->for($pet)->create();

    $pet->delete();

    $response = getJson("/api/medicacoes");
    $response->assertStatus(200);
    $response->assertJsonCount(0, 'data');
});
