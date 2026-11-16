<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Constants\MarketData;
use App\Services\DatabaseService;

class AuthController extends Controller
{
    // =========================================================================
    // EMPLOYER AUTHENTICATION (/employer/login, /employer/register, /login, /register)
    // =========================================================================

    public function employerLogin(Request $request)
    {
        if ($user = session('auth_user')) {
            if (($user['role'] ?? '') === 'company') {
                return redirect()->route('employer');
            }
            return redirect()->route('home');
        }

        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        return view('pages.auth.employer_login', compact('activeCountry'));
    }

    public function postEmployerLogin(Request $request)
    {
        $validated = $request->validate([
            'credential' => 'required|string',
            'password' => 'required|string',
        ]);

        $user = DatabaseService::authenticateUser($validated['credential'], $validated['password'], 'company');

        if (!$user) {
            // Also check if user exists with another role to provide friendly notice
            $existing = DatabaseService::findUser($validated['credential']);
            if ($existing && ($existing['role'] ?? '') !== 'company') {
                return back()->withErrors([
                    'credential' => 'This account is registered as ' . ($existing['role'] ?? 'user') . '. Please sign in through the appropriate portal.',
                ])->withInput();
            }

            return back()->withErrors([
                'credential' => 'Invalid email/phone or password. Please check your credentials.',
            ])->withInput();
        }

        session(['auth_user' => $user]);

        return redirect()->route('employer')->with('success', 'Welcome back, ' . ($user['company_name'] ?? $user['full_name'] ?? 'Employer') . '!');
    }

    public function employerRegister(Request $request)
    {
        if (session('auth_user')) {
            return redirect()->route('employer');
        }

        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        return view('pages.auth.employer_register', compact('activeCountry'));
    }

    public function postEmployerRegister(Request $request)
    {
        $validated = $request->validate([
            'company_name' => 'required|string|max:200',
            'full_name' => 'required|string|max:150',
            'email' => 'required|email|max:150',
            'phone' => 'required|string|max:30',
            'commercial_license' => 'nullable|string|max:100',
            'governorate' => 'required|string',
            'password' => 'required|string|min:6',
        ]);

        // Check if account already exists
        if (DatabaseService::findUser($validated['email'])) {
            return back()->withErrors([
                'email' => 'An account with this email is already registered. Please sign in.',
            ])->withInput();
        }

        $cleanPhone = preg_replace('/[^0-9]/', '', $validated['phone']);
        if (!empty($cleanPhone) && DatabaseService::findUser($cleanPhone)) {
            return back()->withErrors([
                'phone' => 'An account with this phone number is already registered.',
            ])->withInput();
        }

        $userData = [
            'id' => 'kw_company_' . time() . '_' . rand(10, 99),
            'company_name' => $validated['company_name'],
            'full_name' => $validated['full_name'],
            'email' => strtolower(trim($validated['email'])),
            'phone' => trim($validated['phone']),
            'commercial_license' => $validated['commercial_license'] ?? '',
            'governorate' => $validated['governorate'],
            'role' => 'company',
            'password' => $validated['password'], // for mobile API compatibility
            'password_hash' => password_hash($validated['password'], PASSWORD_BCRYPT),
            'is_verified' => true,
            'created_at' => date('Y-m-d H:i:s'),
        ];

        DatabaseService::saveUser($userData);

        session(['auth_user' => $userData]);

        return redirect()->route('employer')->with('success', 'Company account registered successfully! Welcome to Direct Work Employer Portal.');
    }

    // =========================================================================
    // AFFILIATE / TYPING OFFICE AUTHENTICATION (/affiliate/login, /affiliate/register)
    // Matching User Uploaded Screenshots
    // =========================================================================

    public function affiliateLogin(Request $request)
    {
        if ($user = session('auth_user')) {
            if (in_array($user['role'] ?? '', ['office', 'affiliate_office', 'typing_office'])) {
                return redirect()->route('offices');
            }
            return redirect()->route('home');
        }

        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        return view('pages.auth.affiliate_login', compact('activeCountry'));
    }

    public function postAffiliateLogin(Request $request)
    {
        $validated = $request->validate([
            'email' => 'required|string',
            'password' => 'required|string',
        ]);

        $user = DatabaseService::authenticateUser($validated['email'], $validated['password'], 'office');

        if (!$user) {
            return back()->withErrors([
                'email' => 'Invalid office email address or password. Please verify and try again.',
            ])->withInput();
        }

        session(['auth_user' => $user]);

        return redirect()->route('offices')->with('success', 'Welcome back, ' . ($user['office_name'] ?? $user['full_name'] ?? 'Affiliate Office') . '!');
    }

    public function affiliateRegister(Request $request)
    {
        if (session('auth_user')) {
            return redirect()->route('offices');
        }

        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        return view('pages.auth.affiliate_register', compact('activeCountry'));
    }

    public function postAffiliateRegister(Request $request)
    {
        $validated = $request->validate([
            'office_name' => 'required|string|max:200',
            'contact_username' => 'required|string|max:150',
            'email' => 'required|email|max:150',
            'phone' => 'required|string|max:30',
            'governorate' => 'required|string|max:100',
            'address' => 'required|string|max:250',
            'password' => 'required|string|min:6',
            'agree_terms' => 'accepted',
        ], [
            'agree_terms.accepted' => 'You must agree to the Terms and Conditions for Typing Offices.',
        ]);

        if (DatabaseService::findUser($validated['email'])) {
            return back()->withErrors([
                'email' => 'An office account with this email is already registered.',
            ])->withInput();
        }

        $officeData = [
            'id' => 'kw_office_' . time() . '_' . rand(10, 99),
            'office_name' => $validated['office_name'],
            'full_name' => $validated['contact_username'],
            'contact_username' => $validated['contact_username'],
            'email' => strtolower(trim($validated['email'])),
            'phone' => trim($validated['phone']),
            'governorate' => $validated['governorate'],
            'address' => $validated['address'],
            'role' => 'office',
            'password' => $validated['password'],
            'password_hash' => password_hash($validated['password'], PASSWORD_BCRYPT),
            'terms_accepted' => true,
            'is_verified' => true,
            'created_at' => date('Y-m-d H:i:s'),
        ];

        DatabaseService::saveUser($officeData);

        session(['auth_user' => $officeData]);

        return redirect()->route('offices')->with('success', 'Affiliate Office account registered successfully!');
    }

    // =========================================================================
    // GENERAL ALIASES & LOGOUT
    // =========================================================================

    public function login()
    {
        return $this->employerLogin(request());
    }

    public function postLogin(Request $request)
    {
        return $this->postEmployerLogin($request);
    }

    public function register(Request $request)
    {
        return $this->employerRegister($request);
    }

    public function postRegister(Request $request)
    {
        return $this->postEmployerRegister($request);
    }

    public function logout()
    {
        session()->forget('auth_user');
        return redirect()->route('home')->with('success', 'You have been signed out successfully.');
    }
}
