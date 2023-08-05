<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

/**
 * App\Models\Pet
 *
 * @property string $id
 * @property string $nome
 * @property string|null $imagem
 * @property string $user_id
 * @property string|null $espaco_id
 * @property string|null $especie_id
 * @property string|null $sexo
 * @property string|null $raca
 * @property \Illuminate\Support\Carbon|null $nascimento
 * @property \Illuminate\Support\Carbon|null $falecimento
 * @property \Illuminate\Support\Carbon|null $castracao
 * @property string|null $mae_id
 * @property string|null $pai_id
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\Especie|null $especie
 * @property-read \App\Models\User $user
 * @property-read \Illuminate\Database\Eloquent\Collection<int, \App\Models\Vacina> $vacinas
 * @property-read int|null $vacinas_count
 * @method static \Database\Factories\PetFactory factory($count = null, $state = [])
 * @method static \Illuminate\Database\Eloquent\Builder|Pet newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Pet newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Pet query()
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereCastracao($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereEspacoId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereEspecieId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereFalecimento($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereImagem($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereMaeId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereNascimento($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereNome($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet wherePaiId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereRaca($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereSexo($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Pet whereUserId($value)
 * @mixin \Eloquent
 */
class Pet extends Model
{
    use HasFactory;
    use HasUuids;
    use SoftDeletes;

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
        'mae_id',
        'pai_id',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'nascimento' => 'datetime',
        'falecimento' => 'datetime',
        'castracao' => 'datetime',
    ];

    /**
     * Get the especie associated with the pet.
     */
    public function especie()
    {
        return $this->belongsTo(Especie::class);
    }

    /**
     * Get the user associated with the pet.
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get the vacinas for the pet.
     */
    public function vacinas()
    {
        return $this->hasMany(Vacina::class);
    }
}
