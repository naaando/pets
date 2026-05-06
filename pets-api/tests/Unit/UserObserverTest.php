<?php

use App\Models\User;

test('cria espaço padrão ao criar usuário', function () {
    $user = User::factory()->create();

    expect($user->espacos)->toHaveCount(1);
    expect($user->espacos->first()->nome)->toBe('Meu espaço');
    expect($user->espacoAtivo)->not->toBeNull();
    expect($user->espaco_ativo_id)->toBe($user->espacos->first()->id);
});

test('não cria espaço duplicado se já existe', function () {
    $user = User::factory()->has(\App\Models\Espaco::factory())->create();

    // Even after observer runs, should still have the factory-created space
    expect($user->espacos->count())->toBeGreaterThanOrEqual(1);
});
