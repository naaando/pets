<?php

namespace App\Http\Controllers;

use App\Http\Resources\UserResource;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function show(Request $request)
    {
        $user = $request->user();
        $user->load('espacos');

        if ($user->espacos->isEmpty()) {
            $user->espaco()->create(['nome' => 'Meu espaço']);
        }

        return new UserResource($request->user());
    }
}
