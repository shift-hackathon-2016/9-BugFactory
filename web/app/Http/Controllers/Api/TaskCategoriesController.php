<?php

namespace App\Http\Controllers\Api;

use App\UseCase\TaskCategoriesUseCase;

use App\Http\Requests;
use App\Http\Controllers\Controller;

class TaskCategoriesController extends Controller
{

    public function children($parentId, TaskCategoriesUseCase $useCase)
    {
        return $useCase->getChildren($parentId);
    }
}
