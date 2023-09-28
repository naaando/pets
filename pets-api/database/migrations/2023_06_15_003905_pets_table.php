<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('pets', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('nome');
            $table->string('imagem')->nullable();
            $table->foreignUuid('user_id')->references('id')->on('users');
            $table->foreignUuid('espaco_id')->nullable()->references('id')->on('espacos');
            $table->string('especie_id')->nullable();
            $table->foreign('especie_id')->references('id')->on('especies');
            $table->enum('sexo', ['macho', 'femea'])->nullable();
            $table->string('raca')->nullable();
            $table->dateTime('nascimento')->nullable();
            $table->dateTime('falecimento')->nullable();
            $table->dateTime('castracao')->nullable();
        });

        Schema::table('pets', function (Blueprint $table) {
            $table->foreignUuid('mae_id')->nullable()->references('id')->on('pets');
            $table->foreignUuid('pai_id')->nullable()->references('id')->on('pets');
            $table->timestamps();
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
