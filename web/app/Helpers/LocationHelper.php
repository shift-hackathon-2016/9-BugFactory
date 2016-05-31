<?php

namespace App\Helpers;

class LocationHelper
{
    public function distance($lat1, $lon1, $lat2, $lon2, $unit = "K") {

        $theta = $lon1 - $lon2;
        $dist = sin(deg2rad($lat1)) * sin(deg2rad($lat2)) + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * cos(deg2rad($theta));
        $dist = acos($dist);
        $dist = rad2deg($dist);
        $miles = $dist * 60 * 1.1515;
        $unit = strtoupper($unit);

        if ($unit == "K") {
            return ($miles * 1.609344);
        } else if ($unit == "N") {
            return ($miles * 0.8684);
        } else {
            return $miles;
        }
    }

    private function getDestinationPoint($alat, $alon, $distance, $bearing) {
        $pi = 3.14159265358979;

        $alatRad = $alat * $pi / 180;
        $alonRad = $alon * $pi / 180;
        $bearing = $bearing * $pi / 180;

        $alatRadSin = sin($alatRad);
        $alatRadCos = cos($alatRad);

        // Omjer udaljenosti Zemljinog polumjera
        $angularDistance = $distance / 6370.997;
        $angDistSin = sin($angularDistance);
        $angDistCos = cos($angularDistance);

        $xlatRad = asin($alatRadSin * $angDistCos + $alatRadCos * $angDistSin * cos($bearing));
        $xlonRad = $alonRad + atan2(sin($bearing) * $angDistSin * $alatRadCos, $angDistCos - $alatRadSin * sin($xlatRad));

        $xlat = $xlatRad * 180 / $pi;
        $xlon = $xlonRad * 180 / $pi;
        if ($xlat > 90)
            $xlat = 90;
        if ($xlat < -90)
            $xlat = -90;
        while ($xlat > 180)
            $xlat-=360;
        while ($xlat <= -180)
            $xlat+=360;
        while ($xlon > 180)
            $xlon-=360;
        while ($xlon <= -180)
            $xlon+=360;
        return array($xlat, $xlon);
    }

    public function getSquareAroundPoint($lat, $lon, $distance)
    {
        return array(
            $this->getDestinationPoint($lat, $lon, $distance, 45),
            $this->getDestinationPoint($lat, $lon, $distance, 225),
        );
    }
}