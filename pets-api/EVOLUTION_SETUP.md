# Evolution API WhatsApp Setup

This document explains how to connect your Evolution API instance to this Laravel app.

## Prerequisites

1. Running Evolution API instance
2. Your Laravel app is accessible via a public URL (or use ngrok for local development)

## Configuration

Add these to your `.env` file:

```env
EVOLUTION_API_BASE_URL=http://your-evolution-api:8080
EVOLUTION_API_KEY=your_evolution_api_key
EVOLUTION_WEBHOOK_KEY=generate_a_secure_random_string
```

## Setup Steps

### 1. Create Instance (via Evolution Panel)

Create your WhatsApp instance using the Evolution API dashboard/panel. Use any name you like (e.g., `pets-bot`).

### 2. Set Webhook

Go to your Evolution API panel and configure the webhook for your instance:

**Webhook URL:**
```
https://your-laravel-app.com/api/webhooks/evolution/{instance_name}
```

Replace `{instance_name}` with your actual instance name.

**Events to enable:**
- `MESSAGES_UPSERT` - Required for receiving messages
- `CONNECTION_UPDATE` - Optional, for tracking connection status

**Headers:**
Add a custom header for security:
- Key: `x-webhook-key`
- Value: The value you set for `EVOLUTION_WEBHOOK_KEY` in your .env

### 3. Connect WhatsApp

Use the Evolution panel to scan the QR code and connect your WhatsApp account.

### 4. Test

Send a message to your connected WhatsApp number. The bot should respond using the AI (Prism + OpenRouter).

## How It Works

1. **Incoming message** → Evolution API sends webhook to Laravel
2. **Webhook controller** validates the `x-webhook-key` header
3. **User identification** → Looks up user by phone number in the database
4. **AI processing** → Sends message to Prism (LLM) with pet/medication tools
5. **Response** → Sends AI reply back via Evolution API

## User Phone Matching

The webhook matches incoming messages to users by looking up the phone number in the `users` table. Make sure your users have their phone numbers stored in the database.

## Customization

### Changing the AI Model

Edit `config/prism.php`:

```php
'default' => [
    'provider' => Provider::OpenRouter,
    'model' => 'openai/gpt-4o-mini',  // Change this
],
```

### Changing the System Prompt

Edit `getSystemPrompt()` method in:
`app/Http/Controllers/Webhook/EvolutionWebhookController.php`

### Adding More Tools

Add more Prism tools in the `getTools()` method of the same controller.

## Troubleshooting

**401 Unauthorized:**
- Check that `EVOLUTION_WEBHOOK_KEY` matches in both your .env and the webhook header config

**User not found:**
- Ensure the user's phone number is stored in the database and matches the WhatsApp number

**No response:**
- Check Laravel logs for errors
- Verify OpenRouter API key is configured
- Check that the webhook is correctly pointing to your Laravel app