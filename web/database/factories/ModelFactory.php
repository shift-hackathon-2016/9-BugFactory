<?php

/*
|--------------------------------------------------------------------------
| Model Factories
|--------------------------------------------------------------------------
|
| Here you may define all of your model factories. Model factories give
| you a convenient way to create models for testing and seeding your
| database. Just tell the factory how a default model should look.
|
*/

$factory->define(App\Models\Db\User::class, function (Faker\Generator $faker) {
    return [
        'email' => $faker->safeEmail,
        'first_name' => $faker->firstName,
        'last_name' => $faker->lastName,
        'password' => bcrypt('test123'),
        'remember_token' => str_random(10),
    ];
});

$factory->define(App\Models\Db\Task::class, function (Faker\Generator $faker) {
    return [
        'category_id' => 1,
        'user_id' => 1,
        'location_id' => 1,
        'description' => $faker->text(),
        'currency_id' => 1,
        'amount' => $faker->numberBetween(0, 321312),
        'ends_at' => $faker->dateTime,
        'starts_at' => $faker->dateTime
    ];
});

$factory->define(App\Models\Db\Location::class, function (Faker\Generator $faker) {
    return [
        'latitude' => $faker->latitude,
        'longitude' => $faker->longitude,
        'city' => $faker->city,
        'country' => $faker->country,
        'street' => $faker->streetName,
        'zip' => $faker->postcode
    ];
});

