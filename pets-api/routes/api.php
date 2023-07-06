<?php

use App\Http\Controllers\AuthFacebookController;
use App\Http\Controllers\AuthGoogleIdTokenController;
use App\Http\Controllers\EspecieController;
use App\Http\Controllers\MedicacaoController;
use App\Http\Controllers\PetController;
use App\Http\Controllers\PetImageController;
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
Route::post('auth/facebook', AuthFacebookController::class);

Route::middleware('auth:sanctum')->get('/user', [UserController::class, 'show']);
Route::middleware('auth:sanctum')->get('/especies', [EspecieController::class, 'index']);
Route::middleware('auth:sanctum')->apiResource('pets', PetController::class);
Route::middleware('auth:sanctum')->apiResource('medicacoes', MedicacaoController::class);
Route::middleware('auth:sanctum')->apiSingleton('pets.image', PetImageController::class)->destroyable();
