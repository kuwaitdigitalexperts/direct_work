<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Constants\MarketData;

class PricingController extends Controller
{
    public function index(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);
        $packages = MarketData::getAdPackages($countryCode);

        return view('pages.pricing.index', compact('activeCountry', 'packages'));
    }
}
