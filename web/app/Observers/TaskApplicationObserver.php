<?php

namespace App\Observers;

use App\Models\Db\Notification;
use App\Models\Db\TaskApplication;

class TaskApplicationObserver
{
    public function created(TaskApplication $taskApplication)
    {
        $taskOwner = $taskApplication->task->owner;

        Notification::create([
            'user_id' => $taskOwner->id,
            'read' => 0,
            'object_type' => 'TaskApplication',
            'object_id' => $taskApplication->id
        ]);
    }
}