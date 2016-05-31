<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class PushNotification extends Model
{
    protected $fillable = [
        'user_device_id',
        'payload',
    ];

    protected $casts = [
        'payload' => 'array'
    ];

    public function userDevice()
    {
        return $this->belongsTo(Device::class);
    }
}
