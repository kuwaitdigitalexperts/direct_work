<?php

namespace App\Services;

class DatabaseService
{
    protected static ?string $dbPath = null;

    public static function getDatabasePath(): string
    {
        if (self::$dbPath !== null) {
            return self::$dbPath;
        }

        if (env('DIRECT_JOBS_DB_PATH') && file_exists(env('DIRECT_JOBS_DB_PATH'))) {
            self::$dbPath = env('DIRECT_JOBS_DB_PATH');
            return self::$dbPath;
        }

        // Primary shared backend location (local dev)
        $sharedPath = '/Users/uzair/kuwait_projects/deploy_directwork/storage/direct_jobs_database.json';
        if (file_exists($sharedPath)) {
            self::$dbPath = $sharedPath;
            return self::$dbPath;
        }

        // Fallback local Laravel storage (production / hosting)
        $localPath = storage_path('app/direct_jobs_database.json');
        if (!file_exists($localPath)) {
            if (!is_dir(dirname($localPath))) {
                mkdir(dirname($localPath), 0777, true);
            }
            file_put_contents($localPath, json_encode([
                'users' => [],
                'jobs' => [],
                'applications' => [],
                'applicants' => [],
                'services' => [],
                'commercial_ads' => [],
                'chats' => [],
                'messages' => [],
            ], JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
        }

        self::$dbPath = $localPath;
        return self::$dbPath;
    }

    public static function loadData(): array
    {
        $path = self::getDatabasePath();
        if (!file_exists($path)) {
            return [];
        }
        $raw = file_get_contents($path);
        return json_decode($raw, true) ?? [];
    }

    public static function saveData(array $data): bool
    {
        $path = self::getDatabasePath();
        $json = json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
        return file_put_contents($path, $json, LOCK_EX) !== false;
    }

    // --- Users ---
    public static function getUsers(): array
    {
        $data = self::loadData();
        return $data['users'] ?? [];
    }

    public static function getUser(string $id): ?array
    {
        foreach (self::getUsers() as $user) {
            if (($user['id'] ?? '') === $id) {
                return $user;
            }
        }
        return null;
    }

    public static function findUser(string $credential): ?array
    {
        $credential = strtolower(trim($credential));
        $cleanPhone = preg_replace('/[^0-9]/', '', $credential);

        foreach (self::getUsers() as $user) {
            $userEmail = strtolower(trim($user['email'] ?? ''));
            $userPhone = preg_replace('/[^0-9]/', '', $user['phone'] ?? '');
            $userLicense = strtolower(trim($user['commercial_license'] ?? ''));

            if ($userEmail === $credential || $userLicense === $credential || (!empty($cleanPhone) && !empty($userPhone) && (str_contains($userPhone, $cleanPhone) || str_contains($cleanPhone, $userPhone)))) {
                return $user;
            }
        }
        return null;
    }

    public static function authenticateUser(string $credential, string $password, ?string $requiredRole = null): ?array
    {
        $user = self::findUser($credential);
        if (!$user) {
            return null;
        }

        if ($requiredRole !== null) {
            $userRole = strtolower($user['role'] ?? 'applicant');
            if ($requiredRole === 'company' && $userRole !== 'company') {
                return null;
            }
            if ($requiredRole === 'office' && !in_array($userRole, ['office', 'affiliate_office', 'typing_office'])) {
                return null;
            }
        }

        $storedHash = $user['password_hash'] ?? null;
        $storedPlain = $user['password'] ?? null;

        $matches = false;
        if ($storedPlain !== null && $storedPlain === $password) {
            $matches = true;
        } elseif ($storedHash !== null && password_verify($password, $storedHash)) {
            $matches = true;
        }

        return $matches ? $user : null;
    }

    public static function saveUser(array $userData): array
    {
        $data = self::loadData();
        $users = $data['users'] ?? [];

        if (empty($userData['id'])) {
            $userData['id'] = 'user_' . time() . '_' . rand(100, 999);
        }

        $found = false;
        foreach ($users as $idx => $existing) {
            if (($existing['id'] ?? '') === $userData['id']) {
                $users[$idx] = array_merge($existing, $userData);
                $found = true;
                break;
            }
        }

        if (!$found) {
            $users[] = $userData;
        }

        $data['users'] = $users;
        self::saveData($data);
        return $userData;
    }

    // --- Jobs ---
    public static function getJobs(array $filters = []): array
    {
        $data = self::loadData();
        $jobs = $data['jobs'] ?? [];

        // Filter by country
        if (!empty($filters['country']) && $filters['country'] !== 'all') {
            $country = strtolower($filters['country']);
            $jobs = array_filter($jobs, function ($j) use ($country) {
                $jobCountry = strtolower($j['country'] ?? $j['country_code'] ?? 'kw');
                return $jobCountry === $country;
            });
        }

        // Filter by sector
        if (!empty($filters['sector']) && $filters['sector'] !== 'all') {
            $sector = $filters['sector'];
            $jobs = array_filter($jobs, function ($j) use ($sector) {
                return ($j['sector_code'] ?? '') === $sector || ($j['sector'] ?? '') === $sector;
            });
        }

        // Filter by governorate
        if (!empty($filters['governorate']) && $filters['governorate'] !== 'all') {
            $gov = $filters['governorate'];
            $jobs = array_filter($jobs, function ($j) use ($gov) {
                return ($j['governorate_id'] ?? '') === $gov || ($j['governorate'] ?? '') === $gov;
            });
        }

        // Filter by search query
        if (!empty($filters['search'])) {
            $q = strtolower(trim($filters['search']));
            $jobs = array_filter($jobs, function ($j) use ($q) {
                $title = strtolower($j['title'] ?? '');
                $company = strtolower($j['company_name'] ?? '');
                $desc = strtolower($j['description'] ?? '');
                return str_contains($title, $q) || str_contains($company, $q) || str_contains($desc, $q);
            });
        }

        // Pinned first, then newest
        usort($jobs, function ($a, $b) {
            $aPinned = !empty($a['is_pinned']) ? 1 : 0;
            $bPinned = !empty($b['is_pinned']) ? 1 : 0;
            if ($aPinned !== $bPinned) {
                return $bPinned <=> $aPinned;
            }
            return strtotime($b['created_at'] ?? 'now') <=> strtotime($a['created_at'] ?? 'now');
        });

        return array_values($jobs);
    }

    public static function getJob(string $id): ?array
    {
        foreach (self::getJobs() as $job) {
            if (($job['id'] ?? '') === $id) {
                return $job;
            }
        }
        return null;
    }

    public static function saveJob(array $jobData): array
    {
        $data = self::loadData();
        $jobs = $data['jobs'] ?? [];

        if (empty($jobData['id'])) {
            $jobData['id'] = 'job_' . time() . '_' . rand(100, 999);
        }
        if (empty($jobData['created_at'])) {
            $jobData['created_at'] = date('Y-m-d H:i:s');
        }

        $found = false;
        foreach ($jobs as $idx => $existing) {
            if (($existing['id'] ?? '') === $jobData['id']) {
                $jobs[$idx] = array_merge($existing, $jobData);
                $found = true;
                break;
            }
        }

        if (!$found) {
            array_unshift($jobs, $jobData);
        }

        $data['jobs'] = $jobs;
        self::saveData($data);
        return $jobData;
    }

    // --- Applicants / Candidates ---
    public static function getApplicants(array $filters = []): array
    {
        $data = self::loadData();
        $applicants = $data['applicants'] ?? [];

        // Also incorporate submitted applications into applicants list
        $applications = $data['applications'] ?? [];
        foreach ($applications as $app) {
            $applicants[] = [
                'id' => $app['id'] ?? ('app_' . rand(1000, 9999)),
                'name' => $app['name'] ?? $app['applicantName'] ?? 'مرشح معتمد',
                'profession' => $app['profession'] ?? $app['jobTitle'] ?? 'فني مهني',
                'sector' => $app['sector'] ?? $app['sectorCode'] ?? 'technical',
                'governorate' => $app['governorate'] ?? $app['governorateName'] ?? 'محافظة حولي',
                'nationality' => $app['nationality'] ?? 'كويتي',
                'experience' => ($app['experience_years'] ?? 3) . ' سنوات',
                'phone' => $app['phone'] ?? $app['applicantPhone'] ?? '+965 6670 7126',
                'whatsapp' => $app['whatsappNumber'] ?? $app['phone'] ?? '+965 6670 7126',
                'bio' => $app['bio'] ?? $app['note'] ?? 'مرشح يبحث عن عمل معتمد ولديه الخبرات والشهادات المطلوبة.',
                'cv_path' => $app['cv_path'] ?? $app['cvPath'] ?? null,
                'photo_url' => $app['photo_path'] ?? null,
                'location_type' => $app['location_type'] ?? 'inside',
                'is_verified' => true,
                'views' => rand(80, 450),
            ];
        }

        // Filter by sector
        if (!empty($filters['sector']) && $filters['sector'] !== 'all') {
            $sector = $filters['sector'];
            $applicants = array_filter($applicants, function ($a) use ($sector) {
                return ($a['sector'] ?? '') === $sector || ($a['sector_code'] ?? '') === $sector;
            });
        }

        // Filter by governorate / location
        if (!empty($filters['governorate']) && $filters['governorate'] !== 'all') {
            $gov = strtolower($filters['governorate']);
            $applicants = array_filter($applicants, function ($a) use ($gov) {
                return str_contains(strtolower($a['governorate'] ?? ''), $gov);
            });
        }

        // Filter by search
        if (!empty($filters['search'])) {
            $q = strtolower(trim($filters['search']));
            $applicants = array_filter($applicants, function ($a) use ($q) {
                $name = strtolower($a['name'] ?? '');
                $prof = strtolower($a['profession'] ?? '');
                $bio = strtolower($a['bio'] ?? '');
                return str_contains($name, $q) || str_contains($prof, $q) || str_contains($bio, $q);
            });
        }

        return array_values($applicants);
    }

    public static function getApplicant(string $id): ?array
    {
        foreach (self::getApplicants() as $applicant) {
            if (($applicant['id'] ?? '') === $id) {
                return $applicant;
            }
        }
        return null;
    }

    // --- Applications ---
    public static function getApplications(): array
    {
        $data = self::loadData();
        return $data['applications'] ?? [];
    }

    public static function saveApplication(array $appData): array
    {
        $data = self::loadData();
        $applications = $data['applications'] ?? [];

        if (empty($appData['id'])) {
            $appData['id'] = 'app_' . time() . '_' . rand(100, 999);
        }
        if (empty($appData['applied_at'])) {
            $appData['applied_at'] = date('Y-m-d H:i:s');
        }

        array_unshift($applications, $appData);
        $data['applications'] = $applications;

        // Also add to applicants pool so it appears immediately
        $applicants = $data['applicants'] ?? [];
        array_unshift($applicants, [
            'id' => $appData['id'],
            'name' => $appData['name'],
            'profession' => $appData['profession'],
            'sector' => $appData['sector'],
            'governorate' => $appData['governorate'] ?? 'محافظة حولي',
            'nationality' => $appData['nationality'] ?? 'كويتي',
            'experience' => ($appData['experience_years'] ?? 3) . ' سنوات',
            'phone' => $appData['phone'],
            'whatsapp' => $appData['phone'],
            'bio' => $appData['bio'] ?? '',
            'cv_path' => $appData['cv_path'] ?? null,
            'is_verified' => true,
            'location_type' => $appData['location_type'] ?? 'inside',
            'created_at' => date('Y-m-d H:i:s'),
            'views' => 1,
        ]);
        $data['applicants'] = $applicants;

        self::saveData($data);
        return $appData;
    }

    // --- Services ---
    public static function getServices(): array
    {
        $data = self::loadData();
        return $data['services'] ?? [];
    }

    // --- Commercial Ads ---
    public static function getCommercialAds(): array
    {
        $data = self::loadData();
        return $data['commercial_ads'] ?? [];
    }
}
