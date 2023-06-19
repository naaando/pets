<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable, HasUuids;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'iss',
        'sub',
        'picture',
        'locale',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    /**
     * Get the espaco associated with the user.
     */
    public function espacos()
    {
        return $this->belongsToMany(Espaco::class);
    }

    /**
     * Get the espaco associated with the user.
     */
    public function espacoAtivo()
    {
        return $this->belongsTo(Espaco::class, 'espaco_ativo_id');
    }

    /**
     * Get the pets associated with the user.
     */
    public function pets()
    {
        return $this->hasMany(Pet::class);
    }
}
