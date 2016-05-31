<?php

namespace App\Http\Controllers\Api;

use App\Models\Db\User;
use Illuminate\Foundation\Auth\AuthenticatesAndRegistersUsers;
use Illuminate\Http\Request;

use App\Http\Requests;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class AuthController extends BaseApiController
{
    use AuthenticatesAndRegistersUsers;

    public function login(Request $request)
    {
        $this->validateLogin($request);

        $credentials = $request->only(["email", "password"]);

        if (Auth::attempt($credentials, true)) {
            return $this->responseOk();
        }

        return ['status' => Response::HTTP_UNAUTHORIZED];
    }

    public function register(Request $request)
    {
        $validator = $this->validator($request->all());

        if ($validator->fails()) {
            return $this->responseError('Please supply valid data');
        }

        $user = User::create([
            'email' => $request->email,
            'password' => $request->password,
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
        ]);

        Auth::guard($this->getGuard())->login($user);

        return $this->responseOk();
    }

    protected function validator(array $data)
    {
        return Validator::make($data, [
            'email' => 'required|email|unique:users',
            'password' => 'required|min:6',
            'first_name' => 'required|min:2',
            'last_name' => 'required|min:2'
        ]);
    }

    public function logout()
    {
        Auth::logout();

        return $this->responseOk();
    }
}
