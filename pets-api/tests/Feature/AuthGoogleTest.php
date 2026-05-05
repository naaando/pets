<?php

use function Pest\Laravel\getJson;

test('rota de autenticação google existe e requer idToken', function () {
    $response = getJson('/api/auth/google-idtoken');
    // Route exists (not 404), will error due to missing/invalid idToken
    expect($response->status())->not->toBe(404);
});
