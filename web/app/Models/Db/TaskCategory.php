<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class TaskCategory extends Model
{
    protected $fillable = [
        'parent_id',
        'name',
    ];

    public function tasks()
    {
        return $this->hasMany(Task::class);
    }

    public function parent()
    {
        return $this->belongsTo(TaskCategory::class, 'parent_id');
    }

    public function children()
    {
        return $this->hasMany(TaskCategory::class, 'parent_id');
    }
}
