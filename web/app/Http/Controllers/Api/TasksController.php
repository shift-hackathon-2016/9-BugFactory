<?php

namespace App\Http\Controllers\Api;

use App\Models\Db\Task;
use App\UseCase\TaskUseCase;
use Illuminate\Http\Request;

use App\Http\Requests;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class TasksController extends BaseApiController
{
    public function index(Request $request, TaskUseCase $useCase)
    {
        return $useCase->getTask($request->id);
    }

    public function create(Request $request)
    {
        $validator = $this->validator($request->all());

        if ($validator->fails()) {
            return $this->responseError('Invalid data');
        }

        $data = [
            'category_id' => $request->category_id,
            'user_id' => Auth::id(),
            'description' => $request->description,
            'currency_id' => $request->currency_id,
            'amount' => $request->amount,
            'starts_at' => $request->starts_at,
            'ends_at' => $request->ends_at,

        ];

        if (!empty($request->location_id)) {
            $data['location_id'] = $request->location_id;
        }

        Task::create($data);

        return $this->responseOk();
    }

    public function delete($id, TaskUseCase $useCase)
    {
        $useCase->delete($id);

        return $this->responseOk();
    }

    protected function validator(array $data)
    {
        return Validator::make($data, [
            'category_id' => 'required|int',
            'location_id' => 'int',
            'description' => 'required',
            'currency_id' => 'required',
            'amount' => 'required',
            'starts_at' => 'required|int',
            'ends_at' => 'required|int',
        ]);
    }
}
