<?php

namespace App\Http\Controllers;

use App\Http\Requests\PetRequest;
use App\Http\Resources\PetResouce;
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
        $pets = Pet::where('user_id', $request->user()->id)->get();

        return PetResouce::collection($pets);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(PetRequest $request)
    {
        $pet = $request->user()->pets()->create($request->validated());
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
    public function update(PetRequest $request, Pet $pet)
    {
        $pet->update($request->validated());
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
