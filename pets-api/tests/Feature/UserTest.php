<?php

use App\Models\User;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\getJson;

test('proibe usuário não autenticado', function () {
    getJson('/api/user')->assertStatus(401);
});

test('retorna dados do usuário autenticado', function () {
    actingAs($user = User::factory()->create());

    $response = getJson('/api/user');

    $response->assertOk();
    $response->assertJsonFragment([
        'name' => $user->name,
        'email' => $user->email,
    ]);
});

test('retorna espaço ativo do usuário', function () {
    actingAs($user = User::factory()->create());

    $response = getJson('/api/user');

    $response->assertOk();
    $response->assertJsonPath('data.espaco_ativo.nome', 'Meu espaço');
});
