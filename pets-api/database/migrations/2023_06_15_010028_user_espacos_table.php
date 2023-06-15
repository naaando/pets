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
        Schema::create('espacos_users', function (Blueprint $table) {
            $table->uuid();
            $table->foreignUuid('user_uuid')->references('uuid')->on('users');
            $table->foreignUuid('espaco_uuid')->references('uuid')->on('espacos');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('espacos_users');
    }
};
