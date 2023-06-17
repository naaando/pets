<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pet extends Model
{
    use HasFactory;
    use HasUuids;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'nome',
        'imagem',
        'user_id',
        'especie_id',
        'espaco_id',
        'raca',
        'sexo',
        'nascimento',
        'falecimento',
        'castracao',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'nascimento' => 'datetime',
        'castrado' => 'boolean',
    ];

    /**
     * Get the especie associated with the pet.
     */
    public function especie()
    {
        return $this->belongsTo(Especie::class);
    }
}
