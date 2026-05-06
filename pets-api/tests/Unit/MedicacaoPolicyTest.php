<?php

use App\Models\Medicacao;
use App\Models\Pet;
use App\Models\User;
use App\Policies\MedicacaoPolicy;

test('permite visualizar medicação própria', function () {
    $policy = new MedicacaoPolicy();
    $user = User::factory()->create();
    $pet = Pet::factory()->for($user->espacoAtivo)->create();
    $medicacao = Medicacao::factory()->for($pet)->for($user)->create();

    expect($policy->view($user, $medicacao))->toBeTrue();
});

test('proíbe visualizar medicação alheia', function () {
    $policy = new MedicacaoPolicy();
    $user = User::factory()->create();
    $otherUser = User::factory()->create();
    $pet = Pet::factory()->create();
    $medicacao = Medicacao::factory()->for($pet)->for($otherUser)->create();

    expect($policy->view($user, $medicacao))->toBeFalse();
});

test('permite atualizar medicação própria', function () {
    $policy = new MedicacaoPolicy();
    $user = User::factory()->create();
    $pet = Pet::factory()->for($user->espacoAtivo)->create();
    $medicacao = Medicacao::factory()->for($pet)->for($user)->create();

    expect($policy->update($user, $medicacao))->toBeTrue();
});

test('permite deletar medicação própria', function () {
    $policy = new MedicacaoPolicy();
    $user = User::factory()->create();
    $pet = Pet::factory()->for($user->espacoAtivo)->create();
    $medicacao = Medicacao::factory()->for($pet)->for($user)->create();

    expect($policy->delete($user, $medicacao))->toBeTrue();
});

test('proíbe restaurar e forçar deleção', function () {
    $policy = new MedicacaoPolicy();
    $user = User::factory()->create();
    $pet = Pet::factory()->for($user->espacoAtivo)->create();
    $medicacao = Medicacao::factory()->for($pet)->for($user)->create();

    expect($policy->restore($user, $medicacao))->toBeFalse();
    expect($policy->forceDelete($user, $medicacao))->toBeFalse();
});
