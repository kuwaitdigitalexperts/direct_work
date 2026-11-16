<?php

namespace Tests\Feature;

use Tests\TestCase;

class DirectWorkTest extends TestCase
{
    public function test_home_page_loads_successfully(): void
    {
        $response = $this->get('/');
        $response->assertStatus(200);
        $response->assertSee('Direct Work');
    }

    public function test_sectors_pages_load(): void
    {
        $response = $this->get('/sectors');
        $response->assertStatus(200);

        $showResponse = $this->get('/sectors/construction');
        $showResponse->assertStatus(200);
        $showResponse->assertSee('Construction Sector');
    }

    public function test_applicants_directory_and_detail(): void
    {
        $response = $this->get('/applicants');
        $response->assertStatus(200);

        $showResponse = $this->get('/applicants/app_kw_c1');
        $showResponse->assertStatus(200);
        $showResponse->assertSee('app_kw_c1');
    }

    public function test_jobs_directory_and_detail(): void
    {
        $response = $this->get('/jobs');
        $response->assertStatus(200);

        $showResponse = $this->get('/jobs/job_kw_101');
        $showResponse->assertStatus(200);
    }

    public function test_pricing_plans_per_country(): void
    {
        // Kuwait default: 2 KWD
        $resKw = $this->withSession(['selected_country' => 'kw'])->get('/pricing');
        $resKw->assertStatus(200);
        $resKw->assertSee('KWD');
        $resKw->assertSee('2');

        // Saudi Arabia: 35 SAR
        $resSa = $this->withSession(['selected_country' => 'sa'])->get('/pricing');
        $resSa->assertStatus(200);
        $resSa->assertSee('SAR');
        $resSa->assertSee('35');

        // UAE: 30 AED
        $resAe = $this->withSession(['selected_country' => 'ae'])->get('/pricing');
        $resAe->assertStatus(200);
        $resAe->assertSee('AED');
        $resAe->assertSee('30');
    }

    public function test_apply_and_auth_routes(): void
    {
        $resApply = $this->get('/apply');
        $resApply->assertStatus(200);

        $resLogin = $this->get('/login');
        $resLogin->assertStatus(200);

        $resRegister = $this->get('/register');
        $resRegister->assertStatus(200);

        $resChats = $this->get('/chats');
        $resChats->assertStatus(200);

        $resSupport = $this->get('/support');
        $resSupport->assertStatus(200);
        $resSupport->assertSee('Help & Support Center');

        $resPortals = $this->get('/portals');
        $resPortals->assertStatus(200);
        $resPortals->assertSee('Companies & Offices Portal');

        $resEmployer = $this->get('/employer');
        $resEmployer->assertStatus(200);
        $resEmployer->assertSee('Your Next Hire is');

        $resOffices = $this->get('/offices');
        $resOffices->assertStatus(200);
    }

    public function test_api_compatibility_endpoints(): void
    {
        $apiJobs = $this->getJson('/api/jobs');
        $apiJobs->assertStatus(200);
        $apiJobs->assertJsonStructure(['status', 'count', 'data']);

        $apiSectors = $this->getJson('/api/sectors');
        $apiSectors->assertStatus(200);
        $apiSectors->assertJsonStructure(['status', 'count', 'data']);

        $apiApplicants = $this->getJson('/api/applicants');
        $apiApplicants->assertStatus(200);
        $apiApplicants->assertJsonStructure(['status', 'count', 'data']);
    }

    public function test_mobile_mockups_use_royal_blue_theme(): void
    {
        $response = $this->get('/');
        $response->assertStatus(200);
        
        // Hero phone mockup features Direct Work royal blue elements
        $response->assertSee('Direct Work App');
        $response->assertSee('Direct Hiring Platform in Kuwait');
        $response->assertSee('Apply for jobs inside Kuwait');
        $response->assertSee('from-blue-600 to-blue-700');
        $response->assertSee('Add Ad');

        // Step 1 mockup features authentic job application form
        $response->assertSee('Formwork Carpenter');
        $response->assertSee('Attachments & Documents', false);
        $response->assertSee('Proceed to Payment (2 KWD)');

        // Step 2 mockup features authentic 27 sectors selection
        $response->assertSee('Select Sector');
        $response->assertSee('27 Sectors');
        $response->assertSee('Continue to Professions');
    }

    public function test_employer_and_affiliate_office_auth(): void
    {
        // 1. Employer Login & Register Pages
        $resEmpLogin = $this->get('/employer/login');
        $resEmpLogin->assertStatus(200);
        $resEmpLogin->assertSee('Employer Portal Login');

        $resEmpRegister = $this->get('/employer/register');
        $resEmpRegister->assertStatus(200);
        $resEmpRegister->assertSee('Register Employer Account');

        // 2. Register Company Account
        $companyEmail = 'testcompany_' . time() . '_' . rand(100, 999) . '@directjobs.kw';
        $companyPhone = '+965 ' . rand(50000000, 99999999);
        $resPostEmp = $this->post('/employer/register', [
            'company_name' => 'Gulf Trading & Contracting',
            'full_name' => 'Fahad Al-Salem',
            'email' => $companyEmail,
            'phone' => $companyPhone,
            'commercial_license' => 'KW-884920',
            'governorate' => 'محافظة العاصمة',
            'password' => 'secret1234',
        ]);
        $resPostEmp->assertRedirect(route('employer'));
        $this->assertEquals($companyEmail, session('auth_user')['email']);
        $this->assertEquals('company', session('auth_user')['role']);

        // Clear session and test Employer Login
        $this->flushSession();
        $this->assertNull(session('auth_user'));

        $resEmpLoginPost = $this->post('/employer/login', [
            'credential' => $companyEmail,
            'password' => 'secret1234',
        ]);
        $resEmpLoginPost->assertRedirect(route('employer'));
        $this->assertEquals('company', session('auth_user')['role']);

        // 3. Affiliate Office Login & Register Pages (Matching Screenshots)
        $this->flushSession();
        $resAffLogin = $this->get('/affiliate/login');
        $resAffLogin->assertStatus(200);
        $resAffLogin->assertSee('Affiliate Office Login');
        $resAffLogin->assertSee('Sign in to register and manage job seeker CVs');

        $resAffRegister = $this->get('/affiliate/register');
        $resAffRegister->assertStatus(200);
        $resAffRegister->assertSee('Register Affiliate Office');
        $resAffRegister->assertSee('Terms and Conditions for Typing Offices');

        // 4. Register Affiliate Office Account
        $officeEmail = 'testoffice_' . time() . '_' . rand(100, 999) . '@directjobs.kw';
        $officePhone = '+965 ' . rand(20000000, 29999999);
        $resPostAff = $this->post('/affiliate/register', [
            'office_name' => 'Al-Amal Typing & Translation Center',
            'contact_username' => 'Khaled Mansoor',
            'email' => $officeEmail,
            'phone' => $officePhone,
            'governorate' => 'محافظة حولي',
            'address' => 'Tunis St, Hawalli Mall, Floor 2',
            'password' => 'officepass123',
            'agree_terms' => '1',
        ]);
        $resPostAff->assertRedirect(route('offices'));
        $this->assertEquals($officeEmail, session('auth_user')['email']);
        $this->assertEquals('office', session('auth_user')['role']);

        // Clear session and test Office Login
        $this->flushSession();
        $resAffLoginPost = $this->post('/affiliate/login', [
            'email' => $officeEmail,
            'password' => 'officepass123',
        ]);
        $resAffLoginPost->assertRedirect(route('offices'));
        $this->assertEquals('office', session('auth_user')['role']);
    }

    public function test_employer_portal_dashboard_suite(): void
    {
        // 1. Employer Dashboard (Screenshots 1, 2, 3)
        $resDash = $this->get('/employer/dashboard');
        $resDash->assertStatus(200);
        $resDash->assertSee('Employer Dashboard');
        $resDash->assertSee('ACTIVE SECTORS');
        $resDash->assertSee('Recruitment Cases by Location & Shift', false);
        $resDash->assertSee('GCC Citizens Applications');

        // 2. Browse Sectors (Screenshot 4)
        $resBrowse = $this->get('/employer/browse');
        $resBrowse->assertStatus(200);
        $resBrowse->assertSee('Browse Applicants by Sector');
        $resBrowse->assertSee('Kuwait Talent Explorer');
        $resBrowse->assertSee('Explore by Sector');

        // 3. Sector Professions (Screenshot 5)
        $resSector = $this->get('/employer/browse/construction');
        $resSector->assertStatus(200);
        $resSector->assertSee('Professions');
        $resSector->assertSee('All Sub-Sectors');

        // 4. Profession Candidates Pool (Screenshot 6)
        $resCandidates = $this->get('/employer/browse/construction/cs_1');
        $resCandidates->assertStatus(200);
        $resCandidates->assertSee('Applicants');
        $resCandidates->assertSee('Inside Kuwait');
        $resCandidates->assertSee('Phone Number');
        $resCandidates->assertSee('WhatsApp');
        $resCandidates->assertSee('Chat');

        // 5. Company Profile (Screenshot 7)
        $resProfile = $this->get('/employer/profile');
        $resProfile->assertStatus(200);
        $resProfile->assertSee('Company Profile');
        $resProfile->assertSee('COMPANY REGISTERED NAME');

        // 6. Account Settings (Screenshot 8)
        $resSettings = $this->get('/employer/settings');
        $resSettings->assertStatus(200);
        $resSettings->assertSee('Account Settings');
        $resSettings->assertSee('Change Password');
        $resSettings->assertSee('Danger Zone');
    }
}
