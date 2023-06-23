<?php

use App\Models\Pet;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\deleteJson;

it('can destroy pet', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->create();
    $response = deleteJson("/api/pets/$pet->id");

    $response->assertStatus(200);
});
