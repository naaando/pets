<?php

namespace App\Http\Controllers;

use App\Http\Requests\VacinaRequest;
use App\Http\Resources\VacinaResource;
use App\Models\Vacina;
use Illuminate\Http\Request;

class VacinaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $user = auth()->user();
        $vacinas = Vacina::where('user_id', $user->id)->get();

        return VacinaResource::collection($vacinas);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(VacinaRequest $request)
    {
        $vacina = Vacina::create($request->validated());
        return new VacinaResource($vacina);
    }

    /**
     * Display the specified resource.
     */
    public function show(Vacina $vacina)
    {
        return new VacinaResource($vacina);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(VacinaRequest $request, Vacina $vacina)
    {
        $vacina->update($request->validated());
        return new VacinaResource($vacina);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Vacina $vacina)
    {
        $vacina->delete();
        return response()->noContent();
    }
}
