<?php

use Prism\Prism\Enums\Provider;

return [
    'default' => [
        'provider' => Provider::OpenRouter,
        'model' => 'openai/gpt-4o-mini',
    ],

    'providers' => [
        Provider::OpenRouter->value => [
            'api_key' => env('OPENROUTER_API_KEY'),
            'base_url' => 'https://openrouter.ai/api/v1',
        ],
    ],
];