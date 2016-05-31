<?php

namespace App\Observers;

use App\Models\Db\Location;
use App\Repositories\LocationPointRepository;

class LocationObserver
{
    public function saved(Location $model) {
        $locationPointRepository = new LocationPointRepository();
        $locationPointRepository->syncWithLocation($model);
    }
}