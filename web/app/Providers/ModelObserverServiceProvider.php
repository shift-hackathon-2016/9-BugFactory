<?php

namespace App\Providers;

use App\Models\Db\Location;
use App\Models\Db\Notification;
use App\Models\Db\PushNotification;
use App\Models\Db\Task;
use App\Observers\LocationObserver;
use App\Observers\NotificationObserver;
use App\Observers\PushNotificationObserver;
use App\Observers\TaskObserver;
use Illuminate\Support\ServiceProvider;

class ModelObserverServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        Location::observe(new LocationObserver());
        Notification::observe(new NotificationObserver());
        PushNotification::observe(new PushNotificationObserver());
        Task::observe(new TaskObserver());
    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}
