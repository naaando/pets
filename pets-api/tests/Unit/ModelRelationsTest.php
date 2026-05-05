<?php

use App\Models\Espaco;
use App\Models\Especie;
use App\Models\Medicacao;
use App\Models\Pet;
use App\Models\User;

test('pet pertence a usuario', function () {
    $user = User::factory()->create();
    $pet = Pet::factory()->for($user)->create();

    expect($pet->user->id)->toBe($user->id);
});

test('pet pertence a especie', function () {
    $especie = Especie::factory()->create();
    $pet = Pet::factory()->for($especie)->create();

    expect($pet->especie->id)->toBe($especie->id);
});

test('pet pertence a espaco', function () {
    $espaco = Espaco::factory()->create();
    $pet = Pet::factory()->for($espaco)->create();

    expect($pet->espaco->id)->toBe($espaco->id);
});

test('pet tem medicacoes', function () {
    $pet = Pet::factory()->create();
    Medicacao::factory()->for($pet)->count(3)->create();

    expect($pet->medicacoes)->toHaveCount(3);
});

test('medicacao pertence a pet', function () {
    $pet = Pet::factory()->create();
    $medicacao = Medicacao::factory()->for($pet)->create();

    expect($medicacao->pet->id)->toBe($pet->id);
});

test('medicacao pertence a usuario', function () {
    $user = User::factory()->create();
    $medicacao = Medicacao::factory()->for($user)->create();

    expect($medicacao->user->id)->toBe($user->id);
});

test('especie tem pets', function () {
    $especie = Especie::factory()->create();
    Pet::factory()->for($especie)->count(2)->create();

    expect($especie->pets)->toHaveCount(2);
});

test('espaco tem pets', function () {
    $espaco = Espaco::factory()->create();
    Pet::factory()->for($espaco)->count(2)->create();

    expect($espaco->pets)->toHaveCount(2);
});

test('espaco tem usuarios', function () {
    $espaco = Espaco::factory()->create();
    $user1 = User::factory()->create();
    $user2 = User::factory()->create();
    $espaco->users()->attach([$user1->id, $user2->id]);

    expect($espaco->users)->toHaveCount(2);
});

test('usuario tem pets compartilhados via espaco', function () {
    $user = User::factory()->create();
    Pet::factory()->for($user->espacoAtivo)->count(3)->create();

    expect($user->petsCompartilhados)->toHaveCount(3);
});

test('usuario tem meus pets', function () {
    $user = User::factory()->create();
    Pet::factory()->for($user)->count(2)->create();

    expect($user->meusPets)->toHaveCount(2);
});

test('medicacao tem total doses', function () {
    $medicacao = Medicacao::factory()->create();

    expect($medicacao->total_doses)->toBeInt();
});

test('pet usa soft deletes', function () {
    $pet = Pet::factory()->create();
    $petId = $pet->id;

    $pet->delete();

    expect(Pet::find($petId))->toBeNull();
    expect(Pet::withTrashed()->find($petId))->not->toBeNull();
});
