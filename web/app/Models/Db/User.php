<?php

namespace App\Models\Db;

use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'email',
        'password',
        'first_name',
        'last_name',
        'is_admin',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    public function notifications()
    {
        return $this->hasMany(Notification::class);
    }

    public function devices()
    {
        return $this->hasMany(UserDevice::class);
    }

    public function payoffRequests()
    {
        return $this->hasMany(PayoffRequest::class);
    }

    public function transactions()
    {
        return $this->hasMany(UserTransaction::class);
    }

    public function applications()
    {
        return $this->hasMany(TaskApplication::class);
    }

    public function contracts()
    {
        return $this->hasMany(TaskContract::class);
    }

    public function tasks()
    {
        return $this->hasMany(Task::class);
    }
    public function setPasswordAttribute($value)
    {
        $this->attributes['password'] = app('hash')->make($value);
    }
}
