<?php

namespace App\Http\Controllers\Api;

use App\Models\Db\TaskApplication;
use App\UseCase\TaskApplicationsUseCase;
use Illuminate\Http\Request;

use App\Http\Requests;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class TaskApplicationsController extends BaseApiController
{

    public function create(Request $request)
    {
        $validator = $this->validator($request->all());

        if ($validator->fails()) {
            return $this->responseError('Invalid task id');
        }

        TaskApplication::create([
            'user_id' => Auth::id(),
            'task_id' => $request->task_id,
        ]);

        return $this->responseOk();
    }

    public function index($id, TaskApplicationsUseCase $useCase)
    {
        return $useCase->getById($id);
    }

    public function getByUser($id, TaskApplicationsUseCase $useCase)
    {
        return $useCase->getByUserId($id);
    }

    public function getByTask($id, TaskApplicationsUseCase $useCase)
    {
        return $useCase->getByTaskId($id);
    }

    protected function validator(array $data)
    {
        return Validator::make($data, [
            'task_id' => 'required|int'
        ]);
    }
}
