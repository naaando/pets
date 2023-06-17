<?php

namespace App\Http\Controllers;

use App\Http\Resources\PetResouce;
use App\Models\Espaco;
use App\Models\Pet;
use Illuminate\Http\Request;

class PetController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        // $request->validate([
        //     'espaco_id' => 'required|exists:espacos,id',
        // ]);

        // $espaco = Espaco::find($request->espaco_id);
        $pets = Pet::all();

        return PetResouce::collection($pets);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->merge([
            'user_id' => $request->user()->id,
        ]);

        $validated = $request->validate([
            'nome' => 'required|string',
            'imagem' => 'string',
            'user_id' => 'required|exists:users,id',
            'espaco_id' => 'exists:espacos,id',
            'especie_id' => 'exists:especies,id',
            'raca' => 'string',
            'sexo' => 'in:macho,femea',
            'nascimento' => 'date',
            'falecimento' => 'date',
            'castracao' => 'date',
        ]);

        $pet = Pet::create($validated);

        return new PetResouce($pet);
    }

    /**
     * Display the specified resource.
     */
    public function show(Pet $pet)
    {
        return new PetResouce($pet);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Pet $pet)
    {
        $request->merge([
            'user_id' => $request->user()->id,
        ]);

        $validated = $request->validate([
            'nome' => 'required|string',
            'imagem' => 'string',
            'user_id' => 'required|exists:users,id',
            'espaco_id' => 'required|exists:espacos,id',
            'especie_id' => 'required|exists:especies,id',
            'raca' => 'string',
            'sexo' => 'required|in:macho,femea',
            'nascimento' => 'date',
            'falecimento' => 'date',
            'castracao' => 'date',
        ]);

        $pet->update($validated);

        return new PetResouce($pet);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Pet $pet)
    {
        return $pet->delete();
    }
}
