<?php

use App\Http\Controllers\AuthFacebookController;
use App\Http\Controllers\AuthGoogleIdTokenController;
use App\Http\Controllers\Chatbot\ChatController;
use App\Http\Controllers\EspacoController;
use App\Http\Controllers\EspecieController;
use App\Http\Controllers\MedicacaoController;
use App\Http\Controllers\PetController;
use App\Http\Controllers\PetImageController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\Webhook\EvolutionWebhookController;
use App\Http\Controllers\Whatsapp\WhatsappAccountController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will be
| assigned to the "api" middleware group. Make something great!
|
*/

Route::get('auth/google-idtoken', AuthGoogleIdTokenController::class);
Route::post('auth/facebook', AuthFacebookController::class);

Route::middleware('auth:sanctum')->get('/user', [UserController::class, 'show']);
Route::middleware('auth:sanctum')->get('/especies', [EspecieController::class, 'index']);
Route::middleware('auth:sanctum')->apiResource('pets', PetController::class);
Route::middleware('auth:sanctum')->apiResource('medicacoes', MedicacaoController::class);
Route::middleware('auth:sanctum')->apiSingleton('pets.image', PetImageController::class)->destroyable();
Route::middleware('auth:sanctum')->apiResource('espacos', EspacoController::class);

// Chatbot routes
Route::middleware('auth:sanctum')->post('/chat', [ChatController::class, 'chat']);
Route::middleware('auth:sanctum')->post('/chat/stream', [ChatController::class, 'stream']);

// WhatsApp/Evolution API routes
Route::middleware('auth:sanctum')->apiResource('whatsapp', WhatsappAccountController::class);

// Webhook routes (no auth - called by Evolution API)
Route::post('/webhooks/evolution/{instanceName}', [EvolutionWebhookController::class, 'handle']);
