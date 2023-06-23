<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\Especie
 *
 * @property string $id
 * @property string $nome
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Pet> $pets
 * @property-read int|null $pets_count
 * @method static \Illuminate\Database\Eloquent\Builder|Especie newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Especie newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Especie query()
 * @method static \Illuminate\Database\Eloquent\Builder|Especie whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Especie whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Especie whereNome($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Especie whereUpdatedAt($value)
 * @mixin \Eloquent
 */
class Especie extends Model
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
     * Get the pets for the especie.
     */
    public function pets()
    {
        return $this->hasMany(Pet::class);
    }
}
