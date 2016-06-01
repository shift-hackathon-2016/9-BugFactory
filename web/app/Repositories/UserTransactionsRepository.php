<?php

namespace App\Repositories;

use App\Models\Db\UserTransaction;

class UserTransactionsRepository
{

    public function findByUserId($userId)
    {
        return UserTransaction::where('user_id', $userId)->get();
    }
}
