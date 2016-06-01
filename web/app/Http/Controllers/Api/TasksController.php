<?php

namespace App\Http\Controllers\Api;

use App\Models\Db\Location;
use App\Models\Db\Task;
use App\Models\Db\UserTransaction;
use App\Repositories\LocationPointRepository;
use App\Repositories\LocationRepository;
use App\Repositories\TaskRepository;
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
        $data = [
            'category_id' => 4,
            'user_id' => Auth::id(),
            'description' => $request->description,
            'currency_id' => 2,
            'amount' => 0.0,
            'starts_at' => $request->starts_at,
            'ends_at' => '0000-00-00 00:00:00',

        ];

        $locationRequestData = $request->get('location');
        $location = Location::create([
            'latitude' => $locationRequestData['latitude'],
            'longitude' => $locationRequestData['longitude'],
            'city' => '',
            'country' => '',
            'street' => '',
            'zip' => '',
         ]);

        $data['location_id'] = $location->id;
        $data['user_id'] = Auth::id();

        Task::create($data);

        return $this->responseOk();
    }

    public function delete($id, TaskUseCase $useCase)
    {
        $useCase->delete($id);

        return $this->responseOk();
    }

    public function finish(Request $request, TaskUseCase $useCase)
    {
        $useCase->finish($request->id);

        return $this->responseOk();
    }


    protected function validator(array $data)
    {
        return Validator::make($data, [
            //'category_id' => 'required|int',
            'description' => 'required',
            //'currency_id' => 'required',
            //'amount' => 'required',
            'starts_at' => 'required|int',
//            'ends_at' => 'required|int',
        ]);
    }

    public function nearby(Request $request, TaskRepository $taskRepository, LocationPointRepository $locationPointRepository)
    {
        $lat = $request->latitude;
        $lon = $request->longitude;

        if ($lat === null || $lon === null) {
            return $this->responseError('Invalid latitude or longitude specified');
        }

        $locationIds = $locationPointRepository->getLocationPointsInEnvelope($lat, $lon, 15, 'km')->get()->map(function($item) {
            return $item->location_id;
        })->toArray();

        return $taskRepository->findByLocationIds($locationIds)->with('location')->get();

    }

    public function getByCategory($categoryId, TaskUseCase $useCase)
    {
        return $useCase->getByCategory($categoryId);
    }
}
