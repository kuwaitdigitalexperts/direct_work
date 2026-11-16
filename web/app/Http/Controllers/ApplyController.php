<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Constants\MarketData;
use App\Services\DatabaseService;

class ApplyController extends Controller
{
    public function index(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);
        $sectors = MarketData::getSectors();
        $nationalities = MarketData::getNationalities();

        $selectedSector = $request->query('sector', $sectors[0]['code'] ?? 'construction');
        $selectedProfession = $request->query('profession', '');

        return view('pages.apply.index', compact('activeCountry', 'sectors', 'nationalities', 'selectedSector', 'selectedProfession'));
    }

    public function store(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        $validated = $request->validate([
            'sector' => 'required|string',
            'profession' => 'required|string',
            'name' => 'required|string|max:150',
            'phone' => 'required|string|max:30',
            'email' => 'nullable|email|max:150',
            'governorate' => 'required|string',
            'nationality' => 'required|string',
            'experience_years' => 'required|integer|min:0|max:50',
            'bio' => 'required|string|min:20',
            'cv_file' => 'nullable|file|mimes:pdf,doc,docx|max:10240',
            'payment_method' => 'required|string',
        ]);

        $cvFileName = null;
        if ($request->hasFile('cv_file')) {
            $file = $request->file('cv_file');
            $cvFileName = time() . '_' . $file->getClientOriginalName();
            $file->move(public_path('uploads/cvs'), $cvFileName);
        }

        $appliedAt = date('Y-m-d H:i:s');
        $expiresAt = date('Y-m-d H:i:s', strtotime('+90 days'));
        $prefix = strtoupper($countryCode);
        $txnId = $prefix . '-' . substr(time(), 4) . '-' . rand(100, 999);

        $appData = [
            'id' => 'app_' . time() . '_' . rand(100, 999),
            'profession' => $validated['profession'],
            'sector' => $validated['sector'],
            'sector_title' => MarketData::getSector($validated['sector'])['name_en'] ?? $validated['sector'],
            'location_type' => 'inside',
            'name' => $validated['name'],
            'phone' => $validated['phone'],
            'email' => $validated['email'] ?? '',
            'governorate' => $validated['governorate'],
            'nationality' => $validated['nationality'],
            'experience_years' => (int)$validated['experience_years'],
            'bio' => $validated['bio'],
            'cv_path' => $cvFileName,
            'duration' => '3 months',
            'duration_months' => 3,
            'price' => $activeCountry['fee_display'] . ' ' . $activeCountry['currency_en'],
            'price_amount' => $activeCountry['ad_fee'],
            'currency' => $activeCountry['currency_en'],
            'payment_method' => $validated['payment_method'],
            'payment_id' => $txnId,
            'payment_status' => 'paid',
            'applied_at' => $appliedAt,
            'expires_at' => $expiresAt,
        ];

        DatabaseService::saveApplication($appData);

        return redirect()->route('apply.success', ['id' => $appData['id']]);
    }

    public function success(string $id)
    {
        $applicant = DatabaseService::getApplicant($id);
        if (!$applicant) {
            return redirect()->route('home');
        }

        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        return view('pages.apply.success', compact('applicant', 'activeCountry'));
    }
}
