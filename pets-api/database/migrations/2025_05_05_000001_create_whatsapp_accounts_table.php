<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('whatsapp_accounts', function (Blueprint $table) {
            $table->id();
            $table->uuid('user_id')->nullable();
            $table->string('instance_name')->unique();
            $table->string('owner_jid')->nullable();
            $table->string('phone_number')->nullable();
            $table->string('status')->default('pending');
            $table->string('qr_code')->nullable();
            $table->string('webhook_url')->nullable();
            $table->boolean('webhook_enabled')->default(true);
            $table->json('profile')->nullable();
            $table->timestamps();

            $table->foreign('user_id')->references('id')->on('users')->onDelete('set null');
            $table->index('user_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('whatsapp_accounts');
    }
};