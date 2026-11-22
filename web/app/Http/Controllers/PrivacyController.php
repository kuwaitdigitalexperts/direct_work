<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Constants\MarketData;

class PrivacyController extends Controller
{
    /**
     * Display the official Privacy Policy page for Android, iOS, and Web.
     */
    public function index(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        return view('pages.privacy', compact('activeCountry'));
    }

    /**
     * Optional Terms & Conditions view if accessed directly.
     */
    public function terms(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        return view('pages.terms', compact('activeCountry'));
    }
}
