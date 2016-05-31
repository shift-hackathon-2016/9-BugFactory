<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class PushNotification extends Model
{
    protected $fillable = [
        'user_device_id',
        'payload',
    ];
}
