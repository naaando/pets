<?php

use App\Models\Pet;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\patchJson;

it('can update pet', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $petData = Pet::factory()->make()->toArray();
    $response = patchJson("/api/pets/$pet->id", $petData);

    $response->assertStatus(200);
});
