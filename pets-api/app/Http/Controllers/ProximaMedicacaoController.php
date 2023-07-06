<?php

namespace App\Http\Controllers;

use App\Http\Resources\MedicacaoResource;
use App\Models\Medicacao;

class ProximaMedicacaoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $user = auth()->user();
        $medicacoes = Medicacao::where('user_id', $user->id)
            ->whereNotNull('proxima_dose')
            ->get();

        return MedicacaoResource::collection($medicacoes);
    }
}
