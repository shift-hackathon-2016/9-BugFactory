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

    public function location()
    {
        return $this->belongsTo(Location::class);
    }

    public function category()
    {
        return $this->belongsTo(TaskCategory::class);
    }

    public function applications()
    {
        return $this->hasMany(TaskApplication::class);
    }

    public function contracts()
    {
        return $this->hasMany(TaskContract::class);
    }

    public function owner()
    {
        return $this->belongsTo(User::class);
    }
}
