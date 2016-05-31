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

    public function findById($id)
    {
        return TaskCategory::where('id', $id)->get();
    }

    public function all()
    {
        return TaskCategory::all();
    }

}