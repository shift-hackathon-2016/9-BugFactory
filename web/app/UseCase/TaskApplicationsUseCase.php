<?php

namespace App\UseCase;

use App\Repositories\TaskApplicationRepository;

class TaskApplicationsUseCase
{

    /**
     * @var TaskApplicationRepository
     */
    private $taskApplicationRepository;

    /**
     * TaskUseCase constructor.
     *
     * @param TaskApplicationRepository $taskApplicationRepository
     */
    public function __construct(TaskApplicationRepository $taskApplicationRepository)
    {
        $this->taskApplicationRepository = $taskApplicationRepository;
    }

    public function getById($id)
    {
        return $this->taskApplicationRepository->find($id);
    }

    public function getByUserId($userId)
    {
        return $this->taskApplicationRepository->findByUserId($userId);
    }

    public function getByTaskId($taskId)
    {
        return $this->taskApplicationRepository->findByTaskId($taskId);
    }
}