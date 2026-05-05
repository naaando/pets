<?php

namespace App\Http\Controllers\Whatsapp;

use App\Http\Controllers\Controller;
use App\Models\WhatsappAccount;
use App\Services\EvolutionApiService;
use Illuminate\Http\Request;

class WhatsappAccountController extends Controller
{
    protected EvolutionApiService $evolution;

    public function __construct()
    {
        $this->evolution = new EvolutionApiService();
    }

    public function index(Request $request)
    {
        $accounts = WhatsappAccount::where('user_id', $request->user()->id)
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json($accounts);
    }

    public function store(Request $request)
    {
        $request->validate([
            'instance_name' => 'required|string|unique:whatsapp_accounts,instance_name',
        ]);

        $account = WhatsappAccount::create([
            'user_id' => $request->user()->id,
            'instance_name' => $request->input('instance_name'),
            'status' => 'creating',
        ]);

        try {
            $this->evolution->findOrCreateInstance($account);
        } catch (\Exception $e) {
            $account->status = 'error';
            $account->save();

            return response()->json([
                'error' => 'Failed to create instance: ' . $e->getMessage(),
            ], 500);
        }

        return response()->json($account, 201);
    }

    public function show(WhatsappAccount $whatsappAccount)
    {
        $this->authorize('view', $whatsappAccount);

        try {
            $status = $this->evolution->instanceStatus($whatsappAccount->instance_name);
            $whatsappAccount->status = $status['instance'] ?? $whatsappAccount->status;
            $whatsappAccount->save();
        } catch (\Exception $e) {
            Log::warning("Failed to fetch instance status: " . $e->getMessage());
        }

        return response()->json($whatsappAccount);
    }

    public function refreshQr(WhatsappAccount $whatsappAccount)
    {
        $this->authorize('update', $whatsappAccount);

        try {
            $connectResult = $this->evolution->connectInstance($whatsappAccount->instance_name);

            if (isset($connectResult['qrcode'])) {
                $whatsappAccount->qr_code = $connectResult['qrcode']['code'];
                $whatsappAccount->status = 'pending';
                $whatsappAccount->save();
            }
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to refresh QR: ' . $e->getMessage(),
            ], 500);
        }

        return response()->json($whatsappAccount);
    }

    public function logout(WhatsappAccount $whatsappAccount)
    {
        $this->authorize('update', $whatsappAccount);

        try {
            $this->evolution->logoutInstance($whatsappAccount->instance_name);
            $whatsappAccount->status = 'disconnected';
            $whatsappAccount->save();
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to logout: ' . $e->getMessage(),
            ], 500);
        }

        return response()->json($whatsappAccount);
    }

    public function destroy(WhatsappAccount $whatsappAccount)
    {
        $this->authorize('delete', $whatsappAccount);

        try {
            $this->evolution->deleteInstance($whatsappAccount->instance_name);
            $whatsappAccount->delete();
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to delete: ' . $e->getMessage(),
            ], 500);
        }

        return response()->json(['deleted' => true]);
    }
}