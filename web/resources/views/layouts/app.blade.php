<!DOCTYPE html>
<html lang="{{ $currentLocale ?? 'en' }}" dir="{{ ($isArabic ?? false) ? 'rtl' : 'ltr' }}" class="h-full scroll-smooth">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>@yield('title', 'Direct Work | ' . ($activeCountry['name_en'] ?? 'Kuwait') . "'s #1 Direct Hiring Platform")</title>
    <meta name="description" content="Direct Work is the premier direct employment platform in Kuwait, Saudi Arabia, and UAE. Connect directly with verified candidates and companies without middlemen.">

    <!-- Fonts: Plus Jakarta Sans & Cairo -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

    <!-- FontAwesome 6 Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50: '#eff6ff',
                            100: '#dbeafe',
                            200: '#bfdbfe',
                            500: '#3b82f6',
                            600: '#2563eb',
                            700: '#1d4ed8',
                            800: '#1e40af',
                            900: '#1e3a8a',
                        },
                        accent: {
                            gold: '#f59e0b',
                            amber: '#d97706',
                            green: '#16a34a',
                            orange: '#ea580c',
                        }
                    },
                    fontFamily: {
                        sans: {{ ($isArabic ?? false) ? "['Cairo', 'sans-serif']" : "['Plus Jakarta Sans', 'Cairo', 'sans-serif']" }},
                    },
                    boxShadow: {
                        'soft': '0 4px 20px -2px rgba(0, 0, 0, 0.05)',
                        'card': '0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.01)',
                        'floating': '0 20px 35px -10px rgba(0, 0, 0, 0.12)',
                        'glow': '0 0 25px -5px rgba(29, 78, 216, 0.35)',
                    }
                }
            }
        }
    </script>

    <style>
        body {
            font-family: {{ ($isArabic ?? false) ? "'Cairo', sans-serif" : "'Plus Jakarta Sans', sans-serif" }};
            background-color: #F8FAFC;
        }
        .phone-frame {
            border-radius: 48px;
            box-shadow: 0 25px 60px -15px rgba(15, 23, 42, 0.28), 0 0 0 10px #0f172a, 0 0 0 12px #1e293b;
            background: #ffffff;
            position: relative;
            overflow: hidden;
        }
        .dynamic-island {
            width: 90px;
            height: 22px;
            background-color: #000000;
            border-radius: 20px;
            position: absolute;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 30;
        }
        .glass-badge {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.85);
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.08);
        }
        .no-scrollbar::-webkit-scrollbar {
            display: none;
        }
        .no-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
    </style>
    @stack('styles')
</head>
<body class="min-h-full flex flex-col text-slate-900 antialiased selection:bg-blue-600 selection:text-white">

    <!-- Top Navigation Header with Direct Work Logo & Theme -->
    <header class="sticky top-0 z-50 bg-white/95 backdrop-blur-md border-b border-slate-100 transition shadow-xs">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-20">
                
                <!-- Brand Logo using Created Logo File -->
                <div class="flex items-center gap-3">
                    <a href="{{ route('home') }}" class="flex items-center gap-3 group">
                        <img src="{{ asset('images/logo.png') }}" 
                             alt="Direct Work Logo" 
                             class="w-11 h-11 object-contain rounded-2xl shadow-sm group-hover:scale-105 transition transform">
                        <div class="flex flex-col">
                            <span class="text-xl font-black text-slate-900 tracking-tight leading-none group-hover:text-blue-600 transition">
                                {{ ($isArabic ?? false) ? 'دايركت وورك' : 'DIRECT WORK' }}
                            </span>
                            <span class="text-[10px] font-bold text-blue-600 uppercase tracking-widest mt-0.5">
                                {{ ($isArabic ?? false) ? $activeCountry['name_ar'] : $activeCountry['name_en'] }}
                            </span>
                        </div>
                    </a>
                </div>

                <!-- Center Pill Menu: How It Works, FAQ, Support -->
                <nav class="hidden lg:flex items-center p-1.5 bg-slate-50 border border-slate-200/80 rounded-full shadow-xs text-xs font-bold text-slate-600">
                    <a href="{{ route('home') }}#how-it-works" class="px-4 py-2 rounded-full hover:bg-white hover:text-blue-600 hover:shadow-xs transition flex items-center gap-1.5">
                        <span class="text-blue-600">✨</span>
                        <span>{{ ($isArabic ?? false) ? 'كيف يعمل' : 'How It Works' }}</span>
                    </a>
                    <a href="{{ route('home') }}#faq" class="px-4 py-2 rounded-full hover:bg-white hover:text-blue-600 hover:shadow-xs transition flex items-center gap-1.5">
                        <span class="text-blue-600">❓</span>
                        <span>{{ ($isArabic ?? false) ? 'الأسئلة الشائعة' : 'FAQ' }}</span>
                    </a>
                    <a href="{{ route('support') }}" class="px-4 py-2 rounded-full hover:bg-white hover:text-blue-600 hover:shadow-xs transition flex items-center gap-1.5">
                        <span class="text-blue-600">🎧</span>
                        <span>{{ ($isArabic ?? false) ? 'الدعم الفني' : 'Support' }}</span>
                    </a>
                </nav>

                <!-- Right Actions: Portal Button, Download App, Country & Locale -->
                <div class="flex items-center gap-2.5 sm:gap-3">
                    
                    <!-- Country Switcher Dropdown -->
                    <div class="relative group">
                        <button class="inline-flex items-center gap-1.5 px-3 py-2 rounded-xl text-xs font-bold bg-slate-100 hover:bg-slate-200 text-slate-700 transition">
                            <span class="text-sm">{{ $activeCountry['flag'] ?? '🇰🇼' }}</span>
                            <span class="hidden sm:inline">{{ ($isArabic ?? false) ? $activeCountry['short_name_ar'] : $activeCountry['short_name_en'] }}</span>
                            <i class="fa-solid fa-chevron-down text-[10px] text-slate-400"></i>
                        </button>
                        <div class="absolute {{ ($isArabic ?? false) ? 'left-0' : 'right-0' }} mt-2 w-48 bg-white rounded-2xl shadow-xl border border-slate-100 p-1.5 hidden group-hover:block transition z-50">
                            @foreach($allCountries as $code => $country)
                                <a href="{{ route('country.set', $code) }}" 
                                   class="flex items-center justify-between px-3 py-2 rounded-xl text-xs font-bold transition {{ ($activeCountry['id'] ?? 'kw') === $code ? 'bg-blue-50 text-blue-600' : 'text-slate-700 hover:bg-slate-50' }}">
                                    <span class="flex items-center gap-2">
                                        <span>{{ $country['flag'] }}</span>
                                        <span>{{ ($isArabic ?? false) ? $country['name_ar'] : $country['name_en'] }}</span>
                                    </span>
                                    <span class="text-[10px] text-slate-400">{{ $country['currency_en'] }}</span>
                                </a>
                            @endforeach
                        </div>
                    </div>

                    <!-- Portals & Authentication Actions -->
                    @if(session('auth_user'))
                        @php $authUser = session('auth_user'); @endphp
                        <div class="flex items-center gap-2">
                            @if(($authUser['role'] ?? '') === 'company')
                                <a href="{{ route('employer') }}" 
                                   class="inline-flex items-center gap-2 px-3 sm:px-4 py-2 rounded-full border border-blue-200 bg-blue-50 text-blue-700 text-xs font-bold transition hover:bg-blue-100">
                                    <i class="fa-solid fa-building text-blue-600"></i>
                                    <span class="max-w-[120px] truncate">{{ $authUser['company_name'] ?? $authUser['full_name'] ?? 'Employer' }}</span>
                                </a>
                            @else
                                <a href="{{ route('offices') }}" 
                                   class="inline-flex items-center gap-2 px-3 sm:px-4 py-2 rounded-full border border-blue-200 bg-blue-50 text-blue-700 text-xs font-bold transition hover:bg-blue-100">
                                    <i class="fa-solid fa-print text-blue-600"></i>
                                    <span class="max-w-[120px] truncate">{{ $authUser['office_name'] ?? $authUser['full_name'] ?? 'Office' }}</span>
                                </a>
                            @endif

                            <form action="{{ route('logout') }}" method="POST" class="inline">
                                @csrf
                                <button type="submit" 
                                        class="p-2 rounded-full text-slate-400 hover:text-red-600 hover:bg-red-50 transition" 
                                        title="{{ ($isArabic ?? false) ? 'تسجيل الخروج' : 'Sign Out' }}">
                                    <i class="fa-solid fa-arrow-right-from-bracket text-xs"></i>
                                </button>
                            </form>
                        </div>
                    @else
                        <!-- Companies & Offices Portal Link -->
                        <a href="{{ route('portals') }}" 
                           class="hidden md:inline-flex items-center gap-2 px-3.5 py-2 rounded-full border border-slate-200 bg-slate-50 hover:bg-slate-100 text-slate-700 text-xs font-bold transition">
                            <i class="fa-regular fa-building text-blue-600"></i>
                            <span>{{ ($isArabic ?? false) ? 'البوابات' : 'Portals' }}</span>
                        </a>

                        <!-- Employer Sign In -->
                        <a href="{{ route('employer.login') }}" 
                           class="hidden sm:inline-flex items-center gap-1.5 px-3.5 py-2 rounded-full text-slate-700 hover:text-blue-600 text-xs font-bold transition">
                            <i class="fa-solid fa-arrow-right-to-bracket text-blue-600 text-[11px]"></i>
                            <span>{{ ($isArabic ?? false) ? 'دخول الشركات' : 'Employer Login' }}</span>
                        </a>

                        <!-- Register Company CTA Button -->
                        <a href="{{ route('employer.register') }}" 
                           class="inline-flex items-center gap-1.5 px-4 py-2 rounded-full bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white text-xs font-black shadow-sm shadow-blue-500/25 transition">
                            <i class="fa-solid fa-user-plus text-[10px]"></i>
                            <span>{{ ($isArabic ?? false) ? 'تسجيل شركة' : 'Register' }}</span>
                        </a>
                    @endif

                    <!-- Language Switcher Pill -->
                    <div class="p-1 bg-slate-100 rounded-full text-[11px] font-black flex items-center">
                        @if($isArabic ?? false)
                            <a href="{{ route('locale.set', 'en') }}" class="px-2.5 py-1 rounded-full text-slate-600 hover:text-slate-900 transition">
                                EN
                            </a>
                            <span class="px-2.5 py-1 rounded-full bg-white shadow-xs text-blue-600 font-extrabold">
                                العربية
                            </span>
                        @else
                            <span class="px-2.5 py-1 rounded-full bg-white shadow-xs text-blue-600 font-extrabold">
                                EN
                            </span>
                            <a href="{{ route('locale.set', 'ar') }}" class="px-2.5 py-1 rounded-full text-slate-600 hover:text-slate-900 transition">
                                العربية
                            </a>
                        @endif
                    </div>

                </div>

            </div>
        </div>
    </header>

    <!-- Main Content Slot -->
    <main class="flex-grow">
        @yield('content')
    </main>

    <!-- Professional Footer matching Direct Work Theme -->
    <footer class="bg-white border-t border-slate-200/80 pt-16 pb-12 mt-20 text-xs">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-12 pb-12 border-b border-slate-100">
                
                <!-- Col 1: Brand Info -->
                <div class="space-y-4">
                    <div class="flex items-center gap-3">
                        <img src="{{ asset('images/logo.png') }}" alt="Direct Work Logo" class="w-10 h-10 object-contain rounded-2xl shadow-sm">
                        <span class="text-lg font-black text-slate-900">
                            {{ ($isArabic ?? false) ? 'دايركت وورك' : 'Direct Work' }}
                        </span>
                    </div>
                    <p class="text-slate-500 font-semibold leading-relaxed">
                        {{ ($isArabic ?? false) ? 'انطلق نحو وظيفتك القادمة. احصل على الظهور الكامل أمام كبرى الشركات مباشرة بدون وسيط.' : 'Get Seen. Move Forward. Discover direct employment opportunities without middlemen.' }}
                    </p>
                    <div>
                        <span class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-blue-50 border border-blue-200/80 text-blue-700 font-bold text-[11px]">
                            <span class="w-2 h-2 rounded-full bg-blue-600 animate-pulse"></span>
                            {{ ($isArabic ?? false) ? 'صُمم وطُوّر في الكويت' : 'Designed & Engineered in Kuwait' }}
                        </span>
                    </div>
                </div>

                <!-- Col 2: Company Links -->
                <div class="space-y-3">
                    <h4 class="font-black text-slate-900 uppercase tracking-wider text-[11px]">
                        {{ ($isArabic ?? false) ? 'الشركة' : 'COMPANY' }}
                    </h4>
                    <ul class="space-y-2.5 font-bold text-slate-600">
                        <li>
                            <a href="{{ route('support') }}" class="hover:text-blue-600 transition">
                                {{ ($isArabic ?? false) ? 'اتصل بنا' : 'Contact Us' }}
                            </a>
                        </li>
                        <li>
                            <a href="#" class="hover:text-blue-600 transition">
                                {{ ($isArabic ?? false) ? 'سياسة الخصوصية' : 'Privacy Policy' }}
                            </a>
                        </li>
                        <li>
                            <a href="#" class="hover:text-blue-600 transition">
                                {{ ($isArabic ?? false) ? 'الشروط والأحكام' : 'Terms & Conditions' }}
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- Col 3: Stay Connected & Portal -->
                <div class="space-y-4">
                    <h4 class="font-black text-slate-900 uppercase tracking-wider text-[11px]">
                        {{ ($isArabic ?? false) ? 'ابقَ على تواصل' : 'STAY CONNECTED' }}
                    </h4>
                    <!-- Social Icons -->
                    <div class="flex items-center gap-2.5">
                        <a href="https://instagram.com" target="_blank" class="w-9 h-9 rounded-xl bg-slate-100 hover:bg-blue-50 hover:text-blue-600 text-slate-600 flex items-center justify-center transition border border-slate-200/80">
                            <i class="fa-brands fa-instagram text-sm"></i>
                        </a>
                        <a href="https://facebook.com" target="_blank" class="w-9 h-9 rounded-xl bg-slate-100 hover:bg-blue-50 hover:text-blue-600 text-slate-600 flex items-center justify-center transition border border-slate-200/80">
                            <i class="fa-brands fa-facebook-f text-sm"></i>
                        </a>
                        <a href="https://linkedin.com" target="_blank" class="w-9 h-9 rounded-xl bg-slate-100 hover:bg-blue-50 hover:text-blue-600 text-slate-600 flex items-center justify-center transition border border-slate-200/80">
                            <i class="fa-brands fa-linkedin-in text-sm"></i>
                        </a>
                        <a href="https://youtube.com" target="_blank" class="w-9 h-9 rounded-xl bg-slate-100 hover:bg-blue-50 hover:text-blue-600 text-slate-600 flex items-center justify-center transition border border-slate-200/80">
                            <i class="fa-brands fa-youtube text-sm"></i>
                        </a>
                    </div>
                    <!-- Companies Portal Outline Button -->
                    <div>
                        <a href="{{ route('portals') }}" class="inline-flex items-center gap-2 px-5 py-2.5 rounded-full border border-blue-200 bg-blue-50/70 hover:bg-blue-100 text-blue-700 font-bold text-xs transition">
                            <i class="fa-regular fa-building text-blue-600"></i>
                            <span>{{ ($isArabic ?? false) ? 'بوابة الشركات والمكاتب' : 'Companies & Offices Portal' }}</span>
                        </a>
                    </div>
                </div>

            </div>

            <div class="pt-8 flex flex-col sm:flex-row items-center justify-between text-slate-400 text-[11px] font-semibold gap-4">
                <div>
                    © {{ date('Y') }} {{ ($isArabic ?? false) ? 'دايركت وورك. جميع الحقوق محفوظة.' : 'Direct Work. All rights reserved.' }}
                </div>
                <div class="flex items-center gap-4">
                    <span>{{ ($isArabic ?? false) ? 'الكويت • السعودية • الإمارات' : 'Kuwait • Saudi Arabia • UAE' }}</span>
                </div>
            </div>
        </div>
    </footer>

    <!-- Sticky Bottom Bar using Direct Work Logo & Theme -->
    <div id="stickyDownloadBar" class="fixed bottom-0 inset-x-0 z-40 bg-white/95 backdrop-blur-md border-t border-slate-200 shadow-2xl py-3 px-4 transition transform">
        <div class="max-w-7xl mx-auto flex items-center justify-between gap-4">
            
            <!-- Left Info -->
            <div class="flex items-center gap-3 min-w-0">
                <img src="{{ asset('images/logo.png') }}" alt="Direct Work Logo" class="w-10 h-10 object-contain rounded-2xl shrink-0 shadow-sm">
                <div class="min-w-0">
                    <h5 class="text-xs sm:text-sm font-black text-slate-900 truncate">
                        {{ ($isArabic ?? false) ? 'دايركت وورك – احصل على الظهور. انطلق نحو الأمام.' : 'Direct Work – Get Seen. Move Forward.' }}
                    </h5>
                    <p class="text-[11px] text-slate-500 font-medium truncate hidden sm:block">
                        {{ ($isArabic ?? false) ? 'حمل التطبيق الآن واجعل كبرى الشركات تكتشف ملفك فوراً.' : 'Download the app and get discovered by employers.' }}
                    </p>
                </div>
            </div>

            <!-- Right App Buttons and Close -->
            <div class="flex items-center gap-2 sm:gap-3 shrink-0">
                <a href="https://apple.com" target="_blank" rel="noopener noreferrer" 
                   class="inline-flex items-center gap-2 px-3 sm:px-4 py-2 rounded-xl bg-slate-900 hover:bg-black text-white text-xs font-bold transition">
                    <i class="fa-brands fa-apple text-base"></i>
                    <span class="hidden md:inline text-[10px] leading-tight text-left">
                        <span class="block text-[8px] text-slate-400 font-normal">Download on the</span>
                        App Store
                    </span>
                </a>
                <a href="https://google.com" target="_blank" rel="noopener noreferrer" 
                   class="inline-flex items-center gap-2 px-3 sm:px-4 py-2 rounded-xl bg-slate-900 hover:bg-black text-white text-xs font-bold transition">
                    <i class="fa-brands fa-google-play text-base text-amber-400"></i>
                    <span class="hidden md:inline text-[10px] leading-tight text-left">
                        <span class="block text-[8px] text-slate-400 font-normal">GET IT ON</span>
                        Google Play
                    </span>
                </a>
                <button type="button" onclick="document.getElementById('stickyDownloadBar').remove()" 
                        class="p-2 text-slate-400 hover:text-slate-700 transition" title="Close">
                    <i class="fa-solid fa-xmark text-sm"></i>
                </button>
            </div>

        </div>
    </div>

    @stack('scripts')
</body>
</html>
