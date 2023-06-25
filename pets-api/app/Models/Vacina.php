<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\Vacina
 *
 * @property int $id
 * @property string|null $pet_id
 * @property string|null $nome
 * @property string|null $fabricante
 * @property string|null $veterinario
 * @property \Illuminate\Support\Carbon|null $quando
 * @property string|null $user_id
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Pet|null $pet
 * @property-read \App\Models\User|null $user
 * @method static \Database\Factories\VacinaFactory factory($count = null, $state = [])
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina query()
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina whereData($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina whereFabricante($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina whereNome($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina wherePetId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina whereUserId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina whereVeterinario($value)
 * @mixin \Eloquent
 */
class Vacina extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'nome',
        'fabricante',
        'veterinario',
        'quando',
        'pet_id',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'quando' => 'datetime',
    ];

    /**
     * Get the pet that owns the vacina.
     */
    public function pet()
    {
        return $this->belongsTo(Pet::class);
    }

    /**
     * Get the user that owns the vacina.
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
