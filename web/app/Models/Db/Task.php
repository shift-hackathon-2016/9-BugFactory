<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Task extends Model
{
    use SoftDeletes;

    protected $dates = [
        'created_at',
        'updated_at',
        'starts_at',
        'ends_at',
    ];

    protected $fillable = [
        'category_id',
        'user_id',
        'location_id',
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
        return $this->belongsTo(User::class, 'user_id');
    }
}
