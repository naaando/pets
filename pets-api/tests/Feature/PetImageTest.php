<?php

use App\Models\Pet;
use App\Models\User;
use Illuminate\Http\UploadedFile;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\deleteJson;
use function Pest\Laravel\putJson;
use function PHPUnit\Framework\assertNotEmpty;

test('consigo enviar a imagem do pet', function () {
    actingAs($user = User::factory()->create());

    Storage::fake();

    $pet = Pet::factory()->for($user->espacoAtivo)->create();
    $response = putJson("/api/pets/$pet->id/image", [
        'file' => UploadedFile::fake()->image('avatar.jpg'),
    ]);

    $pet->refresh();
    assertNotEmpty($pet->imagem);

    Storage::disk()->assertExists($pet->imagem);

    $response->assertStatus(200);
});

test('ao enviar a imagem do pet remove a anterior', function () {
    actingAs($user = User::factory()->create());

    Storage::fake();

    $pet = Pet::factory()->for($user->espacoAtivo)->create();
    $imagemAnterior = UploadedFile::fake()->image('avatar.jpg')->storePublicly('pets');
    $pet->imagem = $imagemAnterior;
    $pet->save();

    $response = putJson("/api/pets/$pet->id/image", [
        'file' => UploadedFile::fake()->image('avatar.jpg'),
    ]);

    $pet->refresh();
    assertNotEmpty($pet->imagem);

    Storage::disk()->assertMissing($imagemAnterior);
    Storage::disk()->assertExists($pet->imagem);

    $response->assertStatus(200);
});

test('proibe enviar a imagem do pet alheio', function () {
    actingAs($user = User::factory()->create());

    $pet = Pet::factory()->create();
    $response = putJson("/api/pets/$pet->id/image", [
        'file' => UploadedFile::fake()->image('avatar.jpg'),
    ]);

    $response->assertStatus(403);
});

test('consegue remover a imagem do pet', function () {
    actingAs($user = User::factory()->create());

    Storage::fake();

    $pet = Pet::factory()->for($user->espacoAtivo)->create();
    $pet->imagem = UploadedFile::fake()->image('avatar.jpg')->storePublicly('pets');
    $pet->save();

    $response = deleteJson("/api/pets/$pet->id/image");
    $response->assertStatus(204);

    Storage::disk()->assertMissing($pet->imagem);
});

test('proibe remover a imagem do pet alheio', function () {
    actingAs($user = User::factory()->create());

    Storage::fake();

    $pet = Pet::factory()->create();
    $pet->imagem = UploadedFile::fake()->image('avatar.jpg')->storePublicly('pets');
    $pet->save();

    $response = deleteJson("/api/pets/$pet->id/image");
    $response->assertStatus(403);

    Storage::disk()->assertExists($pet->imagem);
});

test('permite envio de imagens maiores ou iguais a 10MB', function () {
    actingAs($user = User::factory()->create());

    Storage::fake();

    $pet = Pet::factory()->for($user->espacoAtivo)->create();
    $response = putJson("/api/pets/$pet->id/image", [
        'file' => UploadedFile::fake()->image('avatar.jpg')->size(10240),
    ]);

    $pet->refresh();
    assertNotEmpty($pet->imagem);

    Storage::disk()->assertExists($pet->imagem);

    $response->assertStatus(200);
});

test('proibe envio de imagens maiores que 10MB', function () {
    actingAs($user = User::factory()->create());

    Storage::fake();

    $pet = Pet::factory()->for($user->espacoAtivo)->create();
    $response = putJson("/api/pets/$pet->id/image", [
        'file' => UploadedFile::fake()->image('avatar.jpg')->size(10241),
    ]);

    $response->assertStatus(422);
});
