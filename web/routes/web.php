<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\SectorController;
use App\Http\Controllers\ApplicantController;
use App\Http\Controllers\JobController;
use App\Http\Controllers\ApplyController;
use App\Http\Controllers\PricingController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ChatController;
use App\Http\Controllers\ApiController;
use App\Http\Controllers\SupportController;
use App\Http\Controllers\EmployerController;
use App\Http\Controllers\PrivacyController;

// Home & Market Context
Route::get('/', [HomeController::class, 'index'])->name('home');
Route::get('/country/{country}', [HomeController::class, 'setCountry'])->name('country.set');
Route::get('/locale/{locale}', [HomeController::class, 'setLocale'])->name('locale.set');

// Sectors
Route::get('/sectors', [SectorController::class, 'index'])->name('sectors.index');
Route::get('/sectors/{code}', [SectorController::class, 'show'])->name('sectors.show');

// Applicants / Candidates Pool
Route::get('/applicants', [ApplicantController::class, 'index'])->name('applicants.index');
Route::get('/applicants/{id}', [ApplicantController::class, 'show'])->name('applicants.show');

// Job Vacancies
Route::get('/jobs', [JobController::class, 'index'])->name('jobs.index');
Route::get('/jobs/create', [JobController::class, 'create'])->name('jobs.create');
Route::post('/jobs', [JobController::class, 'store'])->name('jobs.store');
Route::get('/jobs/{id}', [JobController::class, 'show'])->name('jobs.show');

// Apply / Post CV Ad Flow (3-step with Country Pricing)
Route::get('/apply', [ApplyController::class, 'index'])->name('apply.index');
Route::post('/apply', [ApplyController::class, 'store'])->name('apply.store');
Route::get('/apply/success/{id}', [ApplyController::class, 'success'])->name('apply.success');

// Pricing Plans
Route::get('/pricing', [PricingController::class, 'index'])->name('pricing.index');

// Authentication - Employer & Affiliate Offices
Route::get('/login', [AuthController::class, 'login'])->name('login');
Route::post('/login', [AuthController::class, 'postLogin'])->name('login.post');
Route::get('/register', [AuthController::class, 'register'])->name('register');
Route::post('/register', [AuthController::class, 'postRegister'])->name('register.post');
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');

// Employer Specific Authentication
Route::get('/employer/login', [AuthController::class, 'employerLogin'])->name('employer.login');
Route::post('/employer/login', [AuthController::class, 'postEmployerLogin'])->name('employer.login.post');
Route::get('/employer/register', [AuthController::class, 'employerRegister'])->name('employer.register');
Route::post('/employer/register', [AuthController::class, 'postEmployerRegister'])->name('employer.register.post');

// Affiliate / Typing Offices Authentication (Matching Screenshots)
Route::get('/affiliate/login', [AuthController::class, 'affiliateLogin'])->name('affiliate.login');
Route::post('/affiliate/login', [AuthController::class, 'postAffiliateLogin'])->name('affiliate.login.post');
Route::get('/affiliate/register', [AuthController::class, 'affiliateRegister'])->name('affiliate.register');
Route::post('/affiliate/register', [AuthController::class, 'postAffiliateRegister'])->name('affiliate.register.post');

// In-App Chat Interface
Route::get('/chats', [ChatController::class, 'index'])->name('chats.index');
Route::get('/chats/{id}', [ChatController::class, 'show'])->name('chats.show');
Route::post('/chats/{id}', [ChatController::class, 'send'])->name('chats.send');

// Help & Support Center
Route::get('/support', [SupportController::class, 'index'])->name('support');
Route::post('/support', [SupportController::class, 'sendTicket'])->name('support.send');

// Legal & Compliance: Privacy Policy (Android & iOS Google Play / App Store) & Terms
Route::get('/privacy-policy', [PrivacyController::class, 'index'])->name('privacy');
Route::get('/privacy', [PrivacyController::class, 'index'])->name('privacy.short');
Route::get('/terms', [PrivacyController::class, 'terms'])->name('terms');

// Employer & Offices Portals (Matching Screenshots)
Route::get('/portals', [EmployerController::class, 'portals'])->name('portals');
Route::get('/employer', [EmployerController::class, 'index'])->name('employer');
Route::get('/offices', [EmployerController::class, 'offices'])->name('offices');

// Employer Portal Suite (Matching Screenshots 1 to 8)
Route::prefix('employer')->name('employer.')->group(function () {
    Route::get('/dashboard', [EmployerController::class, 'dashboard'])->name('dashboard');
    Route::get('/browse', [EmployerController::class, 'browse'])->name('browse');
    Route::get('/browse/{sector}', [EmployerController::class, 'browseSector'])->name('browse.sector');
    Route::get('/browse/{sector}/{profession}', [EmployerController::class, 'browseProfession'])->name('browse.profession');
    Route::get('/profile', [EmployerController::class, 'profile'])->name('profile');
    Route::post('/profile', [EmployerController::class, 'updateProfile'])->name('profile.update');
    Route::get('/settings', [EmployerController::class, 'settings'])->name('settings');
    Route::post('/settings/password', [EmployerController::class, 'updatePassword'])->name('settings.password');
});

// Top-level Dashboard shortcut
Route::get('/dashboard', function () {
    return redirect()->route('employer.dashboard');
})->name('dashboard');

// Direct REST APIs (matching mobile app backend)
Route::prefix('api')->group(function () {
    Route::get('/jobs', [ApiController::class, 'getJobs']);
    Route::get('/sectors', [ApiController::class, 'getSectors']);
    Route::get('/applicants', [ApiController::class, 'getApplicants']);
    Route::post('/applications', [ApiController::class, 'submitApplication']);
    Route::get('/services', [ApiController::class, 'getServices']);
    Route::get('/commercial-ads', [ApiController::class, 'getCommercialAds']);
});
