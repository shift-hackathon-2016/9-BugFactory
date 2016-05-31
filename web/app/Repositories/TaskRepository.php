<?php

namespace App\Repositories;

use App\Models\Db\Task;

class TaskRepository
{
    public function find($id)
    {
        return Task::find($id);
    }

    public function findById($id)
    {
        return Task::with('owner', 'category')->where('id', $id)->get();
    }
}
