<?php

use function Pest\Laravel\getJson;

it('can list all especies', function () {
    $response = getJson('api/especies');
    $response->assertStatus(200);
});
