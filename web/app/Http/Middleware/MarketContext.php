<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use App\Constants\MarketData;
use Illuminate\Support\Facades\View;
use Illuminate\Support\Facades\App;

class MarketContext
{
    public function handle(Request $request, Closure $next): Response
    {
        // 1. Determine active country (kw, sa, ae)
        $countryCode = $request->query('country')
            ?? session('selected_country')
            ?? $request->cookie('selected_country')
            ?? 'kw';

        $validCountries = ['kw', 'sa', 'ae'];
        if (!in_array($countryCode, $validCountries)) {
            $countryCode = 'kw';
        }

        session(['selected_country' => $countryCode]);
        $activeCountry = MarketData::getCountry($countryCode);

        // 2. Determine active locale (en, ar)
        $locale = $request->query('lang')
            ?? session('locale')
            ?? $request->cookie('locale')
            ?? 'en';

        if (!in_array($locale, ['en', 'ar'])) {
            $locale = 'en';
        }

        session(['locale' => $locale]);
        App::setLocale($locale);

        $isArabic = ($locale === 'ar');

        // Share globally with all views
        View::share('activeCountry', $activeCountry);
        View::share('currentLocale', $locale);
        View::share('isArabic', $isArabic);
        View::share('allCountries', MarketData::getCountries());

        return $next($request);
    }
}
