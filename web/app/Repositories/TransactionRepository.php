<?php

namespace App\Repositories;

use App\Models\Db\UserTransaction;

class TransactionRepository
{
    public function find($id)
    {
        return UserTransaction::find($id);
    }

    public function findByUserId($userId)
    {
        return UserTransaction::where('user_id', $userId)->get();
    }
}
