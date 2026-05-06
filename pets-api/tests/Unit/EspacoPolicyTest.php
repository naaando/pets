<?php

use App\Models\Espaco;
use App\Models\User;
use App\Policies\EspacoPolicy;

test('espaco policy permite tudo para qualquer usuário', function () {
    $policy = new EspacoPolicy();
    $user = User::factory()->create();
    $espaco = Espaco::factory()->create();

    expect($policy->viewAny($user))->toBeTrue();
    expect($policy->view($user, $espaco))->toBeTrue();
    expect($policy->create($user))->toBeTrue();
    expect($policy->update($user, $espaco))->toBeTrue();
    expect($policy->delete($user, $espaco))->toBeTrue();
    expect($policy->restore($user, $espaco))->toBeFalse();
    expect($policy->forceDelete($user, $espaco))->toBeFalse();
});
