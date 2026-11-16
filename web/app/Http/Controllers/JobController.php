<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Constants\MarketData;
use App\Services\DatabaseService;

class JobController extends Controller
{
    public function index(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $filters = [
            'country' => $countryCode,
            'sector' => $request->query('sector', 'all'),
            'governorate' => $request->query('governorate', 'all'),
            'search' => $request->query('search', ''),
        ];

        $jobs = DatabaseService::getJobs($filters);
        $sectors = MarketData::getSectors();
        $activeCountry = MarketData::getCountry($countryCode);

        return view('pages.jobs.index', compact('jobs', 'filters', 'sectors', 'activeCountry'));
    }

    public function show(string $id)
    {
        $job = DatabaseService::getJob($id);
        if (!$job) {
            abort(404, 'Job vacancy not found');
        }

        $countryCode = $job['country'] ?? $job['country_code'] ?? session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);
        $sector = MarketData::getSector($job['sector_code'] ?? $job['sector'] ?? '');

        return view('pages.jobs.show', compact('job', 'activeCountry', 'sector'));
    }

    public function create()
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);
        $sectors = MarketData::getSectors();

        return view('pages.jobs.create', compact('activeCountry', 'sectors'));
    }

    public function store(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        $validated = $request->validate([
            'title' => 'required|string|max:200',
            'company_name' => 'required|string|max:200',
            'sector_code' => 'required|string',
            'profession_name' => 'nullable|string',
            'governorate_id' => 'required|string',
            'work_type' => 'required|string',
            'salary' => 'nullable|numeric',
            'description' => 'required|string|min:20',
            'requirements' => 'nullable|string',
            'whatsapp_number' => 'required|string',
            'phone_number' => 'nullable|string',
        ]);

        $sector = MarketData::getSector($validated['sector_code']);
        $govs = collect($activeCountry['regions'])->keyBy('id');
        $govName = $govs[$validated['governorate_id']]['name_en'] ?? $validated['governorate_id'];

        $reqList = [];
        if (!empty($validated['requirements'])) {
            $reqList = array_filter(array_map('trim', explode("\n", $validated['requirements'])));
        }

        $jobData = [
            'id' => 'job_' . time() . '_' . rand(100, 999),
            'title' => $validated['title'],
            'company_name' => $validated['company_name'],
            'sector_code' => $validated['sector_code'],
            'sector_name' => $sector['name_en'] ?? $validated['sector_code'],
            'profession_name' => $validated['profession_name'] ?? $validated['title'],
            'governorate_id' => $validated['governorate_id'],
            'governorate_name' => $govName,
            'country' => $countryCode,
            'country_code' => $countryCode,
            'work_type' => $validated['work_type'],
            'candidate_category' => 'all',
            'salary_kwd' => (float)($validated['salary'] ?? 0),
            'salary_amount' => (float)($validated['salary'] ?? 0),
            'currency' => $activeCountry['currency_en'],
            'description' => $validated['description'],
            'requirements' => $reqList,
            'whatsapp_number' => $validated['whatsapp_number'],
            'phone_number' => $validated['phone_number'] ?? $validated['whatsapp_number'],
            'is_pinned' => false,
            'is_featured' => true,
            'views_count' => 1,
            'created_at' => date('Y-m-d H:i:s'),
            'is_applied' => false,
        ];

        DatabaseService::saveJob($jobData);

        return redirect()->route('jobs.show', $jobData['id'])->with('success', 'Job vacancy published successfully!');
    }
}
