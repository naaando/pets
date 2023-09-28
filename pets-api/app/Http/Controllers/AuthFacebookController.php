<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Str;

class AuthFacebookController extends Controller
{
    public const FACEBOOK_GRAPH_URL = 'https://graph.facebook.com/v17.0';

    /**
     * Handle the incoming request.
     */
    public function __invoke(Request $request)
    {
        $response = Http::get(self::FACEBOOK_GRAPH_URL . '/me', [
            'fields' => 'id,name,email,picture{url}',
            'access_token' => $request->token,
        ]);

        $userData = [
            'sub' => $response['id'],
            'iss' => 'facebook',
            'name' => $response['name'],
            'email' => $response['email'],
            'picture' => $response['picture']['data']['url'],
            'email_verified_at' => now(),
        ];

        $user = User::where('email', $userData['email'])
            ->first();

        // Register user
        if (!$user) {
            $user = User::create($userData);
        }

        return $user->createToken($request->device_name ?? Str::random())->plainTextToken;
    }
}
