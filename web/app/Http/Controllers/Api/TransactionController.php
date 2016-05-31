<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Db\UserTransaction;
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
            return response([
                'status' => Response::HTTP_BAD_REQUEST,
                'title' => 'Error',
                'message' => 'Amount cant be smaller than 0'
            ], Response::HTTP_BAD_REQUEST);
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

}
