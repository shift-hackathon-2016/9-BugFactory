<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class Task extends Model
{
    protected $fillable = [
        'category_id',
        'user_id',
        'location_id',
        'title',
        'description',
    ];
}
