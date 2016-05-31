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

class PaymentController extends Controller
{

    public function getToken()
    {
        $token = Braintree_ClientToken::generate();

        return new JsonResponse([
            'token' => $token
        ]);
    }

    public function makePayment(Request $request)
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

        if ($result->success) {
            return response([
                'status' => Response::HTTP_BAD_REQUEST,
                'title' => 'Error',
                'message' => 'There was an error'
            ], Response::HTTP_BAD_REQUEST);
        }

        UserTransaction::create([
            Auth::id(),
            2, // @todo-mario: fix currency
            $amount
        ]);

        return response([
            'message' => 'Success'
        ]);
    }

}
