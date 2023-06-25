<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\Espaco
 *
 * @property string $id
 * @property string $nome
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Pet> $pets
 * @property-read int|null $pets_count
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\User> $users
 * @property-read int|null $users_count
 * @method static \Database\Factories\EspacoFactory factory($count = null, $state = [])
 * @method static \Illuminate\Database\Eloquent\Builder|Espaco newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Espaco newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Espaco query()
 * @method static \Illuminate\Database\Eloquent\Builder|Espaco whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Espaco whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Espaco whereNome($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Espaco whereUpdatedAt($value)
 * @mixin \Eloquent
 */
class Espaco extends Model
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
    ];

    /**
     * Get the pets for the espaco.
     */
    public function pets()
    {
        return $this->hasMany(Pet::class);
    }

    /**
     * Get the user associated with the espaco.
     */
    public function users()
    {
        return $this->belongsToMany(User::class);
    }
}
