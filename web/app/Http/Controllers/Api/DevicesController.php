<?php

namespace App\Http\Controllers\Api;

use App\Gateways\AwsSnsGateway;
use App\Http\Controllers\Controller;
use App\Models\Db\Device;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DevicesController extends Controller
{
    public function store(Request $request, AwsSnsGateway $aws)
    {
        try {
            $userId = ['user_id' => Auth::user()->id];
            $params = $request->only(['name', 'udid', 'notifications_token']);
            $device = Device::create(array_merge($userId, $params));

            $awsToken = $aws->registerMobileDevice($device);
            $device->update(['aws_notifications_token' => $awsToken]);
        } catch (\Exception $e) {
            return response(['status' => 400, 'message' => 'Unable to register device'], 400);
        }

        return ['status' => 200];
    }
}