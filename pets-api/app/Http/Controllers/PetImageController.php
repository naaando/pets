<?php

namespace App\Http\Controllers;

use App\Models\Pet;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class PetImageController extends Controller
{
    public function __construct()
    {
        $this->authorizeResource(Pet::class, 'pet');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function update(Request $request, Pet $pet)
    {
        $request->validate([
            'file' => 'required|image',
        ]);

        $path = $request->file('file')->storePublicly('pets');

        if ($pet->imagem) {
            Storage::delete($pet->imagem);
        }

        $pet->imagem = $path;
        $pet->save();

        return response()->json(['path' => $path]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Pet $pet)
    {
        $this->authorize('delete', $pet);
        Storage::delete($pet->imagem);
        $pet->imagem = null;
        $pet->save();
        return response('', 204);
    }
}
