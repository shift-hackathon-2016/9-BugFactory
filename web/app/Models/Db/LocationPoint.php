<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class LocationPoint extends Model
{
    protected $fillable = [
        "location_id",
        "point"
    ];

    public $hidden = [
        "point"
    ];

    public $timestamps = false;
}