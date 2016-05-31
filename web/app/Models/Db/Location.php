<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class Location extends Model
{
    protected $fillable = [
        'latitude',
        'longitude',
        'city',
        'country',
        'street',
        'zip',
    ];

    public function tasks()
    {
        return $this->hasMany(Task::class);
    }
}