<?php

namespace App\Http\Controllers\Api;

use App\Models\Db\TaskContract;
use App\UseCase\TaskContractsUseCase;
use Illuminate\Http\Request;

use App\Http\Requests;
use Illuminate\Support\Facades\Validator;

class TaskContractsController extends BaseApiController
{
    public function create(Request $request)
    {
        $validator = $this->validator($request->all());

        if ($validator->fails()) {
            return $this->responseError('Invalid data');
        }

        TaskContract::create([
            'user_id' => $request->user_id,
            'task_id' => $request->task_id,
        ]);

        return $this->responseOk();
    }

    public function index($id, TaskContractsUseCase $useCase)
    {
        return $useCase->getById($id);
    }

    public function getByUser($id, TaskContractsUseCase $useCase)
    {
        return $useCase->getByUserId($id);
    }

    public function getByTask($id, TaskContractsUseCase $useCase)
    {
        return $useCase->getByTaskId($id);
    }

    protected function validator(array $data)
    {
        return Validator::make($data, [
            'user_id' => 'required|int',
            'task_id' => 'required|int'
        ]);
    }
}
