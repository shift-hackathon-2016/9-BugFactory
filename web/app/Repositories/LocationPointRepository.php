<?php

namespace App\Repositories;

use App\Helpers\LocationHelper;
use App\Models\Db\LocationPoint;
use App\Models\Db\Location;
use DB;

class LocationPointRepository
{
    private $locationHelper;

    public function __construct()
    {
        $this->locationHelper = new LocationHelper();
    }

    public function getLocationPointsInEnvelope($latitude, $longitude, $maxDistance, $unit = "m") {

        $multiplier = 1.0;

        if (strtolower($unit) == "km") {
            $multiplier = 0.621371;
        } else if (strtolower($unit) == "m") {
            $multiplier = 0.621371 / 1000;
        }

        $maxDistance = $maxDistance * $multiplier;

        if ($maxDistance > 15.0) {
            $maxDistance = 15.0;
        }

        $p = $this->locationHelper->getSquareAroundPoint($latitude, $longitude, $maxDistance);
        $point = "GeomFromText('LineString(".$p[0][0]." ".$p[0][1].",".$p[1][0]." ".$p[1][1].")')";
        $nearbyQuery = "MBRContains($point, point)";

        return LocationPoint::whereRaw($nearbyQuery);
    }

    public function syncWithLocation(Location $location) {
        // do not sync if there is no lat or lon
        if (!$location->latitude || !$location->logitude) {
            return;
        }

        $locationPoint = $this->getLocationPointWithLocationId($location->id)->first();

        if (!$locationPoint) {
            $locationPoint = new LocationPoint();
        }

        $locationPoint->location_id = $location->id;
        $locationPoint->point = DB::raw("GeomFromText('POINT(" . $location->latitude . " " . $location->longitude . ")')");

        $this->storeLocationPoint($locationPoint);
    }

    public function getLocationPointWithLocationId($locationId) {
        $query = LocationPoint::where("location_id", $locationId);

        return $query;
    }

    private function storeLocationPoint(LocationPoint $locationPoint) {
        $locationPoint->save();

        return $locationPoint;
    }
}