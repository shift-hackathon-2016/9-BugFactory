<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\UseCase\UserTransactionUseCase;

class UserTransactionsController extends Controller
{
    public function getUserBalance($userId, UserTransactionUseCase $useCase)
    {
        return $useCase->getCurrentUserBalance($userId);
    }
}