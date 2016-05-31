<?php

namespace App\Repositories;

use App\Models\Db\Task;

class TaskRepository
{
    public function find($id)
    {
        return Task::with('owner', 'category')->find($id);
    }
}
