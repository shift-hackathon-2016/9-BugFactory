<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class UserTransaction extends Model
{
    protected $fillable = [
        'user_id',
        'currency_id',
        'amount',
    ];
}
