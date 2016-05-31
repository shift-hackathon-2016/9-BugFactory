<?php

namespace App\UseCase;

use App\Repositories\TaskCategoryRepository;

class TaskCategoriesUseCase
{

    /**
     * @var TaskCategoryRepository
     */
    private $taskCategoryRepository;

    /**
     * TaskCategoriesUseCase constructor.
     *
     * @param TaskCategoryRepository $taskCategoryRepository
     */
    public function __construct(TaskCategoryRepository $taskCategoryRepository)
    {
        $this->taskCategoryRepository = $taskCategoryRepository;
    }

    public function getChildren($parentId)
    {
        return $this->taskCategoryRepository->findByParentId($parentId);
    }

    public function getCategory($id)
    {
        return $this->taskCategoryRepository->find($id);
    }

    public function getAllCategories()
    {
        return $this->taskCategoryRepository->all();
    }
}