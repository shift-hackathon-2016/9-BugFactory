<?php

namespace App\Repositories;

use App\Models\Db\Device;

class DeviceRepository
{
    public function findById($id)
    {
        return Device::where('id', $id)->first();
    }

    public function findByUserId($userId)
    {
        return Device::where('user_id', $userId)->get();
    }

}