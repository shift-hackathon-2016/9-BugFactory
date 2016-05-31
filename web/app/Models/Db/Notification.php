<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    protected $fillable = [
        'user_id',
        'read'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
