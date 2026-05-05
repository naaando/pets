<?php

use App\Models\Espaco;
use App\Models\User;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\deleteJson;
use function Pest\Laravel\getJson;
use function Pest\Laravel\postJson;
use function Pest\Laravel\putJson;

test('proibe usuário não autenticado', function () {
    getJson('/api/espacos')->assertStatus(401);
    postJson('/api/espacos')->assertStatus(401);
});

test('consegue listar espaços do usuário', function () {
    actingAs($user = User::factory()->create());

    $response = getJson('/api/espacos');

    $response->assertOk();
    $response->assertJsonCount(1, 'data');
});

test('consegue visualizar um espaço', function () {
    actingAs($user = User::factory()->create());

    $espaco = $user->espacoAtivo;

    $response = getJson("/api/espacos/{$espaco->id}");

    $response->assertOk();
    $response->assertJsonFragment(['nome' => $espaco->nome]);
});

test('consegue criar múltiplos espaços', function () {
    actingAs($user = User::factory()->create());

    $espaco = Espaco::factory()->create();
    $user->espacos()->attach($espaco);

    $response = getJson('/api/espacos');

    $response->assertOk();
    $response->assertJsonCount(2, 'data');
});
