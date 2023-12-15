<?php

namespace App\Providers;

// use Illuminate\Support\Facades\Gate;

use App\Models\Medicacao;
use App\Models\Pet;
use App\Models\User;
use App\Policies\PetPolicy;
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
        Pet::class => PetPolicy::class,
    ];

    /**
     * Register any authentication / authorization services.
     */
    public function boot(): void
    {
        Gate::define('viewPulse', function (User $user) {
            return $user->is_admin;
        });

        Gate::define('save-pet', function (User $user, Pet|null $pet = null) {
            if ($pet === null) {
                return true;
            }

            return $user->id === $pet->user_id;
        });

        Gate::define('update-medicacao', function (User $user, Pet|null $pet = null, Medicacao|null $medicacao = null) {
            if ($medicacao && $medicacao->pet->user->isNot($user)) {
                return false;
            }

            return $user->is($pet->user);
        });
    }
}
