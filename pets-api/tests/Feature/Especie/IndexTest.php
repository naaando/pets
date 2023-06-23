<?php

use function Pest\Laravel\actingAs;
use function Pest\Laravel\getJson;

it('can list all especies', function () {
    actingAs($user = \App\Models\User::factory()->create());
    $response = getJson('api/especies');
    $response->assertStatus(200);
});
