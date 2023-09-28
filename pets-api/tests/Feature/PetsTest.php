<?php

use App\Models\Pet;

use App\Models\User;
use function Pest\Laravel\actingAs;
use function Pest\Laravel\deleteJson;
use function Pest\Laravel\getJson;
use function Pest\Laravel\patchJson;
use function Pest\Laravel\postJson;

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

    $response->assertStatus(403);
});

test('proibe atualização de animal alheio', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->create();
    $petData = Pet::factory()->make()->toArray();
    $response = patchJson("/api/pets/$pet->id", $petData);

    $response->assertStatus(403);
});

test('proibe remover um animal alheio', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->create();
    $response = deleteJson("/api/pets/$pet->id");

    $response->assertStatus(403);
});

test('consegue listar coleção de animais', function () {
    actingAs($user = User::factory()->create());

    Pet::factory()->for($user)->count(10)->create();

    $response = getJson('/api/pets');
    $response->assertStatus(200);
    $response->assertJsonCount(10, 'data');
});

test('o retorno da coleção filtra animais alheios corretamente', function () {
    actingAs($user = User::factory()->create());

    Pet::factory()->for($user)->count(1)->create();
    Pet::factory()->count(10)->create();

    $response = getJson('/api/pets');
    $response->assertStatus(200);
    $response->assertJsonCount(1, 'data');
});

test('consegue listar meu animal', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $response = getJson("/api/pets/$pet->id");
    $response->assertStatus(200);
});

test('consegue criar um animal', function () {
    actingAs($user = User::factory()->create());

    $petData = Pet::factory()->make();
    $response = postJson('/api/pets', $petData->toArray());

    $response->assertStatus(201);
});

test('consegue atualizar animal próprio', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $petData = Pet::factory()->make()->toArray();
    $response = patchJson("/api/pets/$pet->id", $petData);

    $response->assertStatus(200);
});

test('consegue remover um animal próprio', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $response = deleteJson("/api/pets/$pet->id");

    $response->assertStatus(200);
});

test('consegue listar o animal de outro membro do mesmo espaco_id', function () {
    $outroMembroDoEspaco = User::factory()->create();
    $pet = Pet::factory()->for($outroMembroDoEspaco)->create();

    $user = User::factory()->create();
    $user->espacos()->save($pet->espaco);
    assertTrue($user->espacos->contains($pet->espaco));

    actingAs($user);

    $response = getJson("/api/pets/$pet->id");
    $response->assertStatus(200);
});

test('não consegue listar o animal de outro membro de espaco_id diferente', function () {
    $outroMembroDoEspaco = User::factory()->create();
    $pet = Pet::factory()->for($outroMembroDoEspaco)->create();

    actingAs(User::factory()->create());

    $response = getJson("/api/pets/$pet->id");
    $response->assertStatus(403);
})->only();
