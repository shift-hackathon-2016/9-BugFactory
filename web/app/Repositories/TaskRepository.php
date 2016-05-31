<?php

namespace App\Repositories;

use App\Models\Db\Task;

class TaskRepository
{
    public function find($id)
    {
        return Task::with('owner', 'category', 'currency')->find($id);
    }

    public function findByLocationIds(array $locationIds)
    {
        return Task::whereIn('location_id', $locationIds)->get();
    }
}
