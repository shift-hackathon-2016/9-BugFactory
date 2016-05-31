<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Task extends Model
{
    use SoftDeletes;

    protected $dates = [
        'created_at',
        'updated_at',
        'ends_at',
        'starts_at',
    ];

    protected $fillable = [
        'category_id',
        'user_id',
        'location_id',
        'description',
        'currency_id',
        'amount',
        'ends_at',
        'starts_at'
    ];

    public function setAmountAttribute($value)
    {
        $this->attributes['amount'] = round($value, 2);
    }

    public function location()
    {
        return $this->belongsTo(Location::class);
    }

    public function category()
    {
        return $this->belongsTo(TaskCategory::class);
    }

    public function currency()
    {
        return $this->belongsTo(Currency::class);
    }

    public function applications()
    {
        return $this->hasMany(TaskApplication::class);
    }

    public function contracts()
    {
        return $this->hasMany(TaskContract::class);
    }

    public function owner()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
