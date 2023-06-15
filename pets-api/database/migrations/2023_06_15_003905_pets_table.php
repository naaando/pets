<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('pets', function (Blueprint $table) {
            $table->ulid()->primary();
            $table->string('nome');
            $table->string('imagem');
            $table->foreignUlid('user_ulid')->references('ulid')->on('users');
            $table->foreignUlid('espaco_ulid')->references('ulid')->on('espacos');
            $table->foreignUlid('especie_ulid')->references('ulid')->on('especies');
            $table->enum('sexo', ['macho', 'femea']);
            $table->string('raca');
            $table->dateTime('nascimento');
            $table->dateTime('falecimento')->nullable();
            $table->dateTime('castracao')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pets');
    }
};
