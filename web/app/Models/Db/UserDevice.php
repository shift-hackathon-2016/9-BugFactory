<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class UserDevice extends Model
{
    protected $fillable = [
        'user_id',
        'name',
        'notifications_token',
        'aws_notifications_token',
    ];

    public function pushNotifications()
    {
        return $this->hasMany(PushNotification::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
