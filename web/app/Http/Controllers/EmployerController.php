<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Constants\MarketData;
use App\Services\DatabaseService;

class EmployerController extends Controller
{
    /**
     * Portals Selection Screen (/portals)
     */
    public function portals(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        return view('pages.employer.portals', compact('activeCountry'));
    }

    /**
     * Employer Public Landing Page (/employer)
     */
    public function index(Request $request)
    {
        // If user is already logged in as employer, redirect straight to the Dashboard
        if ($user = session('auth_user')) {
            if (($user['role'] ?? '') === 'company') {
                return redirect()->route('employer.dashboard');
            }
        }

        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        $applicants = DatabaseService::getApplicants();
        $jobs = DatabaseService::getJobs();
        $candidatesCount = count($applicants);
        $jobsCount = count($jobs);
        $sampleCandidates = array_slice($applicants, 0, 5);

        return view('pages.employer.landing', compact('activeCountry', 'candidatesCount', 'jobsCount', 'sampleCandidates'));
    }

    /**
     * Authenticated Employer Dashboard (/employer/dashboard) - Screenshots 1, 2, 3
     */
    public function dashboard(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);
        $authUser = session('auth_user') ?? [
            'id' => 'demo_company',
            'company_name' => 'Al-Hamra Group',
            'full_name' => 'Fahad Al-Salem',
            'email' => 'hr@alhamra.kw',
            'role' => 'company',
            'is_verified' => true,
        ];

        $sectors = MarketData::getSectors();
        $applicants = DatabaseService::getApplicants();
        $jobs = DatabaseService::getJobs();

        $activeSectorsCount = count($sectors);
        $activeCompaniesCount = 300 + count(array_filter(DatabaseService::getUsers(), fn($u) => ($u['role'] ?? '') === 'company'));
        $professionsCount = 0;
        foreach ($sectors as $s) {
            $professionsCount += count($s['professions'] ?? []);
        }

        return view('pages.employer.dashboard', compact(
            'activeCountry',
            'authUser',
            'activeSectorsCount',
            'activeCompaniesCount',
            'professionsCount',
            'applicants',
            'sectors'
        ));
    }

    /**
     * Browse Sectors Catalog (/employer/browse) - Screenshot 4
     */
    public function browse(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);
        $authUser = session('auth_user') ?? ['company_name' => 'Employer Portal', 'role' => 'company'];

        $sectors = MarketData::getSectors();
        $query = strtolower(trim($request->query('q', '')));
        $availability = $request->query('availability', 'all');

        if (!empty($query)) {
            $sectors = array_values(array_filter($sectors, function ($s) use ($query) {
                return str_contains(strtolower($s['name_en'] ?? ''), $query)
                    || str_contains(strtolower($s['name_ar'] ?? ''), $query)
                    || str_contains(strtolower($s['code'] ?? ''), $query);
            }));
        }

        return view('pages.employer.browse', compact('activeCountry', 'authUser', 'sectors', 'query', 'availability'));
    }

    /**
     * Browse Sector Sub-Sectors & Professions (/employer/browse/{sector}) - Screenshot 5
     */
    public function browseSector(Request $request, string $sectorCode)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);
        $authUser = session('auth_user') ?? ['company_name' => 'Employer Portal', 'role' => 'company'];

        $sector = MarketData::getSector($sectorCode);
        if (!$sector) {
            return redirect()->route('employer.browse');
        }

        $activeSubSector = $request->query('subSector', 'all');
        $professions = $sector['professions'] ?? [];

        if ($activeSubSector !== 'all') {
            $professions = array_values(array_filter($professions, function ($p) use ($activeSubSector) {
                return ($p['subSector'] ?? '') === $activeSubSector;
            }));
        }

        return view('pages.employer.browse_sector', compact('activeCountry', 'authUser', 'sector', 'activeSubSector', 'professions'));
    }

    /**
     * Candidate Pool for Profession (/employer/browse/{sector}/{profession}) - Screenshot 6
     */
    public function browseProfession(Request $request, string $sectorCode, string $professionId)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);
        $authUser = session('auth_user') ?? ['company_name' => 'Employer Portal', 'role' => 'company'];

        $sector = MarketData::getSector($sectorCode);
        $allApplicants = DatabaseService::getApplicants();

        // Find profession name
        $profName = 'Specialized Role';
        if ($sector) {
            foreach ($sector['professions'] ?? [] as $p) {
                if (($p['id'] ?? '') === $professionId) {
                    $profName = $p['name_en'] ?? $profName;
                    break;
                }
            }
        }

        // Filter applicants for sector or profession
        $applicants = array_filter($allApplicants, function ($a) use ($sectorCode, $profName) {
            $aSector = strtolower($a['sector'] ?? $a['sector_code'] ?? '');
            $aProf = strtolower($a['profession'] ?? '');
            return $aSector === strtolower($sectorCode) || str_contains($aProf, strtolower($profName)) || str_contains(strtolower($profName), $aProf);
        });

        // If specific profession has few candidates, supplement with sector candidates so page is lively
        if (count($applicants) < 3) {
            $applicants = array_filter($allApplicants, function ($a) use ($sectorCode) {
                $aSector = strtolower($a['sector'] ?? $a['sector_code'] ?? '');
                return $aSector === strtolower($sectorCode) || $aSector === 'construction';
            });
        }

        // Apply URL filters (Case Type, Special Category, Experience, etc.)
        $caseType = $request->query('caseType', 'all');
        if ($caseType !== 'all') {
            $applicants = array_filter($applicants, function ($a) use ($caseType) {
                return ($a['location_type'] ?? 'inside') === $caseType;
            });
        }

        $searchName = strtolower(trim($request->query('name', '')));
        if (!empty($searchName)) {
            $applicants = array_filter($applicants, function ($a) use ($searchName) {
                return str_contains(strtolower($a['name'] ?? ''), $searchName);
            });
        }

        $applicants = array_values($applicants);

        return view('pages.employer.candidates', compact('activeCountry', 'authUser', 'sector', 'professionId', 'profName', 'applicants', 'caseType'));
    }

    /**
     * Company Profile Management (/employer/profile) - Screenshot 7
     */
    public function profile(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);
        $authUser = session('auth_user') ?? [
            'id' => 'demo_company',
            'company_name' => 'Miah General Trading & Contracting',
            'full_name' => 'Uzair Akhunzada',
            'email' => 'uzairakhunzada@gmail.com',
            'phone' => '+965 2244 5566',
            'role' => 'company',
            'governorate' => 'Sharq, Capital Governorate',
            'is_verified' => true,
        ];

        return view('pages.employer.profile', compact('activeCountry', 'authUser'));
    }

    /**
     * Update Company Profile POST
     */
    public function updateProfile(Request $request)
    {
        $validated = $request->validate([
            'company_name' => 'required|string|max:200',
            'display_name' => 'nullable|string|max:200',
            'address' => 'nullable|string|max:250',
            'phone' => 'nullable|string|max:40',
            'website' => 'nullable|string|max:200',
            'bio' => 'nullable|string|max:1000',
        ]);

        $currentUser = session('auth_user');
        if ($currentUser) {
            $updated = array_merge($currentUser, [
                'company_name' => $validated['company_name'],
                'display_name' => $validated['display_name'] ?? $validated['company_name'],
                'address' => $validated['address'] ?? '',
                'phone' => $validated['phone'] ?? ($currentUser['phone'] ?? ''),
                'website' => $validated['website'] ?? '',
                'bio' => $validated['bio'] ?? '',
            ]);

            DatabaseService::saveUser($updated);
            session(['auth_user' => $updated]);
        }

        return back()->with('success', 'Company profile updated successfully!');
    }

    /**
     * Account Settings (/employer/settings) - Screenshot 8
     */
    public function settings(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);
        $authUser = session('auth_user') ?? [
            'id' => 'demo_company',
            'company_name' => 'Miah',
            'email' => 'uzairakhunzada@gmail.com',
            'role' => 'company',
        ];

        return view('pages.employer.settings', compact('activeCountry', 'authUser'));
    }

    /**
     * Update Password POST
     */
    public function updatePassword(Request $request)
    {
        $validated = $request->validate([
            'password' => 'required|string|min:6',
        ]);

        $currentUser = session('auth_user');
        if ($currentUser) {
            $currentUser['password'] = $validated['password'];
            $currentUser['password_hash'] = password_hash($validated['password'], PASSWORD_BCRYPT);

            DatabaseService::saveUser($currentUser);
            session(['auth_user' => $currentUser]);
        }

        return back()->with('success', 'Your password has been securely updated!');
    }

    /**
     * Typing & Affiliate Offices Portal (/offices)
     */
    public function offices(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);
        $authUser = session('auth_user');

        return view('pages.employer.offices', compact('activeCountry', 'authUser'));
    }
}
