<?php

namespace App\Repositories;

use App\Models\Db\TaskApplication;

class TaskApplicationRepository
{

    public function findById($id)
    {
        return TaskApplication::with('user')->where('id', $id)->get();
    }

    public function findByUserId($userId)
    {
        return TaskApplication::with('user')->where('user_id', $userId)->get();
    }

    public function findByTaskId($taskId)
    {
        return TaskApplication::with('user')->where('task_id', $taskId)->get();
    }
}
