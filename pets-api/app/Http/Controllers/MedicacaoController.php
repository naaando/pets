<?php

namespace App\Http\Controllers;

use App\Http\Requests\MedicacaoRequest;
use App\Http\Resources\MedicacaoResource;
use App\Models\Medicacao;
use App\Models\Pet;
use Illuminate\Http\Request;

class MedicacaoController extends Controller
{
    public function __construct()
    {
        $this->authorizeResource(Medicacao::class, 'medicaco');
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $user = $request->user();

        $medicacoes = $user->petsCompartilhados()
            ->with('medicacoes')
            ->get()
            ->pluck('medicacoes')
            ->flatten();

        return MedicacaoResource::collection($medicacoes);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(MedicacaoRequest $request)
    {
        $medicacao = new Medicacao();
        $medicacao->fill($request->validated());
        $medicacao->user_id = $request->user()->id;
        $medicacao->save();

        return new MedicacaoResource($medicacao);
    }

    /**
     * Display the specified resource.
     */
    public function show(Medicacao $medicaco)
    {
        return new MedicacaoResource($medicaco);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(MedicacaoRequest $request, Medicacao $medicaco)
    {
        $medicaco->fill($request->validated());
        $medicaco->save();

        return new MedicacaoResource($medicaco);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Medicacao $medicaco)
    {
        $medicaco->delete();
        return response()->noContent();
    }
}
