<?php

namespace App\UseCase;

use App\Repositories\TaskContractRepository;

class TaskContractsUseCase
{

    /**
     * @var TaskContractRepository
     */
    private $taskContractRepository;

    /**
     * TaskUseCase constructor.
     *
     * @param TaskContractRepository $taskContractRepository
     */
    public function __construct(TaskContractRepository $taskContractRepository)
    {
        $this->taskContractRepository = $taskContractRepository;
    }

    public function getById($id)
    {
        return $this->taskContractRepository->findById($id);
    }

    public function getByUserId($userId)
    {
        return $this->taskContractRepository->findByUserId($userId);
    }

    public function getByTaskId($taskId)
    {
        return $this->taskContractRepository->findByTaskId($taskId);
    }
}