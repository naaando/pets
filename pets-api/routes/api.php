<?php

use App\Http\Controllers\AuthGoogleIdTokenController;
use App\Http\Controllers\EspecieController;
use App\Http\Controllers\PetController;
use App\Http\Controllers\PetImageController;
use App\Http\Controllers\PetVacinaController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::get('auth/google-idtoken', AuthGoogleIdTokenController::class);
Route::middleware('auth:sanctum')->get('/user', [UserController::class, 'show']);
Route::middleware('auth:sanctum')->get('/especies', [EspecieController::class, 'index']);
Route::middleware('auth:sanctum')->apiResource('pets', PetController::class);
Route::middleware('auth:sanctum')->apiResource('pets.vacinas', PetVacinaController::class);
Route::middleware('auth:sanctum')->apiSingleton('pets.image', PetImageController::class)->destroyable();
