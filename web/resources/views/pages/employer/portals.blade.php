<!DOCTYPE html>
<html lang="{{ $currentLocale ?? 'en' }}" dir="{{ ($isArabic ?? false) ? 'rtl' : 'ltr' }}" class="h-full">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ ($isArabic ?? false) ? 'بوابة الشركات والمكاتب | دايركت وورك' : 'Companies & Offices Portal | Direct Work' }}</title>
    
    <!-- Fonts & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: {{ ($isArabic ?? false) ? "'Cairo', sans-serif" : "'Plus Jakarta Sans', sans-serif" }};
            background-color: #F8FAFC;
        }
    </style>
</head>
<body class="min-h-full flex flex-col justify-between text-slate-900 antialiased selection:bg-blue-600 selection:text-white">

    <!-- Top Navigation -->
    <header class="py-6 px-4 sm:px-8 max-w-7xl mx-auto w-full flex items-center justify-between">
        <a href="{{ route('home') }}" class="flex items-center gap-3">
            <img src="{{ asset('images/logo.png') }}" alt="Direct Work Logo" class="w-10 h-10 object-contain rounded-2xl shadow-sm">
            <span class="text-xl font-black text-slate-900">
                {{ ($isArabic ?? false) ? 'دايركت وورك' : 'Direct Work' }}
            </span>
        </a>

        <div class="flex items-center gap-3">
            <a href="{{ route('home') }}" 
               class="inline-flex items-center gap-2 px-4 py-2 rounded-full border border-slate-200 bg-white hover:bg-slate-50 text-slate-700 text-xs font-bold transition shadow-xs">
                <i class="fa-solid fa-arrow-left text-[11px] {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
                <span>{{ ($isArabic ?? false) ? 'الرئيسية' : 'Home' }}</span>
            </a>

            @if($isArabic ?? false)
                <a href="{{ route('locale.set', 'en') }}" class="px-3 py-1.5 rounded-full border border-slate-200 bg-white hover:bg-slate-50 text-slate-700 text-xs font-bold transition">
                    EN
                </a>
            @else
                <a href="{{ route('locale.set', 'ar') }}" class="px-3 py-1.5 rounded-full border border-slate-200 bg-white hover:bg-slate-50 text-slate-700 text-xs font-bold transition">
                    AR
                </a>
            @endif
        </div>
    </header>

    <!-- Center Content -->
    <main class="max-w-5xl mx-auto px-4 sm:px-6 py-12 flex-1 flex flex-col justify-center text-center">
        
        <!-- Tag -->
        <div class="mb-4">
            <span class="inline-flex items-center gap-1.5 px-3.5 py-1.5 rounded-full bg-blue-50 border border-blue-200/80 text-blue-700 text-xs font-black uppercase tracking-wider">
                <span class="w-2 h-2 rounded-full bg-blue-600"></span>
                <span>{{ ($isArabic ?? false) ? 'اختر بوابتك المخصصة' : 'SELECT YOUR PORTAL' }}</span>
            </span>
        </div>

        <!-- Heading -->
        <h1 class="text-3xl sm:text-5xl font-black text-slate-900 tracking-tight mb-3">
            {{ ($isArabic ?? false) ? 'بوابة الشركات والمكاتب' : 'Companies & Offices Portal' }}
        </h1>
        <p class="text-sm sm:text-base text-slate-500 font-semibold mb-12">
            {{ ($isArabic ?? false) ? 'يرجى اختيار البوابة المناسبة للمتابعة.' : 'Please select the appropriate portal to continue.' }}
        </p>

        <!-- 2 Large Selection Cards -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }}">
            
            <!-- Card 1: Employer Dashboard Portal -->
            <div class="rounded-3xl border border-blue-200/70 p-8 sm:p-10 flex flex-col justify-between space-y-6 transition hover:shadow-card bg-gradient-to-br from-white via-white to-blue-50/50 shadow-soft">
                <div class="space-y-4">
                    <span class="text-[11px] font-black text-blue-600 uppercase tracking-widest block">
                        {{ ($isArabic ?? false) ? 'للشركات وأصحاب الأعمال ومسؤولي التوظيف' : 'FOR COMPANIES & RECRUITERS' }}
                    </span>
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 rounded-2xl bg-blue-100 text-blue-600 flex items-center justify-center text-xl shrink-0">
                            <i class="fa-solid fa-building"></i>
                        </div>
                        <h2 class="text-xl font-black text-slate-900">
                            {{ ($isArabic ?? false) ? 'لوحة تحكم أصحاب الأعمال' : 'Employer Dashboard Portal' }}
                        </h2>
                    </div>
                    <p class="text-xs sm:text-sm text-slate-500 font-semibold leading-relaxed">
                        {{ ($isArabic ?? false) ? 'استقطب أفضل الكفاءات، واستعرض السير الذاتية، وتواصل مباشرة مع المرشحين داخل أو خارج الكويت.' : 'Recruit top talent, browse applicant CVs, and connect directly with candidates inside or outside Kuwait.' }}
                    </p>
                </div>

                <div class="pt-4 space-y-2">
                    <a href="{{ route('employer.login') }}" 
                       class="w-full py-4 px-6 rounded-2xl bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-black text-sm flex items-center justify-center gap-2 shadow-md shadow-blue-500/25 transition">
                        <span>{{ ($isArabic ?? false) ? 'الدخول إلى بوابة أصحاب الأعمال' : 'Enter Employer Portal' }}</span>
                        <i class="fa-solid fa-arrow-right text-xs {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
                    </a>
                    <div class="text-center">
                        <a href="{{ route('employer.register') }}" class="text-xs font-bold text-blue-600 hover:text-blue-800">
                            {{ ($isArabic ?? false) ? 'تسجيل شركة جديدة' : 'Register New Company →' }}
                        </a>
                    </div>
                </div>
            </div>

            <!-- Card 2: Typing & Affiliate Offices Portal -->
            <div class="rounded-3xl border border-blue-200/70 p-8 sm:p-10 flex flex-col justify-between space-y-6 transition hover:shadow-card bg-gradient-to-br from-white via-white to-blue-50/50 shadow-soft">
                <div class="space-y-4">
                    <span class="text-[11px] font-black text-blue-600 uppercase tracking-widest block">
                        {{ ($isArabic ?? false) ? 'لمكاتب الطباعة والخدمات المعتمدة' : 'FOR AUTHORIZED TYPING OFFICES' }}
                    </span>
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 rounded-2xl bg-blue-100 text-blue-600 flex items-center justify-center text-xl shrink-0">
                            <i class="fa-solid fa-print"></i>
                        </div>
                        <h2 class="text-xl font-black text-slate-900">
                            {{ ($isArabic ?? false) ? 'بوابة مكاتب الطباعة المعتمدة' : 'Typing & Affiliate Offices Portal' }}
                        </h2>
                    </div>
                    <p class="text-xs sm:text-sm text-slate-500 font-semibold leading-relaxed">
                        {{ ($isArabic ?? false) ? 'لمساعدة الباحثين عن عمل وتسجيل ملفاتهم وإعلاناتهم وإيجاد فرص العمل المناسبة لهم.' : 'To help job seekers find suitable job opportunities and register their CV profiles.' }}
                    </p>
                </div>

                <div class="pt-4 space-y-2">
                    <a href="{{ route('affiliate.login') }}" 
                       class="w-full py-4 px-6 rounded-2xl border border-blue-200 bg-blue-50/60 hover:bg-blue-100 text-blue-800 font-black text-sm flex items-center justify-center gap-2 transition">
                        <span>{{ ($isArabic ?? false) ? 'الدخول إلى بوابة مكاتب الطباعة' : 'Enter Affiliate Office Portal' }}</span>
                        <i class="fa-solid fa-arrow-right text-xs {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
                    </a>
                    <div class="text-center">
                        <a href="{{ route('affiliate.register') }}" class="text-xs font-bold text-blue-600 hover:text-blue-800">
                            {{ ($isArabic ?? false) ? 'تسجيل مكتب طباعة جديد' : 'Register New Office →' }}
                        </a>
                    </div>
                </div>
            </div>

        </div>

    </main>

    <!-- Footer -->
    <footer class="py-6 px-4 text-center text-xs text-slate-400 font-semibold">
        © {{ date('Y') }} Direct Work. {{ ($isArabic ?? false) ? 'جميع الحقوق محفوظة.' : 'All rights reserved.' }}
    </footer>

</body>
</html>
