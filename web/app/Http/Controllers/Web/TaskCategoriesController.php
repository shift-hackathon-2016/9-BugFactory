<?php

namespace App\Http\Controllers\Web;

use App\Models\Db\TaskCategory;
use App\UseCase\TaskCategoriesUseCase;
use Illuminate\Http\Request;

use App\Http\Requests;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

class TaskCategoriesController extends Controller
{
    public function getAll(TaskCategoriesUseCase $useCase)
    {
        return $useCase->getAllCategories();
    }

    public function index($id, TaskCategoriesUseCase $useCase)
    {
        return $useCase->getCategory($id); // @todo: render view here
    }

    public function getCreate($id = null)
    {
        $parentId = null;
        $name = '';
        return view('Admin.cat_create')->with('parentId', $parentId)->with('name', $name);
    }

    public function create(Request $request)
    {
        $validator = $this->validator($request->all());

        if ($validator->fails()) {
            return redirect()->back()
                ->withInput([
                    'name' => $request->name,
                    'parent_id' => $request->parent_id,
                ])
                ->withErrors($validator->errors());
        }

        $data = [
            'name' => $request->name,
        ];

        if (!empty($request->parent_id)) {
            $data['parent_id'] = $request->parent_id;
        }

        $category = TaskCategory::create($data);

        return redirect(action('Web\TaskCategoriesController@index', ['id' => $category->id]));
    }

    protected function validator(array $data)
    {
        return Validator::make($data, [
            'name' => 'required|min:2|unique:task_categories',
            'parent_id' => 'int'
        ]);
    }
}
