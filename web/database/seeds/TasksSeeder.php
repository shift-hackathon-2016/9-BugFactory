<?php

use App\Models\Db\Currency;
use App\Models\Db\Location;
use App\Models\Db\Task;
use App\Models\Db\TaskCategory;
use App\Models\Db\User;
use Illuminate\Database\Seeder;

class TasksSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $category = TaskCategory::first();
        $user = User::first();
        $location = Location::first();
        $currency = Currency::first();

        factory(Task::class, 10)->create([
            'category_id' => $category->id,
            'user_id' => $user->id,
            'location_id' => $location->id,
            'currency_id' => $currency->id,
        ]);
    }

}
