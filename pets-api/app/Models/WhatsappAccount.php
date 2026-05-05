<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\WhatsappAccount
 *
 * @property string $id
 * @property string|null $user_id
 * @property string $instance_name
 * @property string|null $owner_jid
 * @property string|null $phone_number
 * @property string $status
 * @property string|null $qr_code
 * @property string|null $webhook_url
 * @property bool $webhook_enabled
 * @property array|null $profile
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\User|null $user
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount query()
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount whereInstanceName($value)
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount whereOwnerJid($value)
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount wherePhoneNumber($value)
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount whereProfile($value)
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount whereQrCode($value)
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount whereStatus($value)
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount whereUserId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount whereWebhookEnabled($value)
 * @method static \Illuminate\Database\Eloquent\Builder|WhatsappAccount whereWebhookUrl($value)
 * @mixin \Eloquent
 */
class WhatsappAccount extends Model
{
    use HasFactory;
    use HasUuids;

    protected $fillable = [
        'user_id',
        'instance_name',
        'owner_jid',
        'phone_number',
        'status',
        'qr_code',
        'webhook_url',
        'webhook_enabled',
        'profile',
    ];

    protected $casts = [
        'webhook_enabled' => 'boolean',
        'profile' => 'array',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}