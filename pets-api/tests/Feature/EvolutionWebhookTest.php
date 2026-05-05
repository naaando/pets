<?php

use App\Models\User;
use Illuminate\Support\Facades\Http;
use Prism\Prism\Facades\Prism;
use Prism\Prism\Testing\TextResponseFake;

use function Pest\Laravel\postJson;

beforeEach(function () {
    config([
        'services.evolution.webhook_key' => 'test-webhook-key',
        'services.evolution.base_url' => 'https://evolution.test',
        'services.evolution.key' => 'test-api-key',
    ]);
});

test('rejeita webhook sem chave de autenticação', function () {
    $response = postJson('/api/webhooks/evolution/test-instance', [
        'event' => 'MESSAGES_UPSERT',
    ]);

    $response->assertStatus(401);
});

test('rejeita webhook com chave inválida', function () {
    $response = postJson('/api/webhooks/evolution/test-instance', [
        'event' => 'MESSAGES_UPSERT',
    ], [
        'x-webhook-key' => 'wrong-key',
    ]);

    $response->assertStatus(401);
});

test('aceita webhook com chave válida', function () {
    $response = postJson('/api/webhooks/evolution/test-instance', [
        'event' => 'CONNECTION_UPDATE',
        'data' => ['status' => 'open'],
    ], [
        'x-webhook-key' => 'test-webhook-key',
    ]);

    $response->assertOk();
    $response->assertJson(['status' => 'ok']);
});

test('ignora mensagens do próprio bot', function () {
    Http::fake();

    $response = postJson('/api/webhooks/evolution/test-instance', [
        'event' => 'MESSAGES_UPSERT',
        'data' => [
            'messages' => [
                [
                    'fromMe' => true,
                    'key' => ['remoteJid' => '5511999999999@s.whatsapp.net'],
                    'message' => ['conversation' => 'hello'],
                ],
            ],
        ],
    ], [
        'x-webhook-key' => 'test-webhook-key',
    ]);

    $response->assertOk();
    Http::assertNothingSent();
});

test('responde usuário não encontrado para telefone desconhecido', function () {
    Http::fake();

    $response = postJson('/api/webhooks/evolution/test-instance', [
        'event' => 'MESSAGES_UPSERT',
        'data' => [
            'messages' => [
                [
                    'key' => ['remoteJid' => '5511000000000@s.whatsapp.net'],
                    'message' => ['conversation' => 'oi'],
                ],
            ],
        ],
    ], [
        'x-webhook-key' => 'test-webhook-key',
    ]);

    $response->assertOk();
    Http::assertSent(function ($request) {
        $body = json_decode($request->body(), true);
        return str_contains($body['text'] ?? '', 'não encontrado');
    });
});

test('ignora mensagens que começam com /', function () {
    Http::fake();

    $response = postJson('/api/webhooks/evolution/test-instance', [
        'event' => 'MESSAGES_UPSERT',
        'data' => [
            'messages' => [
                [
                    'key' => ['remoteJid' => '5511999999999@s.whatsapp.net'],
                    'message' => ['conversation' => '/start'],
                ],
            ],
        ],
    ], [
        'x-webhook-key' => 'test-webhook-key',
    ]);

    $response->assertOk();
    Http::assertNothingSent();
});

test('lida com eventos desconhecidos sem erro', function () {
    $response = postJson('/api/webhooks/evolution/test-instance', [
        'event' => 'UNKNOWN_EVENT',
    ], [
        'x-webhook-key' => 'test-webhook-key',
    ]);

    $response->assertOk();
});

test('ignora mensagens sem texto', function () {
    Http::fake();

    $response = postJson('/api/webhooks/evolution/test-instance', [
        'event' => 'MESSAGES_UPSERT',
        'data' => [
            'messages' => [
                [
                    'key' => ['remoteJid' => '5511999999999@s.whatsapp.net'],
                    'message' => ['imageMessage' => ['some' => 'image']],
                ],
            ],
        ],
    ], [
        'x-webhook-key' => 'test-webhook-key',
    ]);

    $response->assertOk();
    Http::assertNothingSent();
});
