<?php

use function Pest\Laravel\actingAs;
use function Pest\Laravel\getJson;

test('empty list', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $response = getJson('/api/pets');
    $response->assertStatus(200);
    $response->isEmpty();
});
