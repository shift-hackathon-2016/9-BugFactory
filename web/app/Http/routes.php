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


    Route::group(['middleware' => 'api_auth'], function() {

        Route::group(['prefix' => 'notifications'], function() {
            Route::get('/', 'NotificationsController@index');
        });

        Route::group(['prefix' => 'tasks', 'middleware' => 'api_auth'], function() {
            Route::post('/', 'TasksController@create');
            Route::get('/{id}', 'TasksController@index')->where('id', '[0-9]+');
            Route::delete('/{id}', 'TasksController@delete')->where('id', '[0-9]+');
        });

        Route::group(['prefix' => 'task-categories'], function() {
            Route::get('/{id}', 'TaskCategoriesController@children')->where('id', '[0-9]+');
        });

        Route::group(['prefix' => 'task-applications'], function() {
            Route::get('/{id}', 'TaskApplicationsController@index')->where('id', '[0-9]+');
            Route::get('/user/{id}', 'TaskApplicationsController@getByUser')->where('id', '[0-9]+');
            Route::get('/task/{id}', 'TaskApplicationsController@getByTask')->where('id', '[0-9]+');
            Route::post('/', 'TaskApplicationsController@create');
        });

        Route::group(['prefix' => 'task-contracts'], function() {
            Route::get('/{id}', 'TaskContractsController@index')->where('id', '[0-9]+');
            Route::get('/user/{id}', 'TaskContractsController@getByUser')->where('id', '[0-9]+');
            Route::get('/task/{id}', 'TaskContractsController@getByTask')->where('id', '[0-9]+');
            Route::post('/', 'TaskContractsController@create');//
        });

        Route::post('/devices/create', 'DevicesController@store');


        Route::group(['prefix' => 'transaction'], function() {

            Route::post('/', 'TransactionController@create');
            Route::get('/{id}', 'TransactionController@index')->where('id', '[0-9]+');
            Route::get('/user/{id}', 'TransactionController@getByUser')->where('id', '[0-9]+');
            Route::get('/token', 'TransactionController@getToken');
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

        Route::group(['prefix' => 'user'], function() {


            Route::get('/edit/{id}', 'AdminUserController@showEdit');
            Route::get('/list', 'AdminUserController@showList');
            Route::post('/save/{id}', [
                'as' => 'user/save',
                'uses' => 'AdminUserController@saveUser'
            ]);

        });

        Route::group(['prefix' => 'task-categories'], function() {
            Route::get('/all', 'TaskCategoriesController@getAll');
            Route::get('/create', 'TaskCategoriesController@getCreate');
            Route::get('/{id}', 'TaskCategoriesController@index')->where('id', '[0-9]+');
            Route::post('/create', 'TaskCategoriesController@create');
        });

    });

});
