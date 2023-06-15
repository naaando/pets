<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

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
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
