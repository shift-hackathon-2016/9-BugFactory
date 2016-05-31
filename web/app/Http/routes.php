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

    Route::group(['prefix' => 'notifications', 'middleware' => 'api_auth'], function() {
        Route::get('/', 'NotificationsController@index');
    });

    Route::group(['prefix' => 'task', 'middleware' => 'api_auth'], function() {
        Route::group(['prefix' => 'categories'], function() {
            Route::get('/all', 'TaskCategoriesController@getAll');
            Route::get('/{id}', 'TaskCategoriesController@children')->where('id', '[0-9]+');
        });
    });
});

Route::group(['namespace' => 'Web'], function() {
    Route::get('/login', 'AuthController@showLogin');
    Route::get('/example', 'AuthController@showExample');
    Route::post('/login', 'AuthController@login');
    Route::get('/logout', 'AuthController@logout');

});

Route::group(['middleware' => 'admin'], function() {

    Route::group(['namespace' => 'Web'], function() {

        Route::get('dashboard', 'DashboardController@index');
        Route::get('user/edit/{id}', 'AdminUserController@showEdit');
        Route::post('user/save/{id}', [
            'as' => 'user/save',
            'uses' => 'AdminUserController@saveUser'
        ]);

        Route::group(['prefix' => 'task'], function() {
            Route::group(['prefix' => 'categories'], function() {
                Route::get('/all', 'TaskCategoriesController@getAll');
                Route::get('/create', 'TaskCategoriesController@getCreate');
                Route::get('/{id}', 'TaskCategoriesController@index')->where('id', '[0-9]+');
                Route::post('/create', 'TaskCategoriesController@create');
            });
        });

    });

});
