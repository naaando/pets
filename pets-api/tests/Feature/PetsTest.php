<?php

use App\Models\Espaco;
use App\Models\Pet;

use App\Models\User;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\assertDatabaseHas;
use function Pest\Laravel\deleteJson;
use function Pest\Laravel\getJson;
use function Pest\Laravel\patchJson;
use function Pest\Laravel\postJson;
use function PHPUnit\Framework\assertTrue;

test('proibe usuário não autenticado', function () {
    getJson("/api/pets")->assertStatus(401);
    getJson("/api/pets/1")->assertStatus(401);
    postJson("/api/pets")->assertStatus(401);
    patchJson("/api/pets/1")->assertStatus(401);
    deleteJson("/api/pets/1")->assertStatus(401);
});

test('proibe listar animal alheio', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->create();
    $response = getJson("/api/pets/$pet->id");

    $response->assertForbidden();
});

test('proibe atualização de animal alheio', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->create();
    $petData = Pet::factory()->make()->toArray();
    $response = patchJson("/api/pets/$pet->id", $petData);

    $response->assertForbidden();
});

test('proibe remover um animal alheio', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->create();
    $response = deleteJson("/api/pets/$pet->id");

    $response->assertForbidden();
});

test('consegue listar coleção de animais', function () {
    actingAs($user = User::factory()->create());

    Pet::factory()->for($user->espacoAtivo)->count(10)->create();

    $response = getJson('/api/pets');
    $response->assertOk();
    $response->assertJsonCount(10, 'data');
});

test('o retorno da coleção filtra animais alheios corretamente', function () {
    actingAs($user = User::factory()->create());

    Pet::factory()->for($user->espacoAtivo)->count(1)->create();
    Pet::factory()->count(10)->create();

    $response = getJson('/api/pets');
    $response->assertOk();
    $response->assertJsonCount(1, 'data');
});

test('consegue listar meu animal', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user->espacoAtivo)->create();
    $response = getJson("/api/pets/$pet->id");
    $response->assertOk();
});

test('consegue criar um animal', function () {
    actingAs($user = User::factory()->has(Espaco::factory())->create());

    $petData = Pet::factory([
        'espaco_id' => $user->espacoAtivo->id,
    ])->make();


    $response = postJson('/api/pets', $petData->toArray());

    $response->assertCreated();

    // Garante que está salvando user_id quando cria
    assertDatabaseHas('pets', $user->meusPets()->first()->toArray());
    assertDatabaseHas('pets', $user->petsCompartilhados()->first()->makeHidden('pivot')->toArray());
});

test('consegue atualizar animal próprio', function () {
    actingAs($user = User::factory()->has(Espaco::factory())->create());

    $pet = Pet::factory([
        'espaco_id' => $user->espacoAtivo->id,
    ])->for($user->espacoAtivo)->create();

    $petData = Pet::factory([
        'espaco_id' => $user->espacoAtivo->id,
    ])->make()->toArray();

    $response = patchJson("/api/pets/$pet->id", $petData);

    $response->assertOk();
});

test('consegue remover um animal próprio', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user->espacoAtivo)->create();
    $response = deleteJson("/api/pets/$pet->id");

    $response->assertOk();
});

test('consegue listar coleção de animais do mesmo espaco', function () {
    $outroMembroDoEspaco = User::factory()->create();
    actingAs($user = User::factory()->create());
    $user->espacos()->save($outroMembroDoEspaco->espacoAtivo);

    Pet::factory()->for($outroMembroDoEspaco->espacoAtivo)->count(5)->create();

    Pet::factory()->for($user->espacoAtivo)->count(5)->create();

    $outroMembro = User::factory()->create();
    Pet::factory()->for($outroMembro->espacoAtivo)->count(5)->create();

    $response = getJson('/api/pets');
    $response->assertOk();
    $response->assertJsonCount(10, 'data');
});

test('consegue listar o animal de outro membro do mesmo espaco_id', function () {
    $outroMembroDoEspaco = User::factory()->create();
    $pet = Pet::factory()->for($outroMembroDoEspaco)->create();

    $user = User::factory()->create();
    $user->espacos()->save($pet->espaco);
    assertTrue($user->espacos->contains($pet->espaco));

    actingAs($user);

    $response = getJson("/api/pets/$pet->id");
    $response->assertOk();
});

test('não consegue listar o animal de outro membro de espaco_id diferente', function () {
    $outroMembroDoEspaco = User::factory()->create();
    $pet = Pet::factory()->for($outroMembroDoEspaco)->create();

    actingAs(User::factory()->create());

    $response = getJson("/api/pets/$pet->id");
    $response->assertForbidden();
});
