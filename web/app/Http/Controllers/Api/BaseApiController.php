<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\RegisterUserRequest;
use App\Models\Db\User;
use Illuminate\Foundation\Auth\AuthenticatesAndRegistersUsers;
use Illuminate\Http\Request;

use App\Http\Requests;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class BaseApiController extends Controller
{
    protected function responseOk()
    {
        return ['status' => 'OK'];
    }

    protected function responseError($message)
    {
        return response([
            'status' => Response::HTTP_BAD_REQUEST,
            'title' => 'Error',
            'message' => $message
        ], Response::HTTP_BAD_REQUEST);
    }
}
