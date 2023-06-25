<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\PetVacina
 *
 * @property int $id
 * @property string|null $pet_id
 * @property string|null $nome
 * @property string|null $fabricante
 * @property string|null $veterinario
 * @property \Illuminate\Support\Carbon|null $data
 * @property string|null $user_id
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Pet|null $pet
 * @property-read \App\Models\User|null $user
 * @method static \Database\Factories\PetVacinaFactory factory($count = null, $state = [])
 * @method static \Illuminate\Database\Eloquent\Builder|PetVacina newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|PetVacina newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|PetVacina query()
 * @method static \Illuminate\Database\Eloquent\Builder|PetVacina whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PetVacina whereData($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PetVacina whereFabricante($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PetVacina whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PetVacina whereNome($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PetVacina wherePetId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PetVacina whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PetVacina whereUserId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PetVacina whereVeterinario($value)
 * @mixin \Eloquent
 */
class PetVacina extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'tipo',
        'marca',
        'veterinario',
        'data',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'data' => 'datetime',
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
