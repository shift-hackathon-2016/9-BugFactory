<?php

namespace App\Repositories;

use App\Models\Db\Currency;

class CurrencyRepository
{

    public function find($id)
    {
        return Currency::find($id);
    }
}
