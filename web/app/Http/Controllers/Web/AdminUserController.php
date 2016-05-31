<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Db\User;
use Illuminate\Http\Request;
use Session;
use Validator;

class AdminUserController extends Controller
{

    public function showEdit(Request $request, $id)
    {
        $user = User::find($id);

        if (!$user) {
            return redirect('/');
        }

        $fields = [
            [
                'label' => 'Email',
                'name' => 'email',
                'required' => true,
                'validationError' => null,
                'value' => null
            ],
            [
                'label' => 'First name',
                'name' => 'first_name',
                'required' => true,
                'validationError' => null,
                'value' => null
            ],
            [
                'label' => 'Last name',
                'name' => 'last_name',
                'required' => true,
                'validationError' => null,
                'value' => null
            ],
            [
                'label' => 'Is admin',
                'name' => 'is_admin',
                'required' => true,
                'validationError' => null,
                'value' => null
            ],

        ];

//        $errors = Session::get('errors');
//
//        if (!empty($errors)) {
//            foreach ($fields as $field) {
//                if ($errors->has($field['name'])) {
//                    $field['validationErrors'] = $errors->first($field['name']);
//                }
//            }
//            unset($field);
//        }

        foreach ($fields as &$field) {
            $field['value'] = $user->{$field['name']};
        }
        unset($field);

        return view('Admin.user_edit')->with('fields', $fields)->with('id', $id);
    }

    public function saveUser(Request $request, $id)
    {
        // @todo-toni: validate user
        /** @var User $user */
        $user = User::find($id);

        if (!$user) {
            return redirect('/');
        }

//        $validator = Validator::make($request->all(), [
//            'email' => 'required|between:3,15'
//        ]);

//        if ($validator->fails()) {
//            return redirect()->back()->withInput()->withErrors($validator);
//        }

        $user->fill($request->all());
        $user->save();

        return redirect('/'); // @todo redirect to user list
    }



}
