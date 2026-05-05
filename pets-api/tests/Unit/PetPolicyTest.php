<?php

use App\Models\Espaco;
use App\Models\Pet;
use App\Models\User;
use App\Policies\PetPolicy;

test('permite visualizar pet do mesmo espaço', function () {
    $policy = new PetPolicy();
    $user = User::factory()->create();
    $pet = Pet::factory()->for($user->espacoAtivo)->create();

    expect($policy->view($user, $pet))->toBeTrue();
});

test('proíbe visualizar pet de espaço diferente', function () {
    $policy = new PetPolicy();
    $user = User::factory()->create();
    $pet = Pet::factory()->create();

    expect($policy->view($user, $pet))->toBeFalse();
});

test('permite atualizar pet do mesmo espaço', function () {
    $policy = new PetPolicy();
    $user = User::factory()->create();
    $pet = Pet::factory()->for($user->espacoAtivo)->create();

    expect($policy->update($user, $pet))->toBeTrue();
});

test('proíbe atualizar pet de espaço diferente', function () {
    $policy = new PetPolicy();
    $user = User::factory()->create();
    $pet = Pet::factory()->create();

    expect($policy->update($user, $pet))->toBeFalse();
});

test('permite deletar pet do mesmo espaço', function () {
    $policy = new PetPolicy();
    $user = User::factory()->create();
    $pet = Pet::factory()->for($user->espacoAtivo)->create();

    expect($policy->delete($user, $pet))->toBeTrue();
});

test('proíbe restaurar e forçar deleção', function () {
    $policy = new PetPolicy();
    $user = User::factory()->create();
    $pet = Pet::factory()->for($user->espacoAtivo)->create();

    expect($policy->restore($user, $pet))->toBeFalse();
    expect($policy->forceDelete($user, $pet))->toBeFalse();
});

test('permite criar e visualizar todos', function () {
    $policy = new PetPolicy();
    $user = User::factory()->create();

    expect($policy->viewAny($user))->toBeTrue();
    expect($policy->create($user))->toBeTrue();
});
