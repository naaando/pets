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
        Schema::create('espacos', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('nome');
            $table->timestamps();
        });

        Schema::create('espaco_user', function (Blueprint $table) {
            $table->foreignUuid('user_id')->references('id')->on('users');
            $table->foreignUuid('espaco_id')->references('id')->on('espacos');
            $table->timestamps();
        });

        Schema::table('users', function (Blueprint $table) {
            $table->foreignUuid('espaco_ativo_id')->nullable()->references('id')->on('espacos');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('espacos');
        Schema::dropIfExists('espacos_users');
    }
};
