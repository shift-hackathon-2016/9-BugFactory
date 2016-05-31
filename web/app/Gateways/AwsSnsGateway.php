<?php

namespace App\Gateways;
use app\Models\Db\Device;
use app\Models\Db\PushNotification;

class AwsSnsGateway
{
    private $client;

    public function __construct()
    {
        $this->client = app('aws')->createClient('sns');
    }

    public function registerMobileDevice(Device $device) {
        if ($device->notifications_token === null) {
            return null;
        }
        $endpointArn = $device->aws_notifications_token;
        $updateNeeded = false;
        $createNeeded = ($endpointArn == null);

        if ($createNeeded) {
            $endpointArn = $this->createEndpointForMobileDevice($device);
            $createNeeded = false;
        }

        try {
            $result = $this->client->getEndpointAttributes(array(
                'EndpointArn' => $endpointArn,
            ));
            $tokenIsEqual = $result["Token"] != $device->notifications_token;
            $endpointEnabled = strtolower($result["Enabled"]) == "true";
            $updateNeeded = !$tokenIsEqual || !$endpointEnabled;
        } catch (\Exception $e) {
            $createNeeded = true;
        }

        if ($createNeeded) {
            $endpointArn = $this->createEndpointForMobileDevice($device);
        }

        if ($updateNeeded) {
            $this->updateEndpointForMobileDevice($endpointArn, $device);
        }

        return $endpointArn;
    }

    public function sendPushNotificationToMobileDevice(PushNotification $pushNotification, Device $device) {
        $dataObject = [];

        $apns = [
            "aps" => [
                "alert" => 'Notification from Ceres',
                "sound" => "default"
            ],
            "data" => $dataObject
        ];

        $message = [
            "APNS_SANDBOX" => json_encode($apns),
        ];

        $result = $this->client->publish([
            'Message' => json_encode($message), // REQUIRED
            'MessageStructure' => "json",
            'TargetArn' => $device->aws_notifications_token
        ]);

        return $result["MessageId"];
    }

    private function updateEndpointForMobileDevice($endpointArn, Device $mobileDevice) {
        $this->client->setEndpointAttributes(array(
            'EndpointArn' => $endpointArn,
            'Attributes' => [
                'CustomUserData' => "User_".$mobileDevice->user_id,
                'Enabled' => "true",
                'Token' => $mobileDevice->notifications_token
            ],
        ));
    }

    private function createEndpointForMobileDevice(Device $mobileDevice) {
        $result = $this->client->createPlatformEndpoint([
            'PlatformApplicationArn' => $this->platformApplicationArn(), // REQUIRED
            'Token' => $mobileDevice->notifications_token, // REQUIRED
            'CustomUserData' => "User_".$mobileDevice->user_id,
        ]);

        return $result["EndpointArn"];
    }

    private function platformApplicationArn() {
        return 'arn:aws:sns:eu-west-1:178005310136:app/APNS_SANDBOX/Ceres_iOS_sandbox';
    }
}