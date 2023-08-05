<?php

use App\Models\Pet;
use Illuminate\Http\UploadedFile;

use function Pest\Laravel\actingAs;
use function Pest\Laravel\deleteJson;
use function Pest\Laravel\putJson;
use function PHPUnit\Framework\assertNotEmpty;

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
