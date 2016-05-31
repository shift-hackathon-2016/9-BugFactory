<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/

Route::get('/', function () {
    return redirect('/dashboard');
});

Route::group(['prefix' => 'api', 'namespace' => 'Api'], function() {
    Route::group(['prefix' => 'auth'], function() {
        Route::post('/login', 'AuthController@login');
        Route::post('/register', 'AuthController@register');
        Route::get('/logout', 'AuthController@logout');
    });
});

Route::group(['namespace' => 'Web'], function() {
    Route::get('/login', 'AuthController@showLogin');
    Route::get('/example', 'AuthController@showExample');
    Route::post('/login', 'AuthController@login');
    Route::get('/logout', 'AuthController@logout');
});

Route::group(['middleware' => 'auth'], function(){
    Route::get('dashboard', 'DashboardController@index');
});
