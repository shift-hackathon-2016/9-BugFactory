<?php

namespace App\Repositories;


use App\Models\Db\Notification;

class NotificationRepository
{

    public function findByUserId($userId)
    {
        return Notification::where('user_id', $userId)->get();
    }

}