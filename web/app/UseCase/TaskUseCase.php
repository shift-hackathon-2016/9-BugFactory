<?php

namespace App\UseCase;

use App\Models\Db\UserTransaction;
use App\Repositories\TaskRepository;
use Illuminate\Support\Facades\Auth;

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
        return $this->taskRepository->find($id);
    }

    public function delete($id)
    {
        $task = $this->taskRepository->find($id);
        if (null !== $task) {
            $task->delete();
        }
    }

    public function finish($id)
    {
        $task = $this->taskRepository->findActiveTask($id);

        if (null === $task) {
            return;
        }

        $task->finished_at = time();
        $task->save();

        foreach($task->contracts as $contract) {
            UserTransaction::create([
                'user_id' => $contract->user_id,
                'currency_id' => $task->currency_id,
                'amount' => $task->amount
            ]);
            UserTransaction::create([
                'user_id' => Auth::id(),
                'currency_id' => $task->currency->id,
                'amount' => - $task->amount
            ]);
        }
    }
}
