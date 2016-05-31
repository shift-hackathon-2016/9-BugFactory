<?php

namespace App\Http\Controllers\Admin;

class AdminLoginController extends BaseAdminController
{

    public function showLogin()
    {
        return view('Admin.login');
    }

    public function showExample()
    {
        return view('Admin.example');
    }

}
