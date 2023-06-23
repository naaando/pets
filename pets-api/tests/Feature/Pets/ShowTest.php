<?php

use App\Models\Pet;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\getJson;

test('prohibit unlogged pet access', function () {
    $pet = Pet::factory()->create();
    $response = getJson("/api/pets/$pet->id");
    $response->assertStatus(401);
});


test('access pet with any user', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->create();
    $response = getJson("/api/pets/$pet->id");
    $response->assertStatus(200);
});
