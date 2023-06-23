<?

use App\Models\Pet;

use function Pest\Laravel\getJson;

uses(\Illuminate\Foundation\Testing\RefreshDatabase::class);

test('empty list', function () {
    $response = getJson('/api/pets');
    $response->assertStatus(200);
    $response->isEmpty();
});
