<?php

namespace App\Models\Db;

use Illuminate\Database\Eloquent\Model;

class Currency extends Model
{
    protected $fillable = [
        'code',
        'name',
    ];

    public function transactions()
    {
        return $this->hasMany(UserTransaction::class);
    }

    public function payoffRequests()
    {
        return $this->hasMany(PayoffRequest::class);
    }

    public function users()
    {
        return $this->hasMany(User::class);
    }
}
