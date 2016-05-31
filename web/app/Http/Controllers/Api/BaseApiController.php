<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests;
use Illuminate\Http\Response;

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

    protected function responseUnauthorized()
    {
        return response(['status' => Response::HTTP_UNAUTHORIZED], Response::HTTP_UNAUTHORIZED);
    }
}
