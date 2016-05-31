<?php

namespace App\Observers;

use App\Gateways\AwsSnsGateway;
use App\Models\Db\Notification;
use App\Models\Db\PushNotification;
use App\Repositories\DeviceRepository;
use Illuminate\Support\Facades\Queue;

class PushNotificationObserver
{
    public function created(PushNotification $model)
    {
        $deviceRepository = new DeviceRepository();
        $device = $deviceRepository->findById($model->user_device_id);
        Queue::push(function() use($model, $device) {
            $aws = new AwsSnsGateway();
            $aws->sendPushNotificationToMobileDevice($model, $device);
        });
    }
}