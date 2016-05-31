<?php

namespace App\UseCase;

use App\Repositories\TransactionRepository;

class TransactionUseCase
{

    /**
     * @var TransactionRepository
     */
    private $transactionRepository;

    /**
     * TaskUseCase constructor.
     *
     * @param TransactionRepository $transactionRepository
     */
    public function __construct(TransactionRepository $transactionRepository)
    {
        $this->transactionRepository = $transactionRepository;
    }

    public function getById($id)
    {
        return $this->transactionRepository->find($id);
    }

    public function getByUserId($userId)
    {
        return $this->transactionRepository->findByUserId($userId);
    }
}
