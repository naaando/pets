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
            $table->uuid()->primary();
            $table->string('nome');
            $table->string('imagem');
            $table->foreignUuid('user_uuid')->references('uuid')->on('users');
            $table->foreignUuid('espaco_uuid')->references('uuid')->on('espacos');
            $table->foreignUuid('especie_uuid')->references('uuid')->on('especies');
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
