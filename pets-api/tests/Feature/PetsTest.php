<?php

use App\Models\Pet;
use Illuminate\Http\UploadedFile;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\deleteJson;
use function Pest\Laravel\getJson;
use function Pest\Laravel\patchJson;
use function Pest\Laravel\postJson;
use function Pest\Laravel\putJson;
use function PHPUnit\Framework\assertNotEmpty;

test('proibe usuário não autenticado', function () {
    getJson("/api/pets")->assertStatus(401);
    getJson("/api/pets/1")->assertStatus(401);
    postJson("/api/pets")->assertStatus(401);
    patchJson("/api/pets/1")->assertStatus(401);
    deleteJson("/api/pets/1")->assertStatus(401);
});

test('proibe listar animal alheio', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->create();
    $response = getJson("/api/pets/$pet->id");

    $response->assertStatus(403);
})->todo();

test('proibe atualização de animal alheio', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->create();
    $petData = Pet::factory()->make()->toArray();
    $response = patchJson("/api/pets/$pet->id", $petData);

    $response->assertStatus(403);
});

test('proibe remover um animal alheio', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->create();
    $response = deleteJson("/api/pets/$pet->id");

    $response->assertStatus(403);
})->todo();

test('consegue listar coleção de animais', function () {
    actingAs($user = \App\Models\User::factory()->create());

    Pet::factory()->for($user)->count(10)->create();

    $response = getJson('/api/pets');
    $response->assertStatus(200);
    $response->assertJsonCount(10, 'data');
});

test('o retorno da coleção filtra animais alheios corretamente', function () {
    actingAs($user = \App\Models\User::factory()->create());

    Pet::factory()->for($user)->count(1)->create();
    Pet::factory()->count(10)->create();

    $response = getJson('/api/pets');
    $response->assertStatus(200);
    $response->assertJsonCount(1, 'data');
});

test('consegue listar meu animal', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->create();
    $response = getJson("/api/pets/$pet->id");
    $response->assertStatus(200);
});

test('consegue criar um animal', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $petData = Pet::factory()->make();
    $response = postJson('/api/pets', $petData->toArray());

    $response->assertStatus(201);
});

test('consegue atualizar animal próprio', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $petData = Pet::factory()->make()->toArray();
    $response = patchJson("/api/pets/$pet->id", $petData);

    $response->assertStatus(200);
});

test('consegue remover um animal próprio', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->for($user)->create();
    $response = deleteJson("/api/pets/$pet->id");

    $response->assertStatus(200);
});

test('consigo enviar a imagem do pet', function () {
    actingAs($user = \App\Models\User::factory()->create());

    Storage::fake('public');

    $pet = Pet::factory()->for($user)->create();
    $response = putJson("/api/pets/$pet->id/image", [
        'file' => UploadedFile::fake()->image('avatar.jpg'),
    ]);

    $pet->refresh();
    assertNotEmpty($pet->imagem);

    Storage::disk('public')->assertExists($pet->imagem);

    $response->assertStatus(200);
})->skip();

test('ao enviar a imagem do pet remove a anterior', function () {
    actingAs($user = \App\Models\User::factory()->create());

    Storage::fake('public');

    $pet = Pet::factory()->for($user)->create();
    $imagemAnterior = UploadedFile::fake()->image('avatar.jpg')->storePublicly('pets', 'public');
    $pet->imagem = $imagemAnterior;
    $pet->save();

    $response = putJson("/api/pets/$pet->id/image", [
        'file' => UploadedFile::fake()->image('avatar.jpg'),
    ]);

    $pet->refresh();
    assertNotEmpty($pet->imagem);

    Storage::disk('public')->assertMissing($imagemAnterior);

    $response->assertStatus(200);
})->skip();

test('proibe enviar a imagem do pet alheio', function () {
    actingAs($user = \App\Models\User::factory()->create());

    $pet = Pet::factory()->create();
    $response = putJson("/api/pets/$pet->id/image", [
        'file' => UploadedFile::fake()->image('avatar.jpg'),
    ]);

    $response->assertStatus(403);
})->todo();

test('consegue remover a imagem do pet', function () {
    actingAs($user = \App\Models\User::factory()->create());

    Storage::fake('public');

    $pet = Pet::factory()->for($user)->create();
    $pet->imagem = UploadedFile::fake()->image('avatar.jpg')->storePublicly('pets', 'public');
    $pet->save();

    $response = deleteJson("/api/pets/$pet->id/image");
    $response->assertStatus(204);

    Storage::disk('public')->assertMissing($pet->imagem);
})->skip();

test('proibe remover a imagem do pet alheio', function () {
    actingAs($user = \App\Models\User::factory()->create());

    Storage::fake('public');

    $pet = Pet::factory()->for($user)->create();
    $pet->imagem = UploadedFile::fake()->image('avatar.jpg')->storePublicly('pets', 'public');
    $pet->save();

    $response = deleteJson("/api/pets/$pet->id/image");
    $response->assertStatus(403);

    Storage::disk('public')->assertExists($pet->imagem);
})->todo();
