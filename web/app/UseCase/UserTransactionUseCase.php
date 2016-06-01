<?php

namespace App\UseCase;

use App\Repositories\CurrencyRepository;
use App\Repositories\UserTransactionsRepository;

class UserTransactionUseCase
{

    /**
     * @var UserTransactionsRepository
     */
    private $userTransactionsRepository;
    /**
     * @var CurrencyRepository
     */
    private $currencyRepository;

    /**
     * TaskUseCase constructor.
     *
     * @param UserTransactionsRepository $userTransactionsRepository
     * @param CurrencyRepository $currencyRepository
     */
    public function __construct(
        UserTransactionsRepository $userTransactionsRepository,
        CurrencyRepository $currencyRepository
    ){
        $this->userTransactionsRepository = $userTransactionsRepository;
        $this->currencyRepository = $currencyRepository;
    }

    public function getCurrentUserBalance($userId)
    {
        $transactions = $this->userTransactionsRepository->findByUserId($userId);
        $currency = $this->currencyRepository->find(2);

        $balance = 0.0;
        foreach($transactions as $transaction) {
            $balance += $transaction->amount;
        }

        return [
            'balance' => $balance,
            'currency_id' => 2,
            'currency' => $currency,
        ];
    }
}
