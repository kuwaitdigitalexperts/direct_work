<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Constants\MarketData;
use App\Services\DatabaseService;

class ApplicantController extends Controller
{
    public function index(Request $request)
    {
        $filters = [
            'sector' => $request->query('sector', 'all'),
            'governorate' => $request->query('governorate', 'all'),
            'search' => $request->query('search', ''),
            'nationality' => $request->query('nationality', 'all'),
            'category' => $request->query('category', 'all'),
        ];

        $applicants = DatabaseService::getApplicants($filters);
        $sectors = MarketData::getSectors();
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        return view('pages.applicants.index', compact('applicants', 'filters', 'sectors', 'activeCountry'));
    }

    public function show(string $id)
    {
        $applicant = DatabaseService::getApplicant($id);
        if (!$applicant) {
            abort(404, 'Candidate not found');
        }

        $sector = MarketData::getSector($applicant['sector'] ?? '');
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        return view('pages.applicants.show', compact('applicant', 'sector', 'activeCountry'));
    }
}
