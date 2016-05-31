<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

use App\Http\Requests;
use Illuminate\Support\Facades\Validator;

class TaskContractsController extends BaseApiController
{
    public function create(Request $request)
    {
        $validator = $this->validator($request->all());

        if ($validator->fails()) {
            return $this->responseError('Invalid task id');
        }

        //
        return $this->responseOk();
    }

    protected function validator(array $data)
    {
        //
        return Validator::make($data, [
            'task_id' => 'required|int'
        ]);
    }
}
