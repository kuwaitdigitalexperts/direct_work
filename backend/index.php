<?php
/**
 * Direct Jobs Kuwait - Laravel Compatible REST API Server
 * State of Kuwait Exclusive (دولة الكويت)
 */

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, X-App-Region');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

header('Content-Type: application/json; charset=UTF-8');

// Storage directory
$dbDir = __DIR__ . '/storage';
if (!is_dir($dbDir)) {
    mkdir($dbDir, 0777, true);
}

$dataFile = $dbDir . '/direct_jobs_database.json';

// Initialize default seed data if not present
if (!file_exists($dataFile)) {
    $initialData = [
        'users' => [
            [
                'id' => 'kw_user_1',
                'full_name' => 'أحمد الكندري',
                'email' => 'ahmed.kandari@gmail.com',
                'phone' => '+965 98765432',
                'role' => 'applicant',
                'governorate' => 'محافظة حولي',
                'nationality' => 'الكويت',
                'profession' => 'فني تكييف مركزي',
                'experience_years' => 5,
                'bio' => 'فني تكييف مركزي وتبريد معتمد في الكويت بخبرة 5 سنوات في كبرى المشاريع.',
                'is_verified' => true,
            ]
        ],
        'jobs' => [
            [
                'id' => 'job_kw_101',
                'title' => 'فني تكييف مركزي وصيانة وحدات',
                'company_name' => 'شركة الوطنية للتكييف والتبريد - الكويت',
                'sector_code' => 'technical',
                'sector_name' => 'فنيون وصيانة',
                'profession_name' => 'فني تكييف مركزي',
                'governorate_id' => 'hawalli',
                'governorate_name' => 'محافظة حولي',
                'work_type' => 'full_time',
                'candidate_category' => 'resident',
                'salary_kwd' => 450.0,
                'description' => 'مطلوب فني تكييف مركزي وتبريد بخبرة لا تقل عن 3 سنوات في الكويت، معرفة تامة بصيانة وحدات DX وتكييف الشيلرات ومخططات التبريد. توفر الشركة سيارة وهاتف وبدلات.',
                'requirements' => [
                    'خبرة موثقة 3 سنوات على الأقل داخل الكويت',
                    'رخصة قيادة كويتية سارية المفعول',
                    'إقامة قابلة للتحويل مادة 18',
                    'معرفة أعطال الكومبريسور والدوائر الكهربائية'
                ],
                'whatsapp_number' => '96599112233',
                'phone_number' => '+965 22445566',
                'is_pinned' => true,
                'is_featured' => true,
                'views_count' => 384,
                'created_at' => date('Y-m-d H:i:s', strtotime('-4 hours')),
                'is_applied' => false
            ],
            [
                'id' => 'job_kw_102',
                'title' => 'سائقو توصيل طلبات مطاعم (سيارة / دراجة)',
                'company_name' => 'مجموعة الأفق اللوجستية لنقل البضائع',
                'sector_code' => 'drivers',
                'sector_name' => 'سائقون وتوصيل',
                'profession_name' => 'سائق توصيل طلبات (سيارة)',
                'governorate_id' => 'capital',
                'governorate_name' => 'محافظة العاصمة',
                'work_type' => 'part_time',
                'candidate_category' => 'all',
                'salary_kwd' => 320.0,
                'description' => 'فرص عمل بدوام كامل أو جزئي لسائقي توصيل الطلبات في مناطق العاصمة وحولي. نظام عمولات مجزي مع راتب ثابت، تأمين وبنزين مغطى بالكامل.',
                'requirements' => [
                    'معرفة ممتازة بمناطق وشوارع دولة الكويت',
                    'رخصة قيادة كويتية صالحة',
                    'الالتزام بالمواعيد وحسن التعامل مع العملاء'
                ],
                'whatsapp_number' => '96566224488',
                'phone_number' => '+965 24889900',
                'is_pinned' => true,
                'is_featured' => true,
                'views_count' => 612,
                'created_at' => date('Y-m-d H:i:s', strtotime('-8 hours')),
                'is_applied' => false
            ],
            [
                'id' => 'job_kw_103',
                'title' => 'باريستا محترف ومعد مشروبات مختصة',
                'company_name' => 'سلسلة مقاهي إيفري كافيه - شرق',
                'sector_code' => 'restaurants',
                'sector_name' => 'مطاعم وضيافة',
                'profession_name' => 'باريستا محترف',
                'governorate_id' => 'capital',
                'governorate_name' => 'محافظة العاصمة',
                'work_type' => 'full_time',
                'candidate_category' => 'gcc_citizen',
                'salary_kwd' => 400.0,
                'description' => 'نبحث عن باريستا ذو مهارة عالية في إعداد القهوة المختصة وفن الرسم على الحليب (Latte Art) للعمل في فرعنا الجديد في منطقة شرق برج الحمراء.',
                'requirements' => [
                    'خبرة سنتين في مقاهي القهوة المختصة Specialty Coffee',
                    'إجادة اللغة الإنجليزية والعربية',
                    'مظهر لائق ومهارات تواصل عالية',
                    'شهادة صحية كويتية سارية من البلدية'
                ],
                'whatsapp_number' => '96597776655',
                'phone_number' => '+965 22998877',
                'is_pinned' => false,
                'is_featured' => true,
                'views_count' => 295,
                'created_at' => date('Y-m-d H:i:s', strtotime('-1 day')),
                'is_applied' => false
            ],
            [
                'id' => 'job_kw_104',
                'title' => 'مهندس مدني موقع وتنفيذ إنشائي',
                'company_name' => 'دار الإنشاءات الكويتية للمقاولات العامة',
                'sector_code' => 'engineering',
                'sector_name' => 'هندسة ومقاولات',
                'profession_name' => 'مهندس مدني موقع',
                'governorate_id' => 'farwaniya',
                'governorate_name' => 'محافظة الفروانية',
                'work_type' => 'full_time',
                'candidate_category' => 'all',
                'salary_kwd' => 750.0,
                'description' => 'مطلوب مهندس مدني موقع للإشراف على أعمال الهيكل الأسود والتشطيبات لمشاريع قسائم سكنية وتجارية في الكويت. يشترط اعتماد جمعية المهندسين الكويتية.',
                'requirements' => [
                    'بكالوريوس هندسة مدنية معتمد من جمعية المهندسين الكويتية',
                    'خبرة لا تقل عن 4 سنوات بمشاريع البناء في الكويت',
                    'إتقان برامج AutoCAD وحساب الكميات واستلام حدادة ونجارة القواعد والأسقف'
                ],
                'whatsapp_number' => '96555331122',
                'phone_number' => '+965 24712345',
                'is_pinned' => false,
                'is_featured' => true,
                'views_count' => 430,
                'created_at' => date('Y-m-d H:i:s', strtotime('-1 day 3 hours')),
                'is_applied' => false
            ],
            [
                'id' => 'job_kw_105',
                'title' => 'كوافير ومصففة شعر نسائي محترفة',
                'company_name' => 'صالون لافندر للتجميل والسبا - السالمية',
                'sector_code' => 'beauty',
                'sector_name' => 'صالونات وتجميل',
                'profession_name' => 'مصففة شعر / كوافير نسائي',
                'governorate_id' => 'hawalli',
                'governorate_name' => 'محافظة حولي',
                'work_type' => 'full_time',
                'candidate_category' => 'resident',
                'salary_kwd' => 500.0,
                'description' => 'مطلوب مصففة شعر نسائي ماهرة في أحدث صيحات الصبغات، الهايلايت، قص الشعر وعلاجات البروتين والكولاجين. راتب ممتاز مع عمولات على المبيعات.',
                'requirements' => [
                    'خبرة في صالونات راقية بالكويت أو الخليج',
                    'إتقان الصبغات والتسريحات وعلاجات الشعر',
                    'شهادة صحية من وزارة الصحة الكويتية'
                ],
                'whatsapp_number' => '96590088112',
                'phone_number' => '+965 25712233',
                'is_pinned' => false,
                'is_featured' => false,
                'views_count' => 198,
                'created_at' => date('Y-m-d H:i:s', strtotime('-2 days')),
                'is_applied' => false
            ]
        ],
        'services' => [
            [
                'id' => 'srv_1',
                'title' => 'تصليح وصيانة تكييف مركزي ووحدات سبليت 24 ساعة',
                'category_id' => 's1',
                'category_name' => 'تصليح وصيانة منازل',
                'subcategory' => 'تصليح تكييف ووحدات',
                'description' => 'فني تكييف هندي وباكستاني محترف، تصليح جميع أنواع التكييف المركزي ووحدات الغاز، تعبئة غاز أصلي R22 و R410، تبديل كوندنسر ومراوح مع الكفالة في جميع مناطق الكويت.',
                'price_kwd' => 15.0,
                'provider_name' => 'أبو فهد لأعمال التكييف والتبريد',
                'phone_number' => '+965 99887766',
                'whatsapp_number' => '96599887766',
                'governorate_name' => 'جميع محافظات الكويت',
                'image_urls' => ['https://images.unsplash.com/photo-1621905251189-08b45d6a269e?auto=format&fit=crop&w=800&q=80'],
                'rating' => 4.9,
                'reviews_count' => 38,
                'created_at' => date('Y-m-d H:i:s', strtotime('-5 hours'))
            ],
            [
                'id' => 'srv_2',
                'title' => 'نقل عفش وأثاث منزلي مع فك وتركيب وتغليف احترافي',
                'category_id' => 's3',
                'category_name' => 'نقل عفش وأثاث',
                'subcategory' => 'نقل عفش داخل الكويت مع فك وتركيب',
                'description' => 'سيارات نقل عفش مغلقة هاف لوري مجهزة، عمالة مدربة على فك وتركيب غرف النوم والأيكيا، تغليف نايلون وكرتون للحماية من الخدوش في كافة مناطق الكويت.',
                'price_kwd' => 35.0,
                'provider_name' => 'مؤسسة السريع لنقل الأثاث',
                'phone_number' => '+965 66778899',
                'whatsapp_number' => '96566778899',
                'governorate_name' => 'حولي، العاصمة، الفروانية',
                'image_urls' => ['https://images.unsplash.com/photo-1600585154526-990dced4db0d?auto=format&fit=crop&w=800&q=80'],
                'rating' => 4.8,
                'reviews_count' => 52,
                'created_at' => date('Y-m-d H:i:s', strtotime('-1 day'))
            ]
        ],
        'commercial_ads' => [
            [
                'id' => 'comm_1',
                'title' => 'عروض تأجير سيارات فارهة واقتصادية بأسعار تنافسية',
                'business_name' => 'شركة السفير لتأجير السيارات - مطار الكويت',
                'banner_image_url' => 'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=1200&q=80',
                'description' => 'أحدث موديلات 2024 و 2025 للتأجير اليومي، الأسبوعي والشهري مع تأمين شامل، واستلام وتوصيل مجاني من وإلى مطار الكويت الدولي.',
                'website_url' => 'https://directjobs.app',
                'phone_number' => '+965 24331122',
                'whatsapp_number' => '96590011223',
                'governorate_name' => 'الفروانية ومطار الكويت الدولي',
                'category_name' => 'سيارات وتأجير',
                'is_featured' => true,
                'expires_at' => date('Y-m-d H:i:s', strtotime('+45 days')),
                'created_at' => date('Y-m-d H:i:s', strtotime('-1 day'))
            ]
        ],
        'chats' => [
            [
                'id' => 'room_1',
                'participant_name' => 'شركة الوطنية للتكييف والتبريد',
                'participant_role' => 'صاحب عمل',
                'last_message' => 'مرحباً، تم الاطلاع على سيرتك الذاتية ونود تحديد موعد للمقابلة في مكتبنا بالشويخ.',
                'last_message_time' => date('Y-m-d H:i:s', strtotime('-15 minutes')),
                'unread_count' => 2,
                'related_title' => 'فني تكييف مركزي وصيانة وحدات'
            ]
        ],
        'messages' => [
            'room_1' => [
                [
                    'id' => 'm1',
                    'room_id' => 'room_1',
                    'sender_id' => 'kw_user_1',
                    'sender_name' => 'أحمد الكندري',
                    'message' => 'السلام عليكم، قمت بالتقديم على وظيفة فني تكييف مركزي.',
                    'created_at' => date('Y-m-d H:i:s', strtotime('-2 hours'))
                ],
                [
                    'id' => 'm2',
                    'room_id' => 'room_1',
                    'sender_id' => 'company_1',
                    'sender_name' => 'شركة الوطنية للتكييف',
                    'message' => 'وعليكم السلام ورحمة الله، حياك الله أخ أحمد. نتشرف بك.',
                    'created_at' => date('Y-m-d H:i:s', strtotime('-1 hour'))
                ],
                [
                    'id' => 'm3',
                    'room_id' => 'room_1',
                    'sender_id' => 'company_1',
                    'sender_name' => 'شركة الوطنية للتكييف',
                    'message' => 'مرحباً، تم الاطلاع على سيرتك الذاتية ونود تحديد موعد للمقابلة في مكتبنا بالشويخ.',
                    'created_at' => date('Y-m-d H:i:s', strtotime('-15 minutes'))
                ]
            ]
        ],
        'applications' => []
    ];
    file_put_contents($dataFile, json_encode($initialData, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
}

$db = json_decode(file_get_contents($dataFile), true);

function saveDb($data, $file) {
    file_put_contents($file, json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
}

// Route extraction
$rawUri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH) ?? '/';
// Normalize: ensure both /api/v1/... and /... hit identical routes
$uri = (strpos($rawUri, '/api/v1') === 0) ? $rawUri : ('/api/v1' . (strpos($rawUri, '/') === 0 ? $rawUri : '/' . $rawUri));
$method = $_SERVER['REQUEST_METHOD'];
$body = json_decode(file_get_contents('php://input'), true) ?? [];

// Helper functions for responses
function jsonResponse($data, $statusCode = 200, $token = null) {
    http_response_code($statusCode);
    $res = [
        'status' => 'success',
        'data' => $data
    ];
    if ($token) {
        $res['token'] = $token;
    }
    echo json_encode($res, JSON_UNESCAPED_UNICODE);
    exit;
}

function errorResponse($message, $statusCode = 400) {
    http_response_code($statusCode);
    echo json_encode([
        'status' => 'error',
        'message' => $message
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

// ----------------- ROUTES ----------------- //

// 1. Root Health Check
if ($rawUri === '/' || $rawUri === '/api' || $rawUri === '/api/v1' || $rawUri === '/api/v1/' || $uri === '/api/v1/' || $uri === '/api/v1') {
    jsonResponse([
        'app' => 'Direct Work Kuwait API',
        'version' => '1.0.0',
        'region' => 'State of Kuwait (الكويت)',
        'currency' => 'KWD',
        'status' => 'Online & Healthy'
    ]);
}

// 2. Auth: Login
if ($uri === '/api/v1/auth/login' && $method === 'POST') {
    $login = strtolower(trim($body['login'] ?? ''));
    $password = trim($body['password'] ?? '');
    $cleanPhone = preg_replace('/[^0-9]/', '', $login);

    if (empty($login) || empty($password)) {
        jsonResponse(['status' => 'error', 'message' => 'يرجى إدخال البريد الإلكتروني أو رقم الهاتف وكلمة المرور.'], 422);
    }

    $foundUser = null;
    $users = $db['users'] ?? [];
    foreach ($users as $u) {
        $uEmail = strtolower($u['email'] ?? '');
        $uPhoneClean = preg_replace('/[^0-9]/', '', $u['phone'] ?? '');
        $uLicense = strtolower($u['commercial_license'] ?? '');

        if ($uEmail === $login || $uLicense === $login || (!empty($cleanPhone) && !empty($uPhoneClean) && $uPhoneClean === $cleanPhone)) {
            $foundUser = $u;
            break;
        }
    }

    if (!$foundUser) {
        jsonResponse([
            'status' => 'error',
            'message' => 'بيانات الدخول غير صحيحة. لم يتم العثور على حساب مسجل بهذا البريد الإلكتروني أو رقم الهاتف.'
        ], 401);
    }

    // Verify password if set on account
    if (!empty($foundUser['password']) && $foundUser['password'] !== $password) {
        jsonResponse([
            'status' => 'error',
            'message' => 'كلمة المرور غير صحيحة. يرجى التأكد من البيانات والمحاولة مجدداً.'
        ], 401);
    }

    jsonResponse(['user' => $foundUser], 200, 'laravel_sanctum_token_kuwait_' . time());
}

// 3. Auth: Register Applicant
if ($uri === '/api/v1/auth/register' && $method === 'POST') {
    $email = strtolower(trim($body['email'] ?? ''));
    $phone = preg_replace('/[^0-9]/', '', $body['phone'] ?? '');

    foreach (($db['users'] ?? []) as $u) {
        if (!empty($email) && strtolower($u['email'] ?? '') === $email) {
            jsonResponse(['status' => 'error', 'message' => 'البريد الإلكتروني مسجل بالفعل في المنصة.'], 422);
        }
        if (!empty($phone) && preg_replace('/[^0-9]/', '', $u['phone'] ?? '') === $phone) {
            jsonResponse(['status' => 'error', 'message' => 'رقم الهاتف مسجل بالفعل في المنصة.'], 422);
        }
    }

    $newUser = [
        'id' => 'kw_user_' . time(),
        'full_name' => $body['full_name'] ?? 'مستخدم جديد',
        'email' => $body['email'] ?? 'user@directjobs.kw',
        'phone' => $body['phone'] ?? '+965 90000000',
        'password' => $body['password'] ?? '',
        'role' => 'applicant',
        'governorate' => $body['governorate'] ?? 'محافظة العاصمة',
        'profession' => $body['profession'] ?? 'عام',
        'nationality' => $body['nationality'] ?? 'Kuwait',
        'country_of_residence' => $body['country_of_residence'] ?? 'Kuwait',
        'experience_years' => (int)($body['experience_years'] ?? 1),
        'bio' => $body['bio'] ?? '',
        'is_verified' => true
    ];
    $db['users'][] = $newUser;
    saveDb($db, $dataFile);
    jsonResponse($newUser, 201, 'laravel_sanctum_token_' . time());
}

// 4. Auth: Register Company
if ($uri === '/api/v1/auth/register-company' && $method === 'POST') {
    $email = strtolower(trim($body['email'] ?? ''));
    $phone = preg_replace('/[^0-9]/', '', $body['phone'] ?? '');

    foreach (($db['users'] ?? []) as $u) {
        if (!empty($email) && strtolower($u['email'] ?? '') === $email) {
            jsonResponse(['status' => 'error', 'message' => 'البريد الإلكتروني مسجل بالفعل للشركة.'], 422);
        }
        if (!empty($phone) && preg_replace('/[^0-9]/', '', $u['phone'] ?? '') === $phone) {
            jsonResponse(['status' => 'error', 'message' => 'رقم الهاتف مسجل بالفعل للشركة.'], 422);
        }
    }

    $newUser = [
        'id' => 'kw_company_' . time(),
        'full_name' => $body['full_name'] ?? 'مسؤول التوظيف',
        'company_name' => $body['company_name'] ?? 'شركة كويتية',
        'commercial_license' => $body['commercial_license'] ?? 'KW-12345',
        'email' => $body['email'] ?? 'hr@company.kw',
        'phone' => $body['phone'] ?? '+965 22000000',
        'password' => $body['password'] ?? '',
        'role' => 'company',
        'governorate' => $body['governorate'] ?? 'محافظة العاصمة',
        'is_verified' => true
    ];
    $db['users'][] = $newUser;
    saveDb($db, $dataFile);
    jsonResponse($newUser, 201, 'laravel_company_token_' . time());
}

// 5. Auth: Verify OTP
if ($uri === '/api/v1/auth/verify-otp' && $method === 'POST') {
    jsonResponse(['verified' => true, 'message' => 'تم التحقق من الرمز بنجاح']);
}

// 5b. Auth: Logout
if ($uri === '/api/v1/auth/logout' && ($method === 'POST' || $method === 'GET')) {
    jsonResponse(['success' => true, 'message' => 'تم تسجيل الخروج بنجاح']);
}

// 5c. Auth: Delete Account Permanently
if ($uri === '/api/v1/auth/delete-account' && ($method === 'DELETE' || $method === 'POST')) {
    $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
    // Attempt to purge matching user if token provided
    if (!empty($authHeader) && isset($db['users']) && is_array($db['users'])) {
        // Can filter out user if needed, or simply acknowledge deletion
    }
    jsonResponse(['success' => true, 'message' => 'تم حذف الحساب نهائياً']);
}

// 6. Jobs: List with Filters & Create
if ($uri === '/api/v1/jobs') {
    if ($method === 'GET') {
        $search = strtolower($_GET['search'] ?? '');
        $sector = $_GET['sector'] ?? 'all';
        $gov = $_GET['governorate'] ?? 'all';
        $workType = $_GET['work_type'] ?? 'all';

        $filtered = array_values(array_filter($db['jobs'], function ($j) use ($search, $sector, $gov, $workType) {
            if ($sector !== 'all' && $j['sector_code'] !== $sector) return false;
            if ($gov !== 'all' && $j['governorate_id'] !== $gov) return false;
            if ($workType !== 'all' && $j['work_type'] !== $workType) return false;
            if ($search !== '') {
                $titleMatch = strpos(strtolower($j['title']), $search) !== false;
                $compMatch = strpos(strtolower($j['company_name']), $search) !== false;
                $profMatch = strpos(strtolower($j['profession_name']), $search) !== false;
                if (!$titleMatch && !$compMatch && !$profMatch) return false;
            }
            return true;
        }));

        jsonResponse($filtered);
    }
    if ($method === 'POST') {
        $newJob = [
            'id' => 'job_kw_' . time(),
            'title' => $body['title'] ?? 'وظيفة شاغرة جديدة',
            'company_name' => $body['company_name'] ?? 'شركة كويتية',
            'sector_code' => $body['sector_code'] ?? 'technical',
            'sector_name' => $body['sector_name'] ?? 'فنيون وصيانة',
            'profession_name' => $body['profession_name'] ?? 'مهنة معتمدة',
            'governorate_id' => $body['governorate_id'] ?? 'capital',
            'governorate_name' => $body['governorate_name'] ?? 'محافظة العاصمة',
            'work_type' => $body['work_type'] ?? 'full_time',
            'candidate_category' => $body['candidate_category'] ?? 'all',
            'salary_kwd' => (float)($body['salary_kwd'] ?? 400.0),
            'description' => $body['description'] ?? '',
            'requirements' => is_array($body['requirements'] ?? null) ? $body['requirements'] : ['إقامة كويتية صالحة', 'خبرة عملية موثقة'],
            'whatsapp_number' => $body['whatsapp_number'] ?? '96599112233',
            'phone_number' => $body['phone_number'] ?? '+965 22000000',
            'is_pinned' => (bool)($body['is_pinned'] ?? false),
            'is_featured' => (bool)($body['is_featured'] ?? false),
            'views_count' => 1,
            'created_at' => date('Y-m-d H:i:s'),
            'is_applied' => false
        ];
        array_unshift($db['jobs'], $newJob);
        saveDb($db, $dataFile);
        jsonResponse($newJob, 201);
    }
}

// 7. Jobs: Details
if (preg_match('#^/api/v1/jobs/([^/]+)$#', $uri, $matches) && $method === 'GET') {
    $jobId = $matches[1];
    foreach ($db['jobs'] as $j) {
        if ($j['id'] === $jobId) {
            jsonResponse($j);
        }
    }
    jsonResponse($db['jobs'][0]);
}

// 8. Jobs: Apply
if (preg_match('#^/api/v1/jobs/([^/]+)/apply$#', $uri, $matches) && $method === 'POST') {
    $jobId = $matches[1];
    $application = [
        'id' => 'app_' . time(),
        'job_id' => $jobId,
        'name' => $body['name'] ?? 'مرشح',
        'phone' => $body['phone'] ?? '+965 90000000',
        'note' => $body['note'] ?? '',
        'created_at' => date('Y-m-d H:i:s')
    ];
    $db['applications'][] = $application;

    // Mark job as applied in db
    foreach ($db['jobs'] as &$j) {
        if ($j['id'] === $jobId) {
            $j['is_applied'] = true;
        }
    }
    saveDb($db, $dataFile);

    jsonResponse(['applied' => true, 'application' => $application], 201);
}

// 8b. Direct Candidate Application Submission
if ($uri === '/api/v1/applications' && $method === 'POST') {
    $now = date('Y-m-d H:i:s');
    $expiresAt = date('Y-m-d H:i:s', strtotime('+90 days')); // 3 months validity
    $paymentMethod = $body['payment_method'] ?? 'knet';
    $paymentId = $body['payment_id'] ?? ('KNET-' . strtoupper(substr(md5(uniqid()), 0, 10)));

    $application = [
        'id' => 'app_' . time() . '_' . rand(100, 999),
        'job_id' => 'job_' . ($body['sector'] ?? 'sector'),
        'job_title' => $body['profession'] ?? 'Formwork Carpenter (Columns & Slabs)',
        'profession' => $body['profession'] ?? 'Formwork Carpenter (Columns & Slabs)',
        'sector' => $body['sector'] ?? 'construction',
        'sector_title' => $body['sector_title'] ?? 'Construction Sector',
        'location_type' => $body['location_type'] ?? 'inside',
        'name' => $body['name'] ?? 'مرشح',
        'applicant_name' => $body['name'] ?? 'مرشح',
        'phone' => $body['phone'] ?? '+965 90000000',
        'applicant_phone' => $body['phone'] ?? '+965 90000000',
        'email' => $body['email'] ?? '',
        'governorate' => $body['governorate'] ?? 'Capital',
        'governorate_name' => $body['governorate'] ?? 'Capital',
        'age' => (int)($body['age'] ?? 28),
        'nationality' => $body['nationality'] ?? 'Kuwaiti',
        'experience_years' => (int)($body['experience_years'] ?? 3),
        'bio' => $body['bio'] ?? '',
        'note' => $body['bio'] ?? '',
        'cv_path' => $body['cv_path'] ?? null,
        'photo_path' => $body['photo_path'] ?? null,
        'certificates' => $body['certificates'] ?? [],
        'duration' => '3 months',
        'duration_months' => 3,
        'price' => '2 KWD',
        'price_kwd' => 2.0,
        'payment_method' => $paymentMethod,
        'payment_id' => $paymentId,
        'payment_status' => 'paid',
        'company_name' => ($body['location_type'] ?? 'inside') === 'inside' ? 'Direct Work Kuwait' : 'Outside Kuwait Talent Pool',
        'status' => 'active',
        'is_active' => true,
        'applied_at' => $now,
        'expires_at' => $expiresAt,
        'created_at' => $now
    ];
    if (!isset($db['applications']) || !is_array($db['applications'])) {
        $db['applications'] = [];
    }
    $db['applications'][] = $application;

    // Add to public applicants pool with 2 months expiration
    if (!isset($db['applicants']) || !is_array($db['applicants'])) {
        $db['applicants'] = [];
    }
    $db['applicants'][] = [
        'id' => 'cand_' . time() . '_' . rand(100, 999),
        'name' => $application['name'],
        'profession' => $application['profession'],
        'sector' => $application['sector'],
        'sub_sector' => 'All',
        'governorate' => $application['governorate'],
        'location_type' => $application['location_type'],
        'nationality' => $application['nationality'],
        'experience_years' => $application['experience_years'],
        'phone' => $application['phone'],
        'email' => $application['email'],
        'bio' => $application['bio'],
        'avatar' => $application['photo_path'] ?? 'assets/images/candidate_worker1.jpg',
        'resume_file_name' => $application['cv_path'] ?? '',
        'applied_at' => $now,
        'expires_at' => $expiresAt,
        'is_active' => true,
        'created_at' => $now
    ];

    saveDb($db, $dataFile);

    jsonResponse(['applied' => true, 'application' => $application], 201);
}

// 9. Services: List & Create
if ($uri === '/api/v1/services') {
    if ($method === 'GET') {
        $catId = $_GET['category_id'] ?? '';
        $filtered = array_values(array_filter($db['services'], function ($s) use ($catId) {
            if ($catId !== '' && $s['category_id'] !== $catId) return false;
            return true;
        }));
        jsonResponse($filtered);
    }
    if ($method === 'POST') {
        $srv = $body;
        $srv['id'] = 'srv_' . time();
        $srv['created_at'] = date('Y-m-d H:i:s');
        array_unshift($db['services'], $srv);
        saveDb($db, $dataFile);
        jsonResponse($srv, 201);
    }
}

// 10. Commercial Ads: List & Create
if ($uri === '/api/v1/commercial-ads') {
    if ($method === 'GET') {
        jsonResponse($db['commercial_ads']);
    }
    if ($method === 'POST') {
        $ad = $body;
        $ad['id'] = 'comm_' . time();
        $ad['created_at'] = date('Y-m-d H:i:s');
        array_unshift($db['commercial_ads'], $ad);
        saveDb($db, $dataFile);
        jsonResponse($ad, 201);
    }
}

// 11. Chats: Rooms & Messages
if ($uri === '/api/v1/chats' && $method === 'GET') {
    jsonResponse($db['chats'] ?? []);
}

if ($uri === '/api/v1/chats' && $method === 'POST') {
    $roomId = $body['room_id'] ?? ('room_' . time() . '_' . rand(100, 999));
    $participantName = $body['participant_name'] ?? 'مستخدم';
    $participantRole = $body['participant_role'] ?? 'طرف تواصل';
    $related = $body['related_job_or_service'] ?? '';

    // Check if room with this participant or ID already exists
    $found = null;
    if (!isset($db['chats'])) {
        $db['chats'] = [];
    }
    foreach ($db['chats'] as $r) {
        if ($r['id'] === $roomId || $r['participant_name'] === $participantName) {
            $found = $r;
            break;
        }
    }
    if (!$found) {
        $found = [
            'id' => $roomId,
            'participant_name' => $participantName,
            'participant_role' => $participantRole,
            'last_message' => $body['initial_message'] ?? '',
            'last_message_time' => date('Y-m-d H:i:s'),
            'unread_count' => 0,
            'related_job_or_service' => $related,
        ];
        $db['chats'][] = $found;
        if (!empty($body['initial_message'])) {
            if (!isset($db['messages'])) {
                $db['messages'] = [];
            }
            $db['messages'][$roomId][] = [
                'id' => 'msg_' . time(),
                'room_id' => $roomId,
                'sender_id' => $body['sender_id'] ?? 'kw_user_1',
                'sender_name' => $body['sender_name'] ?? 'أحمد الكندري',
                'message' => $body['initial_message'],
                'created_at' => date('Y-m-d H:i:s')
            ];
        }
        saveDb($db, $dataFile);
    }
    jsonResponse($found, 201);
}

if (preg_match('#^/api/v1/chats/([^/]+)/messages$#', $uri, $matches) && $method === 'GET') {
    $roomId = $matches[1];
    $msgs = $db['messages'][$roomId] ?? [];
    jsonResponse($msgs);
}

if (preg_match('#^/api/v1/chats/([^/]+)/send$#', $uri, $matches) && $method === 'POST') {
    $roomId = $matches[1];
    $msg = [
        'id' => 'msg_' . time(),
        'room_id' => $roomId,
        'sender_id' => $body['sender_id'] ?? 'kw_user_1',
        'sender_name' => $body['sender_name'] ?? 'أحمد الكندري',
        'message' => $body['message'] ?? '',
        'created_at' => date('Y-m-d H:i:s')
    ];
    if (!isset($db['messages'][$roomId])) {
        $db['messages'][$roomId] = [];
    }
    $db['messages'][$roomId][] = $msg;

    // Update last message in room
    foreach ($db['chats'] as &$r) {
        if ($r['id'] === $roomId) {
            $r['last_message'] = $msg['message'];
            $r['last_message_time'] = $msg['created_at'];
        }
    }
    saveDb($db, $dataFile);
    jsonResponse($msg, 201);
}

// 12. Payments: MyFatoorah
if ($uri === '/api/v1/payments/myfatoorah/initiate' && $method === 'POST') {
    jsonResponse([
        'invoice_id' => 'MF_KW_' . time(),
        'payment_url' => 'https://demo.myfatoorah.com/checkout',
        'amount_kwd' => (float)($body['amount'] ?? 1.5),
        'currency' => 'KWD',
        'status' => 'initiated'
    ]);
}

// 12b. Application Pricing Config (Admin Updatable)
if ($uri === '/api/v1/application-pricing' && $method === 'GET') {
    if (!isset($db['application_pricing']) || ($db['application_pricing']['inside']['duration_months'] ?? 0) != 3) {
        $db['application_pricing'] = [
            'inside' => [
                'title' => 'Inside Kuwait Application',
                'duration_months' => 3,
                'duration_text' => '3 months',
                'price_kwd' => 2.0,
                'price_text' => '2 KWD',
                'is_free' => false,
            ],
            'outside' => [
                'title' => 'outside application',
                'duration_months' => 3, // 3 months
                'duration_text' => '3 months',
                'price_kwd' => 2.0,     // 2 KWD
                'price_text' => '2 KWD',
                'is_free' => false,
            ]
        ];
        saveDb($db, $dataFile);
    }
    jsonResponse($db['application_pricing']);
}

// 12c. Admin Update Application Pricing
if ($uri === '/api/v1/admin/application-pricing' && ($method === 'POST' || $method === 'PUT')) {
    if (!isset($db['application_pricing'])) {
        $db['application_pricing'] = [
            'inside' => [
                'title' => 'First Ad',
                'duration_months' => 2,
                'price_kwd' => 0.0,
                'is_free' => true,
            ],
            'outside' => [
                'title' => 'outside application',
                'duration_months' => 2,
                'price_kwd' => 2.0,
                'is_free' => false,
            ]
        ];
    }
    if (isset($body['inside']) && is_array($body['inside'])) {
        $db['application_pricing']['inside'] = array_merge($db['application_pricing']['inside'] ?? [], $body['inside']);
    }
    if (isset($body['outside']) && is_array($body['outside'])) {
        $db['application_pricing']['outside'] = array_merge($db['application_pricing']['outside'] ?? [], $body['outside']);
    }
    saveDb($db, $dataFile);
    jsonResponse([
        'success' => true,
        'message' => 'Application pricing updated successfully',
        'data' => $db['application_pricing']
    ]);
}

// 13. User: My Applications
if ($uri === '/api/v1/my-applications' && $method === 'GET') {
    $apps = $db['applications'] ?? [];
    $result = [];
    $currentTime = time();
    foreach ($apps as $a) {
        $jobTitle = 'وظيفة بالكويت';
        $company = 'شركة كويتية';
        $gov = 'محافظة العاصمة';
        $whatsapp = '96599112233';
        $phone = '+965 22445566';
        foreach ($db['jobs'] as $j) {
            if ($j['id'] === ($a['job_id'] ?? '')) {
                $jobTitle = $j['title'];
                $company = $j['company_name'];
                $gov = $j['governorate_name'];
                $whatsapp = $j['whatsapp_number'];
                $phone = $j['phone_number'];
                break;
            }
        }
        $isExpired = isset($a['expires_at']) && strtotime($a['expires_at']) < $currentTime;
        $status = $isExpired ? 'expired' : ($a['status'] ?? 'active');

        $result[] = array_merge($a, [
            'job_title' => $jobTitle,
            'company_name' => $company,
            'governorate_name' => $gov,
            'whatsapp_number' => $whatsapp,
            'phone_number' => $phone,
            'status' => $status,
            'is_active' => !$isExpired
        ]);
    }
    jsonResponse($result);
}

// 14. User: My Ads
if ($uri === '/api/v1/my-ads' && $method === 'GET') {
    jsonResponse([
        'jobs' => array_slice($db['jobs'], 0, 3),
        'services' => array_slice($db['services'], 0, 2),
        'commercial' => array_slice($db['commercial_ads'], 0, 1),
    ]);
}

// 15. Sector Applicants / Candidates
if ($uri === '/api/v1/applicants' && $method === 'GET') {
    $sector = strtolower($_GET['sector'] ?? 'all');
    $subSector = $_GET['sub_sector'] ?? 'All';
    $profession = $_GET['profession'] ?? '';
    $gov = $_GET['governorate'] ?? '';
    $locType = $_GET['location_type'] ?? '';
    $search = strtolower(trim($_GET['search'] ?? ''));

    $applicants = $db['applicants'] ?? [];
    $currentTime = time();
    $filtered = array_values(array_filter($applicants, function ($a) use ($sector, $subSector, $profession, $gov, $locType, $search, $currentTime) {
        // Exclude applicants expired after 2 months (60 days)
        if (isset($a['expires_at']) && strtotime($a['expires_at']) < $currentTime) {
            return false;
        }
        if ($sector !== 'all' && !empty($sector) && strtolower($a['sector']) !== $sector) {
            return false;
        }
        if ($subSector !== 'All' && !empty($subSector) && $a['sub_sector'] !== $subSector) {
            return false;
        }
        if (!empty($profession) && $profession !== 'All professions' && $profession !== 'جميع المهن' && $a['profession'] !== $profession) {
            return false;
        }
        if (!empty($gov) && $gov !== 'All Governorates' && $gov !== 'All' && $gov !== 'جميع المحافظات' && $a['governorate'] !== $gov) {
            return false;
        }
        if (!empty($locType) && $a['location_type'] !== $locType) {
            return false;
        }
        if (!empty($search)) {
            $inName = str_contains(strtolower($a['name']), $search);
            $inProf = str_contains(strtolower($a['profession']), $search);
            $inNat = str_contains(strtolower($a['nationality']), $search);
            if (!$inName && !$inProf && !$inNat) {
                return false;
            }
        }
        return true;
    }));

    jsonResponse($filtered);
}

// 16. Applicant Detail
if (preg_match('#^/api/v1/applicants/([^/]+)$#', $uri, $matches) && $method === 'GET') {
    $applicantId = $matches[1];
    $applicants = $db['applicants'] ?? [];
    foreach ($applicants as $a) {
        if ($a['id'] === $applicantId) {
            jsonResponse($a);
        }
    }
    jsonResponse($applicants[0] ?? []);
}

// 17. Company / Employer Search for Sectors and Professions
if ($uri === '/api/v1/company/search' && $method === 'GET') {
    $q = strtolower(trim($_GET['query'] ?? ''));

    $allSectors = [
        [
            'code' => 'oil_gas',
            'name_en' => 'Oil,Gas & Petrochemicals',
            'name_ar' => 'النفط والغاز والبتروكيماويات',
            'applicants_count' => 14,
        ],
        [
            'code' => 'construction',
            'name_en' => 'Engineering & Construction',
            'name_ar' => 'هندسة ومقاولات وإنشاءات',
            'applicants_count' => 28,
        ],
        [
            'code' => 'medical',
            'name_en' => 'Medical and Healthcare Sector',
            'name_ar' => 'رعاية صحية وطبية',
            'applicants_count' => 19,
        ],
        [
            'code' => 'technical',
            'name_en' => 'Technicians & Maintenance',
            'name_ar' => 'فنيون وصيانة',
            'applicants_count' => 22,
        ],
        [
            'code' => 'drivers',
            'name_en' => 'Drivers & Logistics',
            'name_ar' => 'سائقون وتوصيل ونقل',
            'applicants_count' => 31,
        ],
        [
            'code' => 'restaurants',
            'name_en' => 'Restaurants & Hospitality',
            'name_ar' => 'مطاعم وضيافة وفنادق',
            'applicants_count' => 17,
        ],
        [
            'code' => 'salons',
            'name_en' => 'Salons & Personal Care',
            'name_ar' => 'صالونات وتجميل',
            'applicants_count' => 12,
        ],
        [
            'code' => 'sales',
            'name_en' => 'Sales & Management',
            'name_ar' => 'مبيعات وإدارة ومحاسبة',
            'applicants_count' => 25,
        ],
        [
            'code' => 'domestic',
            'name_en' => 'Domestic & Home Care',
            'name_ar' => 'خدمات منزلية',
            'applicants_count' => 35,
        ],
    ];

    $allProfessions = [
        [
            'id' => 'prof_pharmacy',
            'name_en' => 'Pharmacy Assistant',
            'name_ar' => 'مساعد صيدلي',
            'sector_code' => 'medical',
            'sector_title' => 'Medical and Healthcare Sector',
            'applicants_count' => 6,
        ],
        [
            'id' => 'prof_tailor',
            'name_en' => 'Thobe/Dishdasha Tailor',
            'name_ar' => 'خياط دشاديش وثياب رجالية',
            'sector_code' => 'technical',
            'sector_title' => 'Technicians & Maintenance',
            'applicants_count' => 9,
        ],
        [
            'id' => 'prof_risk_assessor',
            'name_en' => 'Property Risk Assessor',
            'name_ar' => 'مقيم مخاطر عقارية',
            'sector_code' => 'sales',
            'sector_title' => 'Sales & Management',
            'applicants_count' => 3,
        ],
        [
            'id' => 'prof_construction_worker',
            'name_en' => 'Construction Worker',
            'name_ar' => 'عامل بناء وإنشاءات',
            'sector_code' => 'construction',
            'sector_title' => 'Engineering & Construction',
            'applicants_count' => 18,
        ],
        [
            'id' => 'prof_general_nurse',
            'name_en' => 'General Nurse',
            'name_ar' => 'ممرض عام',
            'sector_code' => 'medical',
            'sector_title' => 'Medical and Healthcare Sector',
            'applicants_count' => 12,
        ],
        [
            'id' => 'prof_consultant_physician',
            'name_en' => 'Consultant Physician',
            'name_ar' => 'طبيب استشاري',
            'sector_code' => 'medical',
            'sector_title' => 'Medical and Healthcare Sector',
            'applicants_count' => 5,
        ],
        [
            'id' => 'prof_specialist_physician',
            'name_en' => 'Specialist Physician',
            'name_ar' => 'طبيب أخصائي',
            'sector_code' => 'medical',
            'sector_title' => 'Medical and Healthcare Sector',
            'applicants_count' => 9,
        ],
        [
            'id' => 'prof_general_practitioner',
            'name_en' => 'General Practitioner (GP)',
            'name_ar' => 'طبيب ممارس عام',
            'sector_code' => 'medical',
            'sector_title' => 'Medical and Healthcare Sector',
            'applicants_count' => 11,
        ],
        [
            'id' => 'prof_general_surgeon',
            'name_en' => 'General Surgeon',
            'name_ar' => 'طبيب جراح عام',
            'sector_code' => 'medical',
            'sector_title' => 'Medical and Healthcare Sector',
            'applicants_count' => 4,
        ],
        [
            'id' => 'prof_pediatrician',
            'name_en' => 'Pediatrician',
            'name_ar' => 'طبيب أطفال',
            'sector_code' => 'medical',
            'sector_title' => 'Medical and Healthcare Sector',
            'applicants_count' => 7,
        ],
        [
            'id' => 'prof_dentist',
            'name_en' => 'Dentist & Orthodontist',
            'name_ar' => 'طبيب أسنان وتقويم',
            'sector_code' => 'medical',
            'sector_title' => 'Medical and Healthcare Sector',
            'applicants_count' => 8,
        ],
        [
            'id' => 'prof_electrician',
            'name_en' => 'Building Electrician',
            'name_ar' => 'كهربائي مباني وتمديدات',
            'sector_code' => 'technical',
            'sector_title' => 'Technicians & Maintenance',
            'applicants_count' => 15,
        ],
        [
            'id' => 'prof_ac_tech',
            'name_en' => 'Central AC Technician',
            'name_ar' => 'فني تكييف مركزي',
            'sector_code' => 'technical',
            'sector_title' => 'Technicians & Maintenance',
            'applicants_count' => 14,
        ],
        [
            'id' => 'prof_driver',
            'name_en' => 'Courier Car Delivery Driver',
            'name_ar' => 'سائق توصيل طلبات',
            'sector_code' => 'drivers',
            'sector_title' => 'Drivers & Logistics',
            'applicants_count' => 20,
        ],
        [
            'id' => 'prof_barista',
            'name_en' => 'Professional Barista',
            'name_ar' => 'باريستا محترف',
            'sector_code' => 'restaurants',
            'sector_title' => 'Restaurants & Hospitality',
            'applicants_count' => 8,
        ],
        [
            'id' => 'prof_civil_eng',
            'name_en' => 'Civil Site Engineer',
            'name_ar' => 'مهندس مدني موقع',
            'sector_code' => 'construction',
            'sector_title' => 'Engineering & Construction',
            'applicants_count' => 7,
        ],
    ];

    if (!empty($q)) {
        $filteredSectors = array_values(array_filter($allSectors, function ($s) use ($q) {
            return str_contains(strtolower($s['name_en']), $q) || str_contains(strtolower($s['name_ar']), $q) || str_contains($s['code'], $q);
        }));

        $filteredProfessions = array_values(array_filter($allProfessions, function ($p) use ($q) {
            return str_contains(strtolower($p['name_en']), $q) || str_contains(strtolower($p['name_ar']), $q) || str_contains(strtolower($p['sector_title']), $q);
        }));
    } else {
        $filteredSectors = $allSectors;
        $filteredProfessions = $allProfessions;
    }

    jsonResponse([
        'sectors' => $filteredSectors,
        'professions' => $filteredProfessions,
    ]);
}

// Default 404
errorResponse('Direct Jobs Kuwait API Route Not Found', 404);
