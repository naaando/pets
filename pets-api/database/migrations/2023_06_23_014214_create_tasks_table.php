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
        Schema::create('tasks', function (Blueprint $table) {
            $table->id();
            $table->foreignUuid('user_id')->nullable()->references('id')->on('users');
            $table->foreignUuid('pet_id')->nullable()->references('id')->on('pets');
            $table->foreignId('recurring_task_id')->nullable()->references('id')->on('recurring_tasks');
            $table->string('title');
            $table->string('description')->nullable();
            $table->dateTime('remind_at')->nullable();
            $table->dateTime('done_at')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tasks');
    }
};
