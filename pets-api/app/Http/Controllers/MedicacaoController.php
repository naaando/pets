<?php

namespace App\Http\Controllers;

use App\Http\Requests\MedicacaoRequest;
use App\Http\Resources\MedicacaoResource;
use App\Models\Medicacao;

class MedicacaoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $user = auth()->user();
        $medicacoes = Medicacao::where('user_id', $user->id)->get();

        return MedicacaoResource::collection($medicacoes);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(MedicacaoRequest $request)
    {
        $medicacao = new Medicacao();
        $medicacao->fill($request->validated());
        $medicacao->user_id = auth()->user()->id;
        $medicacao->save();

        return new MedicacaoResource($medicacao);
    }

    /**
     * Display the specified resource.
     */
    public function show(Medicacao $medicacao)
    {
        return new MedicacaoResource($medicacao);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(MedicacaoRequest $request, Medicacao $medicacao)
    {
        $medicacao->fill($request->validated());
        $medicacao->save();

        return new MedicacaoResource($medicacao);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Medicacao $medicacao)
    {
        $medicacao->delete();
        return response()->noContent();
    }
}
