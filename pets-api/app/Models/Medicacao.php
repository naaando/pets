<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\Medicacao
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
 * @method static \Database\Factories\MedicacaoFactory factory($count = null, $state = [])
 * @method static \Illuminate\Database\Eloquent\Builder|Medicacao newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Medicacao newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Medicacao query()
 * @method static \Illuminate\Database\Eloquent\Builder|Medicacao whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Medicacao whereData($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Medicacao whereFabricante($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Medicacao whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Medicacao whereNome($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Medicacao wherePetId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Medicacao whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Medicacao whereUserId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Medicacao whereVeterinario($value)
 * @mixin \Eloquent
 */
class Medicacao extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'pet_id',
        'nome',
        'fabricante',
        'veterinario',
        'quando',
        'tipo',
        'total_doses',
        'dose_atual',
        'proxima_dose',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'quando' => 'datetime',
        'proxima_dose' => 'datetime',
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

    protected $table = 'medicacoes';
}
