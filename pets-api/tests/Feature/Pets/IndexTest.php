<?

use function Pest\Laravel\getJson;

test('empty list', function () {
    $response = getJson('/api/pets');
    $response->assertStatus(200);
    $response->isEmpty();
});
