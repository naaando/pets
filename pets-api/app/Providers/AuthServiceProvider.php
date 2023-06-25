<?php

namespace App\Providers;

// use Illuminate\Support\Facades\Gate;

use App\Models\Pet;
use App\Models\User;
use App\Models\Vacina;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Gate;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The model to policy mappings for the application.
     *
     * @var array<class-string, class-string>
     */
    protected $policies = [
        //
    ];

    /**
     * Register any authentication / authorization services.
     */
    public function boot(): void
    {
        Gate::define('save-pet', function (User $user, Pet|null $pet = null) {
            if ($pet === null) {
                return true;
            }

            return $user->id === $pet->user_id;
        });

        Gate::define('update-vacine', function (User $user, Pet|null $pet = null, Vacina|null $vacina = null) {
            if ($vacina && $vacina->pet->user->isNot($user)) {
                return false;
            }

            return $user->is($pet->user);
        });
    }
}
