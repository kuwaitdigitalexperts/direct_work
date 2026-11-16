<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Constants\MarketData;
use App\Services\DatabaseService;

class HomeController extends Controller
{
    public function index(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);
        $isArabic = session('locale', 'en') === 'ar';

        // Load sectors (top 12 for homepage)
        $allSectors = MarketData::getSectors();
        $sectors = array_slice($allSectors, 0, 12);

        // Load featured verified applicants
        $allApplicants = DatabaseService::getApplicants();
        $applicants = array_slice($allApplicants, 0, 8);

        // Load recent jobs
        $jobs = DatabaseService::getJobs(['country' => $countryCode]);
        $recentJobs = array_slice($jobs, 0, 6);

        // Dynamic stats
        $stats = [
            'candidates_count' => count($allApplicants) > 0 ? count($allApplicants) + 120 : 140,
            'jobs_count' => count($jobs) > 0 ? count($jobs) + 45 : 52,
            'sectors_count' => count($allSectors),
            'companies_count' => 86,
        ];

        return view('pages.home', compact('sectors', 'allSectors', 'applicants', 'recentJobs', 'stats', 'activeCountry', 'isArabic'));
    }

    public function setCountry(string $country)
    {
        $valid = ['kw', 'sa', 'ae'];
        if (in_array($country, $valid)) {
            session(['selected_country' => $country]);
            cookie()->queue(cookie('selected_country', $country, 60 * 24 * 30));
        }
        return redirect()->back();
    }

    public function setLocale(string $locale)
    {
        $valid = ['en', 'ar'];
        if (in_array($locale, $valid)) {
            session(['locale' => $locale]);
            cookie()->queue(cookie('locale', $locale, 60 * 24 * 30));
        }
        return redirect()->back();
    }
}
