<?php

namespace App\Http\Controllers;

use App\Http\Resources\EspacoResource;
use App\Models\Espaco;
use Illuminate\Http\Request;

class EspacoController extends Controller
{
    public function __construct()
    {
        $this->authorizeResource(Espaco::class, 'espaco');
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $espacos = $request->user()->espacos;
        return EspacoResource::collection($espacos);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate(['nome' => 'required|string']);
        $espaco = $request->user()->espacos()->create($request->only('nome'));
        return new EspacoResource($espaco);
    }

    /**
     * Display the specified resource.
     */
    public function show(Espaco $espaco)
    {
        return new EspacoResource($espaco);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Espaco $espaco)
    {
        $request->validate(['nome' => 'required|string']);
        $espaco->update($request->only('nome'));
        return new EspacoResource($espaco);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Espaco $espaco)
    {
        return $espaco->delete();
    }
}
