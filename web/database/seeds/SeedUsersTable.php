<?php

use Illuminate\Database\Seeder;

class SeedUsersTable extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(\App\Models\Db\User::class, 10)->create();
    }

}
