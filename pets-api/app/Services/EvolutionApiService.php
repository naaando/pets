<?php

namespace App\Services;

use App\Models\WhatsappAccount;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class EvolutionApiService
{
    protected string $baseUrl;
    protected string $apiKey;

    public function __construct()
    {
        $this->baseUrl = config('services.evolution.base_url');
        $this->apiKey = config('services.evolution.key');
    }

    protected function headers(): array
    {
        return [
            'apikey' => $this->apiKey,
            'Content-Type' => 'application/json',
        ];
    }

    public function createInstance(string $instanceName): array
    {
        $response = Http::withHeaders($this->headers())
            ->post("{$this->baseUrl}/instance/create", [
                'instanceName' => $instanceName,
                'qrcode' => true,
                'integration' => 'WHATSAPP-BAILEYS',
            ]);

        return $response->json();
    }

    public function connectInstance(string $instanceName): array
    {
        $response = Http::withHeaders($this->headers())
            ->get("{$this->baseUrl}/instance/connect/{$instanceName}");

        return $response->json();
    }

    public function setWebhook(string $instanceName, string $webhookUrl, array $events = ['MESSAGES_UPDATES', 'CONNECTION_UPDATE']): array
    {
        $response = Http::withHeaders($this->headers())
            ->post("{$this->baseUrl}/webhook/set", [
                'instanceName' => $instanceName,
                'url' => $webhookUrl,
                'events' => $events,
            ]);

        return $response->json();
    }

    public function fetchInstances(): array
    {
        $response = Http::withHeaders($this->headers())
            ->get("{$this->baseUrl}/instance/fetchInstances");

        return $response->json();
    }

    public function instanceStatus(string $instanceName): array
    {
        $response = Http::withHeaders($this->headers())
            ->get("{$this->baseUrl}/instance/connectionState/{$instanceName}");

        return $response->json();
    }

    public function logoutInstance(string $instanceName): array
    {
        $response = Http::withHeaders($this->headers())
            ->delete("{$this->baseUrl}/instance/logout/{$instanceName}");

        return $response->json();
    }

    public function deleteInstance(string $instanceName): array
    {
        $response = Http::withHeaders($this->headers())
            ->delete("{$this->baseUrl}/instance/delete/{$instanceName}");

        return $response->json();
    }

    public function sendText(string $instanceName, string $number, string $text): array
    {
        $response = Http::withHeaders($this->headers())
            ->post("{$this->baseUrl}/message/sendText/{$instanceName}", [
                'number' => $number,
                'text' => $text,
            ]);

        return $response->json();
    }

    public function sendImage(string $instanceName, string $number, string $imageUrl, ?string $caption = null): array
    {
        $response = Http::withHeaders($this->headers())
            ->post("{$this->baseUrl}/message/sendImage/{$instanceName}", [
                'number' => $number,
                'image' => $imageUrl,
                'caption' => $caption,
            ]);

        return $response->json();
    }

    public function updateProfileName(string $instanceName, string $name): array
    {
        $response = Http::withHeaders($this->headers())
            ->put("{$this->baseUrl}/profile/update/{$instanceName}", [
                'name' => $name,
            ]);

        return $response->json();
    }

    public function updateProfileStatus(string $instanceName, string $status): array
    {
        $response = Http::withHeaders($this->headers())
            ->put("{$this->baseUrl}/profile/updateStatus/{$instanceName}", [
                'status' => $status,
            ]);

        return $response->json();
    }

    public function findOrCreateInstance(WhatsappAccount $account): void
    {
        try {
            $createResult = $this->createInstance($account->instance_name);

            if (isset($createResult['qrcode'])) {
                $account->qr_code = $createResult['qrcode']['code'];
                $account->status = 'pending';
                $account->save();
            }

            $connectResult = $this->connectInstance($account->instance_name);

            if (isset($connectResult['qrcode'])) {
                $account->qr_code = $connectResult['qrcode']['code'];
                $account->save();
            }

            $webhookUrl = config('app.url') . "/api/webhooks/evolution/{$account->instance_name}";
            $this->setWebhook($account->instance_name, $webhookUrl);

            $account->webhook_url = $webhookUrl;
            $account->webhook_enabled = true;
            $account->save();
        } catch (\Exception $e) {
            Log::error('Evolution API error: ' . $e->getMessage());
            throw $e;
        }
    }
}