<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class TaskApplication extends Model
{
    protected $fillable = [
        'user_id',
        'task_id',
    ];
}
