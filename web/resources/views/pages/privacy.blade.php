@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'سياسة الخصوصية لتطبيقات أندرويد و iOS والويب | دايركت وورك' : 'Privacy Policy for Android, iOS & Web | Direct Work')

@section('content')
<div class="space-y-12 lg:space-y-16 py-8">

    <!-- 1. HERO SECTION & COMPLIANCE BADGES -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center max-w-4xl mx-auto space-y-4">
            
            <!-- Compliance Pill -->
            <div class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-blue-50 border border-blue-200 text-blue-700 text-xs font-black shadow-xs">
                <i class="fa-solid fa-shield-halved text-blue-600"></i>
                <span>{{ ($isArabic ?? false) ? 'سياسة الخصوصية الرسمية • متوافقة مع Google Play & Apple App Store' : 'Official Privacy Policy • Google Play & Apple App Store Compliant' }}</span>
            </div>

            <!-- Main Heading -->
            <h1 class="text-3xl sm:text-5xl font-black text-slate-900 tracking-tight leading-tight">
                @if($isArabic ?? false)
                    سياسة الخصوصية لتطبيق <span class="text-blue-600">دايركت وورك</span> <br class="hidden sm:inline">
                    (أندرويد و iOS والمنصة الإلكترونية)
                @else
                    Direct Work <span class="text-blue-600">Privacy Policy</span> <br class="hidden sm:inline">
                    for Android, iOS & Web Platform
                @endif
            </h1>

            <!-- Subtitle -->
            <p class="text-sm sm:text-base text-slate-600 font-medium leading-relaxed max-w-2xl mx-auto">
                @if($isArabic ?? false)
                    نلتزم بحماية خصوصيتك وبياناتك الشخصية والمهنية. توضح هذه الوثيقة بوضوح كيفية جمع البيانات، واستخدامها، وحمايتها، وطرق حذف الحساب وفقاً لمعايير متجر جوجل بلاي وآبل ستور.
                @else
                    We are committed to protecting your personal and professional privacy. This policy outlines how your data is collected, used, protected, and how you can delete your account in accordance with Google Play and Apple App Store standards.
                @endif
            </p>

            <!-- Meta Badges (Platforms, Last Updated) -->
            <div class="flex flex-wrap items-center justify-center gap-3 pt-3 text-xs font-bold text-slate-600">
                <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-slate-100 border border-slate-200">
                    <i class="fa-brands fa-google-play text-emerald-600"></i>
                    <span>Google Play (Android)</span>
                </span>
                <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-slate-100 border border-slate-200">
                    <i class="fa-brands fa-apple text-slate-900"></i>
                    <span>Apple App Store (iOS)</span>
                </span>
                <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-slate-100 border border-slate-200">
                    <i class="fa-solid fa-globe text-blue-600"></i>
                    <span>https://directwork.site</span>
                </span>
                <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-blue-50 border border-blue-200 text-blue-700">
                    <i class="fa-regular fa-clock"></i>
                    <span>{{ ($isArabic ?? false) ? 'آخر تحديث: نوفمبر 2026' : 'Last Updated: November 2026' }}</span>
                </span>
            </div>

        </div>
    </section>

    <!-- 2. QUICK NAVIGATION & ACCOUNT DELETION FAST ACTION -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <!-- Account Deletion Callout Card (Mandatory for Google Play & Apple App Store) -->
        <div class="bg-gradient-to-r from-blue-900 via-blue-800 to-slate-900 rounded-3xl p-6 sm:p-8 text-white shadow-xl mb-12">
            <div class="flex flex-col md:flex-row items-start md:items-center justify-between gap-6">
                <div class="space-y-2 max-w-2xl">
                    <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-red-500/20 text-red-300 border border-red-500/30 text-[11px] font-black uppercase tracking-wider">
                        <i class="fa-solid fa-trash-can"></i>
                        <span>{{ ($isArabic ?? false) ? 'حق حذف الحساب والبيانات (متطلب آبل وجوجل)' : 'Account & Data Deletion (Apple & Google Mandate)' }}</span>
                    </div>
                    <h3 class="text-xl sm:text-2xl font-black">
                        {{ ($isArabic ?? false) ? 'هل ترغب في حذف حسابك وبياناتك نهائياً؟' : 'Need to delete your account and personal data?' }}
                    </h3>
                    <p class="text-xs sm:text-sm text-blue-100 font-medium leading-relaxed">
                        @if($isArabic ?? false)
                            يمكنك في أي وقت حذف حسابك وسيرتك الذاتية وجميع بياناتك من داخل التطبيق عبر: (الإعدادات > حذف الحساب)، أو عبر مراسلتنا بطلب الحذف دون الحاجة لفتح التطبيق.
                        @else
                            You can permanently delete your account, CV, and all associated personal data directly within the mobile app via (Settings > Delete Account), or submit a deletion request online without opening the app.
                        @endif
                    </p>
                </div>
                <div class="flex flex-wrap items-center gap-3 shrink-0">
                    <a href="#account-deletion" 
                       class="px-5 py-3 rounded-xl bg-white hover:bg-slate-100 text-slate-900 font-black text-xs transition shadow-sm flex items-center gap-2">
                        <span>{{ ($isArabic ?? false) ? 'تعليمات حذف الحساب' : 'Deletion Instructions' }}</span>
                        <i class="fa-solid fa-arrow-down text-[10px]"></i>
                    </a>
                    <a href="mailto:privacy@directwork.site?subject=Direct%20Work%20Account%20Deletion%20Request" 
                       class="px-5 py-3 rounded-xl bg-red-600 hover:bg-red-700 text-white font-black text-xs transition shadow-sm flex items-center gap-2">
                        <i class="fa-solid fa-envelope"></i>
                        <span>{{ ($isArabic ?? false) ? 'طلب الحذف عبر البريد' : 'Email Deletion Request' }}</span>
                    </a>
                </div>
            </div>
        </div>

        <!-- Main Content Grid: Sidebar Nav & Document Content -->
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
            
            <!-- Sticky Navigation Table of Contents -->
            <div class="lg:col-span-4 sticky top-28 bg-white rounded-3xl border border-slate-200/90 p-6 shadow-sm space-y-4 hidden lg:block">
                <h4 class="font-black text-slate-900 text-xs uppercase tracking-wider flex items-center gap-2">
                    <i class="fa-solid fa-list-ol text-blue-600"></i>
                    <span>{{ ($isArabic ?? false) ? 'محتويات سياسة الخصوصية' : 'Table of Contents' }}</span>
                </h4>
                <nav class="space-y-1.5 text-xs font-bold text-slate-600">
                    <a href="#overview" class="block px-3 py-2 rounded-xl hover:bg-blue-50 hover:text-blue-700 transition">1. {{ ($isArabic ?? false) ? 'مقدمة ونطاق العمل' : 'Overview & Scope' }}</a>
                    <a href="#data-collection" class="block px-3 py-2 rounded-xl hover:bg-blue-50 hover:text-blue-700 transition">2. {{ ($isArabic ?? false) ? 'البيانات التي نجمعها' : 'Information We Collect' }}</a>
                    <a href="#permissions" class="block px-3 py-2 rounded-xl hover:bg-blue-50 hover:text-blue-700 transition">3. {{ ($isArabic ?? false) ? 'أذونات أندرويد و iOS' : 'Android & iOS Permissions' }}</a>
                    <a href="#data-use" class="block px-3 py-2 rounded-xl hover:bg-blue-50 hover:text-blue-700 transition">4. {{ ($isArabic ?? false) ? 'كيفية استخدام البيانات' : 'How We Use Your Data' }}</a>
                    <a href="#data-sharing" class="block px-3 py-2 rounded-xl hover:bg-blue-50 hover:text-blue-700 transition">5. {{ ($isArabic ?? false) ? 'مشاركة البيانات والشركات' : 'Data Sharing & Third Parties' }}</a>
                    <a href="#security" class="block px-3 py-2 rounded-xl hover:bg-blue-50 hover:text-blue-700 transition">6. {{ ($isArabic ?? false) ? 'حماية وأمان البيانات' : 'Data Security & Storage' }}</a>
                    <a href="#account-deletion" class="block px-3 py-2 rounded-xl bg-red-50 text-red-700 font-black hover:bg-red-100 transition">7. {{ ($isArabic ?? false) ? 'حذف الحساب والاحتفاظ بالبيانات' : 'Account Deletion & Retention' }}</a>
                    <a href="#user-rights" class="block px-3 py-2 rounded-xl hover:bg-blue-50 hover:text-blue-700 transition">8. {{ ($isArabic ?? false) ? 'حقوق المستخدم (GDPR & الخليج)' : 'User Rights & Privacy Choices' }}</a>
                    <a href="#children" class="block px-3 py-2 rounded-xl hover:bg-blue-50 hover:text-blue-700 transition">9. {{ ($isArabic ?? false) ? 'خصوصية القُصّر والأطفال' : "Children's Privacy" }}</a>
                    <a href="#contact" class="block px-3 py-2 rounded-xl hover:bg-blue-50 hover:text-blue-700 transition">10. {{ ($isArabic ?? false) ? 'مسؤول الخصوصية والتواصل' : 'Privacy Officer & Contact' }}</a>
                </nav>
            </div>

            <!-- Privacy Policy Articles -->
            <div class="lg:col-span-8 space-y-8">
                
                <!-- Section 1: Overview & Scope -->
                <article id="overview" class="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 shadow-card space-y-4">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center font-black">1</div>
                        <h2 class="text-xl sm:text-2xl font-black text-slate-900">
                            {{ ($isArabic ?? false) ? 'مقدمة ونطاق التطبيق' : '1. Overview & Scope' }}
                        </h2>
                    </div>
                    <div class="text-xs sm:text-sm text-slate-600 font-medium leading-relaxed space-y-3">
                        @if($isArabic ?? false)
                            <p>
                                مرحباً بكم في منصة وتطبيق <strong>دايركت وورك (Direct Work)</strong>، المنصة المباشرة للتوظيف واستقطاب الكفاءات في دولة الكويت، والمملكة العربية السعودية، والإمارات العربية المتحدة.
                            </p>
                            <p>
                                تنطبق سياسة الخصوصية هذه على جميع مستخدمي تطبيقنا للهواتف الذكية على نظام أندرويد (Google Play)، ونظام آبل iOS (Apple App Store)، والموقع الإلكتروني الرسمي (<a href="https://directwork.site" class="text-blue-600 font-bold underline">directwork.site</a>).
                            </p>
                            <p>
                                من خلال تنزيل أو تثبيت أو إنشاء حساب على تطبيق دايركت وورك، فإنك توافق على ممارسات جمع البيانات واستخدامها الموضحة في هذه الوثيقة بما يتوافق مع القوانين واللوائح المعمول بها في دول مجلس التعاون الخليجي، وسياسات المطورين في جوجل وآبل.
                            </p>
                        @else
                            <p>
                                Welcome to <strong>Direct Work</strong>, the direct hiring and talent matching platform operating across the State of Kuwait, the Kingdom of Saudi Arabia, and the United Arab Emirates.
                            </p>
                            <p>
                                This Privacy Policy applies to all users of our mobile applications available on Google Play (Android) and the Apple App Store (iOS), as well as our official website (<a href="https://directwork.site" class="text-blue-600 font-bold underline">directwork.site</a>).
                            </p>
                            <p>
                                By installing, accessing, or creating an account on the Direct Work app or web service, you consent to the data collection, handling, and storage practices detailed in this document in accordance with GCC Data Protection Regulations, Google Play Developer Policies, and Apple App Store Review Guidelines.
                            </p>
                        @endif
                    </div>
                </article>

                <!-- Section 2: Information We Collect -->
                <article id="data-collection" class="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 shadow-card space-y-4">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center font-black">2</div>
                        <h2 class="text-xl sm:text-2xl font-black text-slate-900">
                            {{ ($isArabic ?? false) ? 'البيانات والمعلومات التي نجمعها' : '2. Information We Collect' }}
                        </h2>
                    </div>
                    <div class="text-xs sm:text-sm text-slate-600 font-medium leading-relaxed space-y-4">
                        @if($isArabic ?? false)
                            <p>نجمع المعلومات الضرورية فقط لتمكين عملية التوظيف المباشر، وتوثيق الحسابات، وتسهيل التواصل بين الباحثين عن عمل والشركات:</p>
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 pt-2">
                                <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 space-y-2">
                                    <h4 class="font-black text-slate-900 flex items-center gap-2">
                                        <i class="fa-solid fa-user-tie text-blue-600"></i>
                                        <span>بيانات الباحث عن عمل (المرشح)</span>
                                    </h4>
                                    <ul class="list-disc list-inside space-y-1 text-slate-600 text-xs">
                                        <li>الاسم الكامل والجنسية</li>
                                        <li>البريد الإلكتروني ورقم الهاتف المسجل</li>
                                        <li>المهنة والسنوات والخبرات السابقة</li>
                                        <li>ملف السيرة الذاتية (CV / PDF / صور)</li>
                                        <li>المدينة أو المحافظة المقيم بها</li>
                                    </ul>
                                </div>
                                <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 space-y-2">
                                    <h4 class="font-black text-slate-900 flex items-center gap-2">
                                        <i class="fa-solid fa-building text-blue-600"></i>
                                        <span>بيانات صاحب العمل / الشركة</span>
                                    </h4>
                                    <ul class="list-disc list-inside space-y-1 text-slate-600 text-xs">
                                        <li>اسم الشركة والكيان التجاري</li>
                                        <li>اسم مسؤول التوظيف والاتصال</li>
                                        <li>رقم السجل التجاري أو الترخيص للتوثيق</li>
                                        <li>رقم هاتف الشركة والبريد الرسمي</li>
                                        <li>تفاصيل الوظائف المعلنة</li>
                                    </ul>
                                </div>
                            </div>
                        @else
                            <p>We only collect information strictly necessary to facilitate verified direct employment and enable companies to connect with candidates:</p>
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 pt-2">
                                <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 space-y-2">
                                    <h4 class="font-black text-slate-900 flex items-center gap-2">
                                        <i class="fa-solid fa-user-tie text-blue-600"></i>
                                        <span>Job Seeker / Candidate Data</span>
                                    </h4>
                                    <ul class="list-disc list-inside space-y-1 text-slate-600 text-xs">
                                        <li>Full name and nationality</li>
                                        <li>Email address and verified phone number</li>
                                        <li>Profession, skills, and years of experience</li>
                                        <li>Uploaded CV / Resume files (PDF/Images)</li>
                                        <li>City and region of residence</li>
                                    </ul>
                                </div>
                                <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 space-y-2">
                                    <h4 class="font-black text-slate-900 flex items-center gap-2">
                                        <i class="fa-solid fa-building text-blue-600"></i>
                                        <span>Employer / Company Data</span>
                                    </h4>
                                    <ul class="list-disc list-inside space-y-1 text-slate-600 text-xs">
                                        <li>Company / Enterprise trade name</li>
                                        <li>Contact person / HR manager name</li>
                                        <li>Commercial registration or business license</li>
                                        <li>Official corporate phone & email</li>
                                        <li>Job vacancy descriptions posted</li>
                                    </ul>
                                </div>
                            </div>
                        @endif
                    </div>
                </article>

                <!-- Section 3: Android & iOS Permissions Disclosure (Google Play & Apple Review Mandate) -->
                <article id="permissions" class="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 shadow-card space-y-6">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-2xl bg-emerald-50 text-emerald-600 flex items-center justify-center font-black">3</div>
                        <div>
                            <h2 class="text-xl sm:text-2xl font-black text-slate-900">
                                {{ ($isArabic ?? false) ? 'أذونات تطبيقات أندرويد و iOS' : '3. Android & iOS App Permissions' }}
                            </h2>
                            <p class="text-xs text-slate-500 font-semibold">
                                {{ ($isArabic ?? false) ? 'إفصاح صريح ودقيق وفقاً لسياسات Google Play ومتجر Apple' : 'Explicit disclosures required by Google Play & Apple App Store Policies' }}
                            </p>
                        </div>
                    </div>

                    <div class="text-xs sm:text-sm text-slate-600 font-medium leading-relaxed space-y-4">
                        <p>
                            @if($isArabic ?? false)
                                يطلب تطبيق <strong>دايركت وورك</strong> الأذونات التقنية التالية من نظام التشغيل فقط عند الحاجة الفعلية لها لتقديم الخدمة:
                            @else
                                The <strong>Direct Work</strong> mobile application requests the following operating system permissions strictly when needed for core functionality:
                            @endif
                        </p>

                        <!-- Permissions Breakdown Table / Cards -->
                        <div class="space-y-3">
                            
                            <!-- 1. Camera -->
                            <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 flex items-start gap-4">
                                <div class="w-10 h-10 rounded-xl bg-blue-100 text-blue-700 flex items-center justify-center shrink-0 text-base">
                                    <i class="fa-solid fa-camera"></i>
                                </div>
                                <div class="space-y-1">
                                    <div class="flex items-center gap-2">
                                        <h4 class="font-black text-slate-900 text-sm">
                                            {{ ($isArabic ?? false) ? 'الكاميرا (Camera)' : 'Camera Access' }}
                                        </h4>
                                        <span class="text-[10px] font-mono px-2 py-0.5 rounded bg-slate-200 text-slate-700">CAMERA / NSCameraUsageDescription</span>
                                    </div>
                                    <p class="text-xs text-slate-600 leading-relaxed">
                                        @if($isArabic ?? false)
                                            تُستخدم فقط إذا اخترت التقاط صورة فورية لشهادتك المهنية أو السيرة الذاتية أو رخصة الشركة مباشرة من هاتفك لرفعها إلى ملفك الشخصي. لا يتم تشغيل الكاميرا في الخلفية أبداً.
                                        @else
                                            Used solely if you choose to take a photo of your certificate, CV, or business license directly from your camera to upload to your profile. The camera is never accessed in the background.
                                        @endif
                                    </p>
                                </div>
                            </div>

                            <!-- 2. Photos & Media Storage -->
                            <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 flex items-start gap-4">
                                <div class="w-10 h-10 rounded-xl bg-purple-100 text-purple-700 flex items-center justify-center shrink-0 text-base">
                                    <i class="fa-solid fa-images"></i>
                                </div>
                                <div class="space-y-1">
                                    <div class="flex items-center gap-2">
                                        <h4 class="font-black text-slate-900 text-sm">
                                            {{ ($isArabic ?? false) ? 'معرض الصور والمستندات (Storage / Media)' : 'Photos, Storage & Media Access' }}
                                        </h4>
                                        <span class="text-[10px] font-mono px-2 py-0.5 rounded bg-slate-200 text-slate-700">READ_MEDIA_IMAGES / NSPhotoLibraryUsageDescription</span>
                                    </div>
                                    <p class="text-xs text-slate-600 leading-relaxed">
                                        @if($isArabic ?? false)
                                            تُستخدم للسماح لك باختيار ملف السيرة الذاتية (PDF أو صورة) أو مستند الرخصة التجارية المحفوظ على جهازك لرفعه إلى ملفك في التطبيق. لا نقوم بفحص أو قراءة أي ملفات أخرى خارج الملف الذي تحدده أنت يدوياً.
                                        @else
                                            Used to allow you to select your CV/Resume file (PDF or image) or commercial license document stored on your device to attach to your profile. We do not inspect or access any files other than those you specifically select.
                                        @endif
                                    </p>
                                </div>
                            </div>

                            <!-- 3. Push Notifications -->
                            <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 flex items-start gap-4">
                                <div class="w-10 h-10 rounded-xl bg-amber-100 text-amber-700 flex items-center justify-center shrink-0 text-base">
                                    <i class="fa-solid fa-bell"></i>
                                </div>
                                <div class="space-y-1">
                                    <div class="flex items-center gap-2">
                                        <h4 class="font-black text-slate-900 text-sm">
                                            {{ ($isArabic ?? false) ? 'الإشعارات (Push Notifications)' : 'Push Notifications' }}
                                        </h4>
                                        <span class="text-[10px] font-mono px-2 py-0.5 rounded bg-slate-200 text-slate-700">POST_NOTIFICATIONS / APNs</span>
                                    </div>
                                    <p class="text-xs text-slate-600 leading-relaxed">
                                        @if($isArabic ?? false)
                                            لإرسال تنبيهات لحظية عند تواصل شركة معك بخصوص وظيفة، أو تحديث حالة توثيق حسابك، أو إشعارات الشات المباشر. يمكنك تعطيل الإشعارات في أي وقت من إعدادات جهازك.
                                        @else
                                            Used to deliver instant alerts when an employer contacts you regarding a vacancy, when your account verification status changes, or when you receive a direct chat message. You may disable notifications at any time via your device settings.
                                        @endif
                                    </p>
                                </div>
                            </div>

                        </div>

                        <!-- Explicit Negative Prohibitions (Confidence for Google & Apple) -->
                        <div class="p-4 rounded-2xl bg-emerald-50/80 border border-emerald-200/90 text-emerald-950 space-y-1.5">
                            <h5 class="font-black text-xs flex items-center gap-2 text-emerald-900">
                                <i class="fa-solid fa-circle-check text-emerald-600"></i>
                                <span>{{ ($isArabic ?? false) ? 'ما لا نطلبه ولا نصل إليه أبداً:' : 'What We NEVER Request or Access:' }}</span>
                            </h5>
                            <p class="text-xs leading-relaxed text-emerald-800">
                                @if($isArabic ?? false)
                                    لا يطلب تطبيق دايركت وورك ولا يصل إلى: تتبع الموقع الجغرافي بالخلفية (GPS)، جهات الاتصال الخاصة بك (Contacts)، الميكروفون (Microphone)، الرسائل النصية القصيرة (SMS)، أو أي بيانات تتبع عبر تطبيقات أخرى (No App Tracking Across 3rd Parties).
                                @else
                                    Direct Work NEVER requests or accesses: background GPS location tracking, your device address book/contacts, microphone recording, SMS text messages, or cross-app tracking across third-party apps and websites (No App Tracking Transparency / ATT tracking).
                                @endif
                            </p>
                        </div>

                    </div>
                </article>

                <!-- Section 4: How We Use Your Data -->
                <article id="data-use" class="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 shadow-card space-y-4">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center font-black">4</div>
                        <h2 class="text-xl sm:text-2xl font-black text-slate-900">
                            {{ ($isArabic ?? false) ? 'كيف نستخدم بياناتك' : '4. How We Use Your Data' }}
                        </h2>
                    </div>
                    <div class="text-xs sm:text-sm text-slate-600 font-medium leading-relaxed space-y-3">
                        @if($isArabic ?? false)
                            <ul class="list-disc list-inside space-y-2">
                                <li><strong>تسهيل التوظيف المباشر:</strong> عرض بيانات السيرة الذاتية المهنية للشركات والمؤسسات المسجلة في الكويت والسعودية والإمارات للاتصال بالمرشحين.</li>
                                <li><strong>توثيق الهوية والحسابات:</strong> التحقق من أرقام الهواتف والكيانات التجارية لمنع التلاعب والإعلانات الوهمية.</li>
                                <li><strong>التواصل والدعم الفني:</strong> الرد على استفساراتك وتذاكر الدعم وتقديم المساعدة التقنية.</li>
                                <li><strong>الأمان ومكافحة الاحتيال:</strong> مراقبة محاولات الاختراق، ومنع التسجيلات المكررة غير المصرح بها.</li>
                            </ul>
                        @else
                            <ul class="list-disc list-inside space-y-2">
                                <li><strong>Facilitating Direct Hiring:</strong> Displaying candidate qualifications and verified profiles to legitimate registered employers in Kuwait, Saudi Arabia, and the UAE.</li>
                                <li><strong>Identity & Business Verification:</strong> Verifying phone numbers and commercial registrations to protect candidates from fraudulent recruiters.</li>
                                <li><strong>Support & Communication:</strong> Assisting you via technical support tickets, inquiries, and customer service.</li>
                                <li><strong>Platform Integrity & Security:</strong> Preventing unauthorized automated registrations, spam, and cyber threats.</li>
                            </ul>
                        @endif
                    </div>
                </article>

                <!-- Section 5: Data Sharing & Third Parties -->
                <article id="data-sharing" class="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 shadow-card space-y-4">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center font-black">5</div>
                        <h2 class="text-xl sm:text-2xl font-black text-slate-900">
                            {{ ($isArabic ?? false) ? 'مشاركة البيانات والأطراف الثالثة' : '5. Data Sharing & Third Parties' }}
                        </h2>
                    </div>
                    <div class="text-xs sm:text-sm text-slate-600 font-medium leading-relaxed space-y-3">
                        @if($isArabic ?? false)
                            <p><strong>نحن لا نبيع بياناتك الشخصية أبداً لأي طرف خارجي أو وسطاء إعلانات.</strong></p>
                            <p>تتم مشاركة البيانات المهنية في الحالات المحددة التالية فقط:</p>
                            <ul class="list-disc list-inside space-y-1.5">
                                <li><strong>الشركات وأصحاب الأعمال:</strong> عند إنشاء سيرة ذاتية، فإن تفاصيلك المهنية ووسائل الاتصال المعتمدة تظهر للشركات المعتمدة للتواصل التوظيفي المباشر.</li>
                                <li><strong>مزودو الخدمات التقنية الموثوقون:</strong> شركات الاستضافة السحابية الآمنة، ومزودو خدمة إرسال رسائل التحقق (SMS)، مع خضوعهم لاتفاقيات سرية بيانات صارمة.</li>
                                <li><strong>الالتزام القانوني:</strong> الإفصاح عن البيانات للجهات الرسمية أو القضائية فقط عند وجود أمر قضائي رسمي ملزم بموجب القوانين النافذة في دولة الكويت ودول الخليج.</li>
                            </ul>
                        @else
                            <p><strong>We NEVER sell or rent your personal data to data brokers or advertising networks.</strong></p>
                            <p>Data is shared solely under the following transparent conditions:</p>
                            <ul class="list-disc list-inside space-y-1.5">
                                <li><strong>Verified Employers:</strong> When you register as a job candidate, your professional credentials and contact details are made available to verified employers on Direct Work for employment contact.</li>
                                <li><strong>Infrastructure Service Providers:</strong> Trusted enterprise cloud servers, transactional SMS gateways, and secure push notification delivery vendors operating under strict non-disclosure agreements.</li>
                                <li><strong>Legal Requirements:</strong> Disclosures made solely to government or judicial authorities if strictly compelled by a valid legal court order under Kuwaiti or GCC laws.</li>
                            </ul>
                        @endif
                    </div>
                </article>

                <!-- Section 6: Data Security & Storage -->
                <article id="security" class="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 shadow-card space-y-4">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center font-black">6</div>
                        <h2 class="text-xl sm:text-2xl font-black text-slate-900">
                            {{ ($isArabic ?? false) ? 'حماية وأمان البيانات' : '6. Data Security & Storage' }}
                        </h2>
                    </div>
                    <div class="text-xs sm:text-sm text-slate-600 font-medium leading-relaxed space-y-3">
                        @if($isArabic ?? false)
                            <p>
                                نطبق تدابير تقنية وإدارية متقدمة لحماية بياناتك من الفقدان أو السرقة أو الوصول غير المصرح به:
                            </p>
                            <ul class="list-disc list-inside space-y-1.5">
                                <li>تشفير جميع الاتصالات عبر بروتوكول <strong>HTTPS / TLS 1.3</strong> مع شهادات أمان معتمدة.</li>
                                <li>تشفير كلمات المرور باستخدام أحدث خوارزميات التشفير ذات الاتجاه الواحد (Bcrypt Hashing).</li>
                                <li>جدران حماية متقدمة ومراقبة دورية لمنع الهجمات الإلكترونية.</li>
                            </ul>
                        @else
                            <p>
                                We employ comprehensive technical and organizational measures to safeguard your personal data against unauthorized access, alteration, or disclosure:
                            </p>
                            <ul class="list-disc list-inside space-y-1.5">
                                <li>All client-to-server data transmissions are protected via strong <strong>HTTPS / TLS 1.3</strong> encryption.</li>
                                <li>User passwords are protected with modern, irreversible cryptographic one-way hashing (Bcrypt).</li>
                                <li>Multi-layer firewalls, regular vulnerability scans, and strict access controls.</li>
                            </ul>
                        @endif
                    </div>
                </article>

                <!-- Section 7: Account Deletion & Data Retention (MANDATORY FOR GOOGLE PLAY & APPLE STORE) -->
                <article id="account-deletion" class="bg-red-50/50 rounded-3xl border-2 border-red-200 p-6 sm:p-8 shadow-card space-y-6">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-2xl bg-red-600 text-white flex items-center justify-center font-black">7</div>
                        <div>
                            <h2 class="text-xl sm:text-2xl font-black text-slate-900">
                                {{ ($isArabic ?? false) ? 'حذف الحساب والاحتفاظ بالبيانات' : '7. Account Deletion & Data Retention' }}
                            </h2>
                            <span class="text-xs font-bold text-red-600">
                                {{ ($isArabic ?? false) ? 'متوافق مع المادة 5.1.1(v) لمتجر آبل وسياسة بيانات جوجل بلاي' : 'Compliant with Apple Guideline 5.1.1(v) & Google Play Data Safety Policy' }}
                            </span>
                        </div>
                    </div>

                    <div class="text-xs sm:text-sm text-slate-700 font-medium leading-relaxed space-y-4">
                        @if($isArabic ?? false)
                            <p>
                                نمنحك التحكم الكامل في حسابك. يمكنك حذف حسابك وجميع بياناتك المرتبطة به نهائياً وبسهولة عبر طريقتين رسميتين:
                            </p>

                            <!-- Method 1: Inside App -->
                            <div class="p-4 rounded-2xl bg-white border border-red-200 space-y-2">
                                <h4 class="font-black text-slate-900 text-sm flex items-center gap-2">
                                    <i class="fa-solid fa-mobile-screen-button text-red-600"></i>
                                    <span>الطريقة الأولى: الحذف الفوري من داخل التطبيق (أندرويد و iOS)</span>
                                </h4>
                                <ol class="list-decimal list-inside space-y-1 text-slate-600 text-xs">
                                    <li>افتح تطبيق <strong>دايركت وورك</strong> وسجل الدخول إلى حسابك.</li>
                                    <li>انتقل إلى شاشة <strong>الملف الشخصي (Profile)</strong> أو <strong>الإعدادات (Settings)</strong>.</li>
                                    <li>اضغط على خيار <strong>حذف الحساب نهائياً (Delete Account)</strong> الموجود أسفل الشاشة.</li>
                                    <li>أكد رغبتك بالحذف، وسيتم مسح الحساب والسيرة الذاتية والصور وملفات التوثيق فوراً من قواعد بياناتنا النشطة.</li>
                                </ol>
                            </div>

                            <!-- Method 2: Web / Email Request -->
                            <div class="p-4 rounded-2xl bg-white border border-red-200 space-y-2">
                                <h4 class="font-black text-slate-900 text-sm flex items-center gap-2">
                                    <i class="fa-solid fa-globe text-red-600"></i>
                                    <span>الطريقة الثانية: طلب الحذف عبر الموقع الإلكتروني أو البريد</span>
                                </h4>
                                <p class="text-xs text-slate-600">
                                    إذا لم يعد التطبيق مثبتاً على هاتفك، يمكنك طلب حذف حسابك وبياناتك مباشرة بمراسلة فريق الخصوصية:
                                </p>
                                <div class="pt-2 flex flex-wrap items-center gap-3">
                                    <a href="mailto:privacy@directwork.site?subject=طلب%20حذف%20حساب%20دايركت%20وورك" 
                                       class="px-4 py-2.5 rounded-xl bg-red-600 hover:bg-red-700 text-white font-black text-xs transition inline-flex items-center gap-2">
                                        <i class="fa-solid fa-envelope"></i>
                                        <span>إرسال بريد الحذف: privacy@directwork.site</span>
                                    </a>
                                    <a href="{{ route('support') }}" 
                                       class="px-4 py-2.5 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-800 font-black text-xs transition inline-flex items-center gap-2">
                                        <i class="fa-solid fa-headset"></i>
                                        <span>عبر تذكرة الدعم الفني</span>
                                    </a>
                                </div>
                            </div>

                            <!-- Retention Period Note -->
                            <div class="text-xs text-slate-500 pt-1">
                                <strong>فترة الاحتفاظ بالبيانات:</strong> يتم الاحتفاظ ببياناتك طالما كان حسابك نشطاً. عند طلب الحذف، تُحذف فوراً السير الذاتية وأرقام الهواتف والمستندات الشخصية بشكل دائم، مع الاحتفاظ فقط بالسجلات المحاسبية أو القانونية الإلزامية المشفرة وفقاً للمدد المقررة قانوناً في دولة الكويت.
                            </div>
                        @else
                            <p>
                                We believe in your absolute right to control your personal data. You may permanently delete your account and all associated records at any time using either of the following two options:
                            </p>

                            <!-- Method 1: Inside App -->
                            <div class="p-4 rounded-2xl bg-white border border-red-200 space-y-2">
                                <h4 class="font-black text-slate-900 text-sm flex items-center gap-2">
                                    <i class="fa-solid fa-mobile-screen-button text-red-600"></i>
                                    <span>Method 1: Instant In-App Deletion (Android & iOS)</span>
                                </h4>
                                <ol class="list-decimal list-inside space-y-1 text-slate-600 text-xs">
                                    <li>Open the <strong>Direct Work</strong> app and sign in.</li>
                                    <li>Navigate to your <strong>Profile</strong> or <strong>Settings</strong> screen.</li>
                                    <li>Tap the <strong>Delete Account</strong> option located at the bottom of the screen.</li>
                                    <li>Confirm your request. Your profile, CV, uploaded files, and phone number will be erased immediately from our active database.</li>
                                </ol>
                            </div>

                            <!-- Method 2: Web / Email Request -->
                            <div class="p-4 rounded-2xl bg-white border border-red-200 space-y-2">
                                <h4 class="font-black text-slate-900 text-sm flex items-center gap-2">
                                    <i class="fa-solid fa-globe text-red-600"></i>
                                    <span>Method 2: Web / Email Deletion Request (Without App)</span>
                                </h4>
                                <p class="text-xs text-slate-600">
                                    If you no longer have the app installed, you can submit an account and data purge request directly to our Privacy Team:
                                </p>
                                <div class="pt-2 flex flex-wrap items-center gap-3">
                                    <a href="mailto:privacy@directwork.site?subject=Direct%20Work%20Account%20Deletion%20Request" 
                                       class="px-4 py-2.5 rounded-xl bg-red-600 hover:bg-red-700 text-white font-black text-xs transition inline-flex items-center gap-2">
                                        <i class="fa-solid fa-envelope"></i>
                                        <span>Email Us: privacy@directwork.site</span>
                                    </a>
                                    <a href="{{ route('support') }}" 
                                       class="px-4 py-2.5 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-800 font-black text-xs transition inline-flex items-center gap-2">
                                        <i class="fa-solid fa-headset"></i>
                                        <span>Contact Support Form</span>
                                    </a>
                                </div>
                            </div>

                            <!-- Retention Period Note -->
                            <div class="text-xs text-slate-500 pt-1">
                                <strong>Data Retention Period:</strong> Your data is retained only while your account remains active. Once deleted, your CV, phone number, and personal records are permanently erased from active production servers within 24 to 72 hours.
                            </div>
                        @endif
                    </div>
                </article>

                <!-- Section 8: User Rights & Privacy Choices -->
                <article id="user-rights" class="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 shadow-card space-y-4">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center font-black">8</div>
                        <h2 class="text-xl sm:text-2xl font-black text-slate-900">
                            {{ ($isArabic ?? false) ? 'حقوق المستخدم والخيارات المتاحة' : '8. User Rights & Privacy Choices' }}
                        </h2>
                    </div>
                    <div class="text-xs sm:text-sm text-slate-600 font-medium leading-relaxed space-y-3">
                        @if($isArabic ?? false)
                            <p>وفقاً لأفضل ممارسات حماية البيانات وقوانين حماية البيانات الشخصية بالخليج العربي، يحق لك:</p>
                            <ul class="list-disc list-inside space-y-1.5">
                                <li><strong>حق الوصول:</strong> الاطلاع على نسختك من البيانات المسجلة لدينا في أي وقت.</li>
                                <li><strong>حق التصحيح:</strong> تعديل أي بيانات غير صحيحة أو تحديث سيرتك الذاتية من ملفك الشخصي.</li>
                                <li><strong>حق سحب الأذونات:</strong> إلغاء إذن الوصول للكاميرا أو الصور أو الإشعارات في أي وقت من إعدادات نظام جهازك دون التأثير على وظائف التطبيق الأخرى.</li>
                                <li><strong>حق النسيان والحذف:</strong> حذف حسابك بالكامل كما هو مبين في القسم (7).</li>
                            </ul>
                        @else
                            <p>Under GCC Data Protection Laws and international standards (GDPR), you possess the following rights:</p>
                            <ul class="list-disc list-inside space-y-1.5">
                                <li><strong>Right to Access:</strong> View and retrieve copies of the personal data we hold about you.</li>
                                <li><strong>Right to Rectification:</strong> Edit or update any outdated profile, contact, or professional information directly.</li>
                                <li><strong>Right to Revoke Permissions:</strong> Disable camera, photo library, or push notification permissions at any time via your iOS or Android Settings app.</li>
                                <li><strong>Right to Erasure:</strong> Permanently delete your account and profile records as detailed in Section 7.</li>
                            </ul>
                        @endif
                    </div>
                </article>

                <!-- Section 9: Children's Privacy -->
                <article id="children" class="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 shadow-card space-y-4">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center font-black">9</div>
                        <h2 class="text-xl sm:text-2xl font-black text-slate-900">
                            {{ ($isArabic ?? false) ? 'خصوصية القُصّر والأطفال' : "9. Children's Privacy" }}
                        </h2>
                    </div>
                    <div class="text-xs sm:text-sm text-slate-600 font-medium leading-relaxed space-y-2">
                        @if($isArabic ?? false)
                            <p>
                                إن منصة وتطبيق دايركت وورك موجهان للأفراد الباحثين عن عمل والشركات المؤهلة قانوناً للتوظيف والعمل (الحد الأدنى 18 عاماً).
                            </p>
                            <p>
                                نحن لا نجمع عن قصد أي بيانات شخصية من القُصّر دون سن 18 عاماً. إذا نمى إلى علمنا تسجيل شخص دون السن القانونية، نقوم بحذف الحساب وبياناته فوراً.
                            </p>
                        @else
                            <p>
                                The Direct Work platform and mobile applications are strictly intended for adults of legal employment age (minimum 18 years old).
                            </p>
                            <p>
                                We do not knowingly collect personal information from individuals under the age of 18. If we discover that a minor has registered an account, we will take immediate steps to permanently delete the account and its records.
                            </p>
                        @endif
                    </div>
                </article>

                <!-- Section 10: Contact Information & Data Protection Officer -->
                <article id="contact" class="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 shadow-card space-y-6">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center font-black">10</div>
                        <div>
                            <h2 class="text-xl sm:text-2xl font-black text-slate-900">
                                {{ ($isArabic ?? false) ? 'التواصل ومسؤول حماية البيانات' : '10. Contact Us & Data Protection Officer' }}
                            </h2>
                            <p class="text-xs text-slate-500 font-semibold">
                                {{ ($isArabic ?? false) ? 'يسعدنا الرد على أي استفسارات تتعلق بخصوصيتك' : 'We are here to assist with any questions regarding your privacy' }}
                            </p>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 space-y-1">
                            <span class="text-[10px] font-black text-slate-400 uppercase tracking-wider">
                                {{ ($isArabic ?? false) ? 'البريد الإلكتروني للخصوصية' : 'Privacy Inquiries Email' }}
                            </span>
                            <div class="font-bold text-slate-900 text-sm">
                                <a href="mailto:privacy@directwork.site" class="text-blue-600 hover:underline">privacy@directwork.site</a>
                            </div>
                        </div>

                        <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 space-y-1">
                            <span class="text-[10px] font-black text-slate-400 uppercase tracking-wider">
                                {{ ($isArabic ?? false) ? 'الدعم الفني والواتساب' : 'Support & WhatsApp' }}
                            </span>
                            <div class="font-bold text-slate-900 text-sm">
                                <a href="https://wa.me/96566707126" target="_blank" class="text-emerald-600 hover:underline">+965 6670 7126</a>
                            </div>
                        </div>

                        <div class="p-4 rounded-2xl bg-slate-50 border border-slate-200/80 space-y-1 sm:col-span-2">
                            <span class="text-[10px] font-black text-slate-400 uppercase tracking-wider">
                                {{ ($isArabic ?? false) ? 'المقر الإقليمي' : 'Headquarters & Operational Entity' }}
                            </span>
                            <div class="font-bold text-slate-900 text-xs">
                                {{ ($isArabic ?? false) ? 'منصة دايركت وورك الرقمية • مدينة الكويت، دولة الكويت' : 'Direct Work Digital Platform • Kuwait City, State of Kuwait' }}
                            </div>
                        </div>
                    </div>
                </article>

            </div>

        </div>

    </section>

</div>
@endsection
