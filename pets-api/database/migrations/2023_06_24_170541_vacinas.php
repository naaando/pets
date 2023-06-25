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
        Schema::create('pet_vacinas', function (Blueprint $table) {
            $table->id();
            $table->foreignUuid('pet_id')->nullable()->references('id')->on('pets');
            $table->string('nome')->nullable();
            $table->string('fabricante')->nullable();
            $table->string('veterinario')->nullable();
            $table->dateTime('data')->nullable();
            $table->foreignUuid('user_id')->nullable()->references('id')->on('users');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};