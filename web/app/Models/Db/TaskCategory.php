<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class TaskCategory extends Model
{
    protected $fillable = [
        'parent_id',
        'name',
    ];

}
