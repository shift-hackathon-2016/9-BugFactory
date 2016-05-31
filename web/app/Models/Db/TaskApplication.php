<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class TaskApplication extends Model
{
    protected $fillable = [
        'user_id',
        'task_id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function task()
    {
        return $this->belongsTo(Task::class);
    }
}
