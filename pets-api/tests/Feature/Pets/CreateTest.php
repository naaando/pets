<?php

use App\Models\Pet;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\postJson;

it('can create pet', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $petData = Pet::factory()->make();
    $response = postJson('/api/pets', $petData->toArray());

    $response->assertStatus(201);
});
