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
        Schema::table('pets', function (Blueprint $table) {
            $table->foreignUlid('mae_uuid')->references('uuid')->on('pets');
            $table->foreignUlid('pai_uuid')->references('uuid')->on('pets');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropColumns('pets', ['mae_uuid', 'pai_uuid']);
    }
};
