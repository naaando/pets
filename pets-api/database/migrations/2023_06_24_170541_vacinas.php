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
        Schema::create('vacinas', function (Blueprint $table) {
            $table->id();
            $table->foreignUuid('user_id')->nullable()->references('id')->on('users');
            $table->foreignUuid('pet_id')->nullable()->references('id')->on('pets');
            $table->string('tipo')->nullable();
            $table->string('marca')->nullable();
            $table->string('veterinario')->nullable();
            $table->dateTime('data')->nullable();
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
