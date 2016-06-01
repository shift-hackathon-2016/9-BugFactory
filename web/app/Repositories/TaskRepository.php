<?php

namespace App\Repositories;

use App\Models\Db\Task;
use Illuminate\Support\Facades\Auth;

class TaskRepository
{
    public function find($id)
    {
        return Task::with('owner', 'category', 'currency')->find($id);
    }

    public function findActiveTask($id)
    {
        return Task::with('contracts')->where('id', $id)->whereNull('finished_at')->first();
    }

    public function findByLocationIds(array $locationIds)
    {
        return Task::whereIn('location_id', $locationIds)->whereNull('finished_at')->whereNot('user_id', Auth::id());
    }

    public function findByCategory($categoryId)
    {
        return Task::where('category_id', $categoryId)->whereNull('finished_at');
    }
}
