<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
         $this->call(SeedUsersTable::class);
         $this->call(TasksSeeder::class);
         $this->call(LocationSeeder::class);
    }
}
