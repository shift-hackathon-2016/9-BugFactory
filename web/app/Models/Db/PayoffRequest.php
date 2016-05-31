<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class PayoffRequest extends Model
{
    protected $fillable = [
        'user_id',
        'currency_id',
        'amount',
        'payed',
    ];

    public function setAmountAttribute($value)
    {
        $this->attributes['amount'] = round($value, 2);
    }
}
