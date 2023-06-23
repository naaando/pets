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
        Schema::create('recurring_tasks', function (Blueprint $table) {
            $table->id();
            $table->foreignUuid('user_id')->nullable()->references('id')->on('users');
            $table->foreignUuid('pet_id')->nullable()->references('id')->on('pets');
            $table->string('title');
            $table->string('description')->nullable();
            $table->enum('repeat_week', ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'])
                ->nullable();
            $table->integer('repeat_days_interval')->nullable();
            $table->dateTime('repeat_until')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('schedules');
    }
};
