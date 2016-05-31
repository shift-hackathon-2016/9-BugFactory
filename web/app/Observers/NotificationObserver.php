<?php

namespace App\Observers;

use App\Models\Db\Notification;
use App\Models\Db\PushNotification;
use App\Repositories\DeviceRepository;

class NotificationObserver
{
    public function created(Notification $model)
    {
        $deviceRepository = new DeviceRepository();
        $devices = $deviceRepository->findByUserId($model->user_id);

        foreach ($devices as $device) {
            PushNotification::create([
                'user_device_id' => $device->id,
                'payload' => ['object_type' => 'Notification', 'object_id' => $model->id]
            ]);
        }
    }
}