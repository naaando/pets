<?php

namespace App\Http\Controllers;

use App\Http\Requests\PetVacinaRequest;
use App\Http\Resources\PetVacinaResource;
use App\Models\Pet;
use App\Models\PetVacina;

class PetVacinaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Pet $pet, )
    {
        return PetVacinaResource::collection(PetVacina::all());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(PetVacinaRequest $request, Pet $pet)
    {
        $vacina = PetVacina::create($request->validated());
        return new PetVacinaResource($vacina);
    }

    /**
     * Display the specified resource.
     */
    public function show(PetVacina $vacina, Pet $pet)
    {
        return new PetVacinaResource($vacina);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(PetVacinaRequest $request, Pet $pet, PetVacina $vacina)
    {
        $vacina->update($request->validated());
        return new PetVacinaResource($vacina);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Pet $pet, PetVacina $vacina)
    {
        $vacina->delete();
        return response()->noContent();
    }
}
