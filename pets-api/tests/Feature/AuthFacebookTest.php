<?php

use App\Models\User;
use Illuminate\Support\Facades\Http;

use function Pest\Laravel\postJson;

test('autentica com facebook e cria usuário novo', function () {
    Http::fake([
        'graph.facebook.com/*' => Http::response([
            'id' => '123456',
            'name' => 'Facebook User',
            'email' => 'fb-test@example.com',
            'picture' => ['data' => ['url' => 'https://example.com/pic.jpg']],
        ]),
    ]);

    $response = postJson('/api/auth/facebook', [
        'token' => 'fake-access-token',
        'device_name' => 'test-device',
    ]);

    $response->assertOk();

    $this->assertDatabaseHas('users', [
        'email' => 'fb-test@example.com',
        'name' => 'Facebook User',
        'iss' => 'facebook',
    ]);
});

test('autentica com facebook e retorna usuário existente', function () {
    $user = User::factory()->create(['email' => 'existing@example.com']);

    Http::fake([
        'graph.facebook.com/*' => Http::response([
            'id' => '789',
            'name' => 'Existing User',
            'email' => 'existing@example.com',
            'picture' => ['data' => ['url' => 'https://example.com/pic.jpg']],
        ]),
    ]);

    $response = postJson('/api/auth/facebook', [
        'token' => 'fake-access-token',
    ]);

    $response->assertOk();

    // Should not create a duplicate user
    $this->assertDatabaseCount('users', 1);
});
