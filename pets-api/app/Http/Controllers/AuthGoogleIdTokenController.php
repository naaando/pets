<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Google\Client;
use Illuminate\Support\Str;

class AuthGoogleIdTokenController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(Request $request)
    {
        $client = new Client();
        $payload = $client->verifyIdToken($request->header('idToken'));

        $user = User::where('email', $payload['email'])->first();

        // Register user
        if (!$user) {
            $user = User::create($payload);
        }

        return $user->createToken($request->device_name ?? Str::random())->plainTextToken;
    }
}
