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
        // add completado em medicacoes table
        Schema::table('medicacoes', function (Blueprint $table) {
            $table->foreignId('inicial_id')->nullable()->constrained('medicacoes')->comment('id da medicação inicial')->after('pet_id');
            $table->foreignId('antecessora_id')->nullable()->constrained('medicacoes')->comment('id da medicação antecessora')->after('inicial_id');
            $table->boolean('completado')->default(false)->after('proxima_dose');
            $table->dropColumn('proxima_dose');
            $table->dropColumn('total_doses');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('medicacoes', function (Blueprint $table) {
            $table->dropConstrainedForeignId('inicial_id');
            $table->dropConstrainedForeignId('antecessora_id');
            $table->dropColumn('completado');
            $table->integer('total_doses')->nullable();
            $table->datetime('proxima_dose')->nullable();
        });
    }
};
