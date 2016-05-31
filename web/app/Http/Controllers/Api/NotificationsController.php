<?php

namespace App\Http\Controllers\Api;

use App\UseCase\UserNotificationsUseCase;
use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class NotificationsController extends Controller
{
    public function index(UserNotificationsUseCase $useCase)
    {
        return $useCase->getUserNotifications(Auth::id());
    }
}
