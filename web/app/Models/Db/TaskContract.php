<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class TaskContract extends Model
{
    protected $dates = [
        'created_at',
        'updated_at',
        'finished_at'
    ];

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
