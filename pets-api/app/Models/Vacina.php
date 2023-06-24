<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\Vacina
 *
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Vacina query()
 * @property-read \App\Models\Pet $pet
 * @property-read \App\Models\User $user
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
