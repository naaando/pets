<?php

use App\Models\User;
use Prism\Prism\Facades\Prism;
use Prism\Prism\Testing\TextResponseFake;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\postJson;

test('proibe usuário não autenticado', function () {
    postJson('/api/chat', ['message' => 'oi'])->assertStatus(401);
    postJson('/api/chat/stream', ['message' => 'oi'])->assertStatus(401);
});

test('requer mensagem', function () {
    actingAs(User::factory()->create());

    postJson('/api/chat', [])->assertStatus(422);
    postJson('/api/chat', ['message' => ''])->assertStatus(422);
});

test('responde ao chat', function () {
    Prism::fake([
        TextResponseFake::make()->withText('Olá! Posso ajudar com seus pets!'),
    ]);

    actingAs(User::factory()->create());

    $response = postJson('/api/chat', ['message' => 'oi']);

    $response->assertOk();
    $response->assertJsonStructure(['response', 'tool_calls']);
    $response->assertJsonFragment(['response' => 'Olá! Posso ajudar com seus pets!']);
});

test('stream requer mensagem', function () {
    actingAs(User::factory()->create());

    postJson('/api/chat/stream', [])->assertStatus(422);
});
