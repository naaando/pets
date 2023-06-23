<?php

use App\Models\Especie;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\deleteJson;
use function Pest\Laravel\getJson;
use function Pest\Laravel\patchJson;
use function Pest\Laravel\postJson;

test('proibe usuário não autenticado', function () {
    getJson('api/especies')->assertStatus(401);
});

test('não existem rotas de criação, edição, exibição e remoção', function () {
    actingAs($user = \App\Models\User::factory()->create());

    getJson('api/especies/1')->assertStatus(404);
    postJson('api/especies')->assertStatus(405);
    patchJson('api/especies/1')->assertStatus(404);
    deleteJson('api/especies/1')->assertStatus(404);
});

test('consegue listar coleção de especies', function () {
    actingAs($user = \App\Models\User::factory()->create());
    Especie::factory()->count(10)->create();
    $response = getJson('api/especies');
    $response->assertStatus(200);
    $response->assertJsonCount(10, 'data');
});
