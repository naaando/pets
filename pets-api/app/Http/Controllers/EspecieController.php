<?php

namespace App\Http\Controllers;

use App\Http\Resources\EspecieResource;
use App\Models\Especie;

class EspecieController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return EspecieResource::collection(Especie::all());
    }
}
