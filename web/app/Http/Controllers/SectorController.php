<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Constants\MarketData;
use App\Services\DatabaseService;

class SectorController extends Controller
{
    public function index(Request $request)
    {
        $sectors = MarketData::getSectors();
        $q = trim($request->query('q', ''));
        $category = $request->query('category', 'all');

        if (!empty($q)) {
            $qLower = strtolower($q);
            $sectors = array_filter($sectors, function ($s) use ($qLower) {
                return str_contains(strtolower($s['name_en'] ?? ''), $qLower)
                    || str_contains(strtolower($s['name_ar'] ?? ''), $qLower)
                    || str_contains(strtolower($s['code'] ?? ''), $qLower);
            });
        }

        return view('pages.sectors.index', compact('sectors', 'q', 'category'));
    }

    public function show(string $code)
    {
        $sector = MarketData::getSector($code);
        if (!$sector) {
            abort(404, 'Sector not found');
        }

        // Get applicants in this sector
        $applicants = DatabaseService::getApplicants(['sector' => $code]);

        // Get jobs in this sector
        $countryCode = session('selected_country', 'kw');
        $jobs = DatabaseService::getJobs(['sector' => $code, 'country' => $countryCode]);

        return view('pages.sectors.show', compact('sector', 'applicants', 'jobs'));
    }
}
