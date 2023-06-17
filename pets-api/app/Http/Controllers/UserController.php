<?php

namespace App\Http\Controllers;

use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function show(Request $request)
    {
        /** @var User */
        $user = $request->user();

        if ($user->espacos->isEmpty()) {
            $espaco = $user->espacos()->create(['nome' => 'Meu espaço']);
            $user->espacoAtivo()->associate($espaco);
            $user->save();
        }

        return new UserResource($request->user()->load('espacoAtivo'));
    }
}
