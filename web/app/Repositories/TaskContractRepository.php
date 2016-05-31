<?php

namespace App\Repositories;

use App\Models\Db\TaskContract;

class TaskContractRepository
{

    public function findById($id)
    {
        return TaskContract::with('user')->where('id', $id)->get();
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
