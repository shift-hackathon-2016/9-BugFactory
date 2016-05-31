<?php

namespace App\Repositories;

use App\Models\Db\TaskCategory;

class TaskCategoryRepository
{

    public function findByParentId($parentId)
    {
        if (empty($parentId)) {
            return TaskCategory::whereNull('parent_id')->get();
        }
        return TaskCategory::where('parent_id', $parentId)->get();
    }

    public function find($id)
    {
        return TaskCategory::find($id);
    }

    public function all()
    {
        return TaskCategory::all();
    }

}