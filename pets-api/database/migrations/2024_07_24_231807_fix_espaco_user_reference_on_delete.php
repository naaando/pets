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
        Schema::table('espaco_user', function (Blueprint $table) {
            $table->dropForeign('espaco_user_user_id_foreign');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('espaco_user', function (Blueprint $table) {
            $table->dropForeign('espaco_user_user_id_foreign');
            $table->foreign('user_id')->references('id')->on('users');
        });
    }
};
