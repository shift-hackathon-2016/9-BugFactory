<?php

namespace App\Repositories;

use App\Models\Db\TaskContract;

class TaskContractRepository
{

    public function find($id)
    {
        return TaskContract::with('user')->find($id);
    }

    public function findByUserId($userId)
    {
        return TaskContract::with('user')->where('user_id', $userId)->get();
    }

    public function findByTaskId($taskId)
    {
        return TaskContract::with('user')->where('task_id', $taskId)->get();
    }
}
