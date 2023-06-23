<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\RecurringTask
 *
 * @property int $id
 * @property string|null $user_id
 * @property string|null $pet_id
 * @property string $title
 * @property string|null $description
 * @property string|null $repeat_week
 * @property int|null $repeat_days_interval
 * @property string|null $repeat_until
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @method static \Illuminate\Database\Eloquent\Builder|RecurringTask newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|RecurringTask newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|RecurringTask query()
 * @method static \Illuminate\Database\Eloquent\Builder|RecurringTask whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|RecurringTask whereDescription($value)
 * @method static \Illuminate\Database\Eloquent\Builder|RecurringTask whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|RecurringTask wherePetId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|RecurringTask whereRepeatDaysInterval($value)
 * @method static \Illuminate\Database\Eloquent\Builder|RecurringTask whereRepeatUntil($value)
 * @method static \Illuminate\Database\Eloquent\Builder|RecurringTask whereRepeatWeek($value)
 * @method static \Illuminate\Database\Eloquent\Builder|RecurringTask whereTitle($value)
 * @method static \Illuminate\Database\Eloquent\Builder|RecurringTask whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|RecurringTask whereUserId($value)
 * @mixin \Eloquent
 */
class RecurringTask extends Model
{
    use HasFactory;
}
