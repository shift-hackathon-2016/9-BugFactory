<?php

namespace App\Repositories;

use App\Models\Db\Location;

class LocationRepository
{
    public function storeLocation(Location $location) {
        $location->save();

        return $location;
    }
}