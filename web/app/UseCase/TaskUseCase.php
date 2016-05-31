<?php

namespace App\UseCase;

use App\Repositories\TaskRepository;

class TaskUseCase
{

    /**
     * @var TaskRepository
     */
    private $taskRepository;

    /**
     * TaskUseCase constructor.
     *
     * @param TaskRepository $taskRepository
     */
    public function __construct(TaskRepository $taskRepository)
    {
        $this->taskRepository = $taskRepository;
    }

    public function getTask($id)
    {
        return $this->taskRepository->findById($id);
    }
}