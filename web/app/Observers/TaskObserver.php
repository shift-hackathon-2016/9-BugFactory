<?php

namespace App\Observers;

use App\Models\Db\Device;
use App\Models\Db\Notification;
use App\Models\Db\Task;

class TaskObserver
{
    public function created(Task $task)
    {
        $devices = Device::whereNotNull('aws_notifications_token')->get();

        foreach ($devices as $device) {
            Notification::create([
                'user_id' => $device->user_id,
                'read' => 0,
                'object_type' => 'Task',
                'object_id' => $task->id
            ]);
        }
    }
}