<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Db\UserTransaction;
use App\UseCase\TransactionUseCase;
use Braintree_ClientToken;
use Braintree_Transaction;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Auth;

class TransactionController extends BaseApiController
{

    public function getToken()
    {
        $token = Braintree_ClientToken::generate();

        return new JsonResponse([
            'token' => $token
        ]);
    }

    public function create(Request $request)
    {
        $token = $request->get('token');
        $amount = $request->get('amount');

        if ($amount < 1) {
            return $this->responseError('Amount can\'t be less than 0');
        }

        $result = Braintree_Transaction::sale([
            'amount' => $amount,
            'paymentMethodNonce' => $token,
            'options' => [
                'submitForSettlement' => true
            ]
        ]);

        if (false === $result->success) {
            return $this->responseError('There was an error');
        }

        UserTransaction::create([
            'user_id' => Auth::id(),
            'currency_id' => 2, // @todo-mario: fix currency
            'amount' => $amount
        ]);

        return $this->responseOk();
    }

    public function index($id, TransactionUseCase $useCase)
    {
        return $useCase->getById($id);
    }

    public function getByUser($userId, TransactionUseCase $useCase)
    {
        return $useCase->getByUserId($userId);
    }
}
