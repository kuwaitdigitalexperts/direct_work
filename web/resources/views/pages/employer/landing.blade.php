<!DOCTYPE html>
<html lang="{{ $currentLocale ?? 'en' }}" dir="{{ ($isArabic ?? false) ? 'rtl' : 'ltr' }}" class="h-full scroll-smooth">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ ($isArabic ?? false) ? 'بوابة أصحاب الأعمال | دايركت وورك' : 'Employer Portal | Direct Work' }}</title>
    
    <!-- Fonts & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: {{ ($isArabic ?? false) ? "'Cairo', sans-serif" : "'Plus Jakarta Sans', sans-serif" }};
            background: radial-gradient(circle at 50% 20%, #1e3a8a 0%, #0f172a 45%, #020617 100%);
            color: #ffffff;
        }
        .blue-glow {
            box-shadow: 0 0 50px -10px rgba(37, 99, 235, 0.4);
        }
        .mac-window {
            border-radius: 20px;
            background: rgba(15, 23, 42, 0.85);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(59, 130, 246, 0.25);
            box-shadow: 0 25px 60px -15px rgba(0, 0, 0, 0.8), 0 0 40px -10px rgba(37, 99, 235, 0.3);
        }
    </style>
</head>
<body class="min-h-full flex flex-col justify-between selection:bg-blue-600 selection:text-white">

    <!-- Top Navigation with Direct Work Logo -->
    <header class="py-6 px-4 sm:px-8 max-w-7xl mx-auto w-full flex items-center justify-between border-b border-blue-950/70">
        <a href="{{ route('home') }}" class="flex items-center gap-3">
            <img src="{{ asset('images/logo.png') }}" alt="Direct Work Logo" class="w-10 h-10 object-contain rounded-2xl shadow-sm">
            <span class="text-xl font-black text-white">
                {{ ($isArabic ?? false) ? 'دايركت وورك' : 'Direct Work' }}
            </span>
        </a>

        <div class="flex items-center gap-4">
            <a href="{{ route('login') }}" class="text-xs font-bold text-slate-300 hover:text-white transition">
                {{ ($isArabic ?? false) ? 'تسجيل الدخول' : 'Login' }}
            </a>
            <a href="{{ route('register', ['role' => 'company']) }}" 
               class="px-5 py-2.5 rounded-full bg-blue-600 hover:bg-blue-700 text-white font-extrabold text-xs shadow-md shadow-blue-600/30 transition transform hover:-translate-y-0.5">
                {{ ($isArabic ?? false) ? 'ابدأ الآن' : 'Get Started' }}
            </a>
            @if($isArabic ?? false)
                <a href="{{ route('locale.set', 'en') }}" class="px-3 py-1.5 rounded-full border border-blue-900 bg-blue-950/40 text-slate-300 text-xs font-bold hover:text-white transition">
                    EN
                </a>
            @else
                <a href="{{ route('locale.set', 'ar') }}" class="px-3 py-1.5 rounded-full border border-blue-900 bg-blue-950/40 text-slate-300 text-xs font-bold hover:text-white transition">
                    AR
                </a>
            @endif
        </div>
    </header>

    <!-- Main Content -->
    <main class="space-y-24 py-16">
        
        <!-- 1. HERO SECTION -->
        <section class="max-w-5xl mx-auto px-4 sm:px-6 text-center space-y-6">
            
            <!-- Live Badge -->
            <div>
                <span class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full border border-blue-800/80 bg-blue-950/60 text-blue-300 text-xs font-black tracking-widest uppercase">
                    <span class="w-2 h-2 rounded-full bg-blue-400 animate-pulse"></span>
                    <span>NOW LIVE — 10,000+ VERIFIED CANDIDATES V1.0</span>
                </span>
            </div>

            <!-- Giant Headline -->
            <h1 class="text-4xl sm:text-6xl lg:text-7xl font-black text-white tracking-tight leading-[1.12]">
                @if($isArabic ?? false)
                    موظفك القادم <br>
                    موجود بالفعل هنا.
                @else
                    Your Next Hire is <br>
                    Already Here.
                @endif
            </h1>

            <!-- Subtitle -->
            <p class="text-base sm:text-lg text-blue-100/80 font-medium leading-relaxed max-w-2xl mx-auto">
                @if($isArabic ?? false)
                    تصفح أكثر من 10,000 مرشح موثق عبر 27+ قطاعاً تخصصياً في الكويت. <br class="hidden sm:inline">
                    اختر كفاءاتك في دقائق، وليس أسابيع.
                @else
                    Browse 10,000+ verified candidates across 27+ sectors in Kuwait. <br class="hidden sm:inline">
                    Shortlist in minutes, not weeks.
                @endif
            </p>

            <!-- Buttons -->
            <div class="pt-4 flex flex-wrap items-center justify-center gap-4">
                <a href="{{ route('register', ['role' => 'company']) }}" 
                   class="px-8 py-4 rounded-full bg-blue-600 hover:bg-blue-700 text-white font-black text-sm shadow-xl shadow-blue-600/30 transition transform hover:-translate-y-0.5">
                    {{ ($isArabic ?? false) ? 'إنشاء حساب شركة مجاناً' : 'Get Started — It\'s Free' }}
                </a>
                <a href="{{ route('applicants.index') }}" 
                   class="px-8 py-4 rounded-full bg-white/10 hover:bg-white/15 text-white font-black text-sm border border-white/20 backdrop-blur transition">
                    {{ ($isArabic ?? false) ? 'تصفح المرشحين الآن' : 'Browse Candidates' }}
                </a>
            </div>

        </section>

        <!-- 2. REALISTIC MAC DASHBOARD MOCKUP WITH FLOATING BADGES -->
        <section class="max-w-6xl mx-auto px-4 sm:px-6 relative">
            
            <!-- Left Floating Badge: 634+ ACTIVE COMPANIES -->
            <div class="absolute -top-6 sm:top-12 left-2 sm:-left-4 z-20 px-5 py-4 rounded-2xl bg-slate-900/90 backdrop-blur-md border border-blue-500/40 text-left shadow-2xl animate-pulse">
                <div class="text-2xl sm:text-3xl font-black text-white">634+</div>
                <div class="text-[10px] sm:text-xs font-bold text-blue-400 uppercase tracking-widest mt-0.5">
                    ACTIVE COMPANIES
                </div>
            </div>

            <!-- Right Floating Badge: 10K+ VERIFIED APPLICANTS -->
            <div class="absolute -bottom-6 sm:bottom-12 right-2 sm:-right-4 z-20 px-5 py-4 rounded-2xl bg-slate-900/90 backdrop-blur-md border border-blue-500/40 text-left shadow-2xl animate-pulse">
                <div class="text-2xl sm:text-3xl font-black text-white">10K+</div>
                <div class="text-[10px] sm:text-xs font-bold text-blue-400 uppercase tracking-widest mt-0.5">
                    VERIFIED APPLICANTS
                </div>
            </div>

            <!-- Mac Window Frame -->
            <div class="mac-window overflow-hidden border border-blue-500/30">
                
                <!-- Window Header Bar with red, yellow, green controls -->
                <div class="px-4 py-3 bg-black/40 border-b border-blue-950/60 flex items-center justify-between">
                    <div class="flex items-center gap-2">
                        <span class="w-3 h-3 rounded-full bg-red-500 inline-block"></span>
                        <span class="w-3 h-3 rounded-full bg-yellow-500 inline-block"></span>
                        <span class="w-3 h-3 rounded-full bg-green-500 inline-block"></span>
                    </div>
                    
                    <div class="flex items-center gap-2 px-3 py-1 rounded-lg bg-white/5 border border-white/10 text-xs text-slate-400 w-64">
                        <i class="fa-solid fa-magnifying-glass text-[10px]"></i>
                        <span>Search candidates...</span>
                    </div>

                    <div class="flex items-center gap-3 text-slate-400 text-xs">
                        <i class="fa-regular fa-bell"></i>
                        <div class="w-6 h-6 rounded-full bg-blue-600 text-white flex items-center justify-center text-[10px] font-bold">HR</div>
                    </div>
                </div>

                <!-- Window Body: Dashboard View -->
                <div class="grid grid-cols-12 min-h-[420px]">
                    
                    <!-- Sidebar -->
                    <div class="col-span-3 bg-black/20 border-r border-blue-950/60 p-4 space-y-2 text-xs font-bold text-slate-400">
                        <a href="{{ route('employer') }}" class="flex items-center gap-2.5 px-3 py-2 rounded-xl bg-blue-600/20 text-blue-400 border border-blue-500/30">
                            <i class="fa-solid fa-table-cells-large"></i>
                            <span>Dashboard</span>
                        </a>
                        <a href="{{ route('applicants.index') }}" class="flex items-center gap-2.5 px-3 py-2 rounded-xl hover:bg-white/5 text-slate-300 transition">
                            <i class="fa-solid fa-users"></i>
                            <span>Candidates</span>
                        </a>
                        <a href="{{ route('jobs.create') }}" class="flex items-center gap-2.5 px-3 py-2 rounded-xl hover:bg-white/5 text-slate-300 transition">
                            <i class="fa-solid fa-briefcase"></i>
                            <span>Post Job</span>
                        </a>
                        <a href="{{ route('chats.index') }}" class="flex items-center gap-2.5 px-3 py-2 rounded-xl hover:bg-white/5 text-slate-300 transition">
                            <i class="fa-regular fa-comments"></i>
                            <span>Messages</span>
                        </a>
                    </div>

                    <!-- Main Dashboard Content Area -->
                    <div class="col-span-9 p-6 space-y-6">
                        <div class="flex items-center justify-between">
                            <div>
                                <span class="px-3 py-1 rounded-md bg-blue-500/20 text-xs font-bold text-blue-300 inline-block mb-1 border border-blue-500/30">
                                    Welcome back, HR
                                </span>
                                <p class="text-xs text-slate-400">Manage your active talent pipeline and candidates.</p>
                            </div>
                            <a href="{{ route('jobs.create') }}" class="px-4 py-2 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-bold text-xs shadow transition">
                                + Post New Vacancy
                            </a>
                        </div>

                        <!-- 3 Candidate Preview Cards -->
                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                            @foreach($sampleCandidates as $candidate)
                                <div class="p-3.5 rounded-2xl bg-white/5 border border-white/10 space-y-2.5 hover:border-blue-500/50 transition">
                                    <div class="flex items-center gap-2.5">
                                        <img src="{{ $candidate['photo_url'] ?? asset('images/default_avatar.png') }}" class="w-9 h-9 rounded-xl object-cover border border-white/10">
                                        <div class="min-w-0">
                                            <div class="text-xs font-black text-white truncate">{{ $candidate['name'] ?? 'Candidate' }}</div>
                                            <div class="text-[10px] text-blue-300 truncate">{{ $candidate['profession_en'] ?? $candidate['profession'] ?? 'Professional' }}</div>
                                        </div>
                                    </div>
                                    <div class="flex items-center justify-between text-[10px] text-slate-400 pt-1 border-t border-white/5">
                                        <span>{{ $candidate['experience_years'] ?? '5+' }} yrs exp</span>
                                        <a href="{{ route('applicants.show', $candidate['id']) }}" class="text-blue-400 hover:underline font-bold">View Profile</a>
                                    </div>
                                </div>
                            @endforeach
                        </div>

                        <!-- Recent Applicants Table Rows -->
                        <div class="rounded-2xl bg-white/5 border border-white/10 overflow-hidden text-xs">
                            <div class="px-4 py-2.5 bg-white/5 border-b border-white/5 font-bold text-slate-400 flex items-center justify-between">
                                <span>Recent Verified Job Seekers in Kuwait</span>
                                <a href="{{ route('applicants.index') }}" class="text-blue-400 hover:underline">View All ({{ $candidatesCount }}+)</a>
                            </div>
                            <div class="divide-y divide-white/5">
                                @foreach(array_slice($sampleCandidates, 0, 3) as $c)
                                    <div class="px-4 py-3 flex items-center justify-between">
                                        <div class="flex items-center gap-3">
                                            <div class="w-2 h-2 rounded-full bg-emerald-500"></div>
                                            <span class="font-bold text-white">{{ $c['name'] ?? 'Candidate' }}</span>
                                            <span class="text-slate-400">{{ $c['profession_en'] ?? $c['profession'] ?? 'Professional' }}</span>
                                        </div>
                                        <div class="flex items-center gap-3">
                                            <a href="https://wa.me/{{ preg_replace('/[^0-9]/', '', $c['phone'] ?? '96500000000') }}" target="_blank" class="text-emerald-400 hover:text-emerald-300 font-bold">
                                                <i class="fa-brands fa-whatsapp"></i> Chat
                                            </a>
                                            <a href="{{ route('applicants.show', $c['id']) }}" class="px-3 py-1 rounded-lg bg-blue-600/80 hover:bg-blue-600 text-white font-bold">
                                                Review CV
                                            </a>
                                        </div>
                                    </div>
                                @endforeach
                            </div>
                        </div>

                    </div>

                </div>

            </div>

        </section>

        <!-- 3. TRUSTED COMPANIES LOGO BAR -->
        <section class="max-w-5xl mx-auto px-4 sm:px-6 text-center space-y-6 pt-10">
            <span class="text-[11px] font-black text-blue-300 uppercase tracking-widest block">
                TRUSTED BY LEADING COMPANIES IN KUWAIT
            </span>

            <div class="flex flex-wrap items-center justify-center gap-8 sm:gap-12 opacity-80">
                <div class="flex items-center gap-2 font-black text-slate-200 text-sm">
                    <i class="fa-solid fa-shapes text-blue-400"></i> Vertex Inc
                </div>
                <div class="flex items-center gap-2 font-black text-slate-200 text-sm">
                    <i class="fa-solid fa-city text-blue-400"></i> Acme Corp
                </div>
                <div class="flex items-center gap-2 font-black text-slate-200 text-sm">
                    <i class="fa-solid fa-microchip text-blue-400"></i> Global Tech
                </div>
                <div class="flex items-center gap-2 font-black text-slate-200 text-sm">
                    <i class="fa-solid fa-layer-group text-blue-400"></i> Nexus Group
                </div>
                <div class="flex items-center gap-2 font-black text-slate-200 text-sm">
                    <i class="fa-solid fa-atom text-blue-400"></i> Aura Systems
                </div>
                <div class="flex items-center gap-2 font-black text-slate-200 text-sm">
                    <i class="fa-solid fa-dna text-blue-400"></i> Omni Labs
                </div>
            </div>
        </section>

        <!-- 4. HOW IT WORKS 01, 02, 03 -->
        <section class="max-w-5xl mx-auto px-4 sm:px-6 text-center space-y-12 pt-10">
            
            <div class="space-y-2">
                <span class="text-[11px] font-black text-blue-300 uppercase tracking-widest block">
                    BUILT FOR SERIOUS EMPLOYERS
                </span>
                <h2 class="text-3xl sm:text-5xl font-black text-white tracking-tight">
                    How It Works
                </h2>
                <p class="text-sm text-blue-100/70 font-medium">
                    From search to hire in three simple steps
                </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }}">
                
                <!-- Step 01 -->
                <div class="p-8 rounded-3xl bg-white/5 border border-white/10 space-y-4 hover:border-blue-500/50 transition relative">
                    <div class="relative w-12 h-12 rounded-2xl bg-blue-600/30 text-blue-400 flex items-center justify-center text-xl">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <span class="absolute -top-1.5 -right-1.5 w-5 h-5 rounded-full bg-blue-600 text-white font-black text-[9px] flex items-center justify-center">01</span>
                    </div>
                    <h3 class="text-lg font-black text-white">
                        Browse & Search
                    </h3>
                    <p class="text-xs text-slate-300 font-medium leading-relaxed">
                        Explore 27+ professional sectors and filter by nationality, experience, and availability.
                    </p>
                </div>

                <!-- Step 02 -->
                <div class="p-8 rounded-3xl bg-white/5 border border-white/10 space-y-4 hover:border-blue-500/50 transition relative">
                    <div class="relative w-12 h-12 rounded-2xl bg-blue-600/30 text-blue-400 flex items-center justify-center text-xl">
                        <i class="fa-regular fa-bookmark"></i>
                        <span class="absolute -top-1.5 -right-1.5 w-5 h-5 rounded-full bg-blue-600 text-white font-black text-[9px] flex items-center justify-center">02</span>
                    </div>
                    <h3 class="text-lg font-black text-white">
                        Shortlist & Save
                    </h3>
                    <p class="text-xs text-slate-300 font-medium leading-relaxed">
                        Save your top candidates to a personal shortlist with one click. Compare and review anytime.
                    </p>
                </div>

                <!-- Step 03 -->
                <div class="p-8 rounded-3xl bg-white/5 border border-white/10 space-y-4 hover:border-blue-500/50 transition relative">
                    <div class="relative w-12 h-12 rounded-2xl bg-blue-600/30 text-blue-400 flex items-center justify-center text-xl">
                        <i class="fa-solid fa-phone"></i>
                        <span class="absolute -top-1.5 -right-1.5 w-5 h-5 rounded-full bg-blue-600 text-white font-black text-[9px] flex items-center justify-center">03</span>
                    </div>
                    <h3 class="text-lg font-black text-white">
                        Contact & Hire
                    </h3>
                    <p class="text-xs text-slate-300 font-medium leading-relaxed">
                        Access direct contact details for your shortlisted applicants and start hiring immediately.
                    </p>
                </div>

            </div>

        </section>

        <!-- 5. READY TO FIND YOUR NEXT HIRE? BOTTOM CTA -->
        <section class="max-w-5xl mx-auto px-4 sm:px-6">
            <div class="rounded-[40px] bg-gradient-to-b from-blue-950/80 via-slate-900 to-black p-10 sm:p-16 text-center space-y-6 border border-blue-500/40 blue-glow">
                
                <h2 class="text-3xl sm:text-5xl font-black text-white tracking-tight">
                    Ready to find your next hire?
                </h2>
                <p class="text-sm sm:text-base text-blue-200/80 font-medium max-w-lg mx-auto">
                    Join 634+ companies already using Direct Work to build their teams in Kuwait.
                </p>

                <div class="pt-4">
                    <a href="{{ route('register', ['role' => 'company']) }}" 
                       class="inline-flex items-center gap-2 px-8 py-4 rounded-full bg-blue-600 hover:bg-blue-700 text-white font-black text-sm shadow-xl shadow-blue-600/40 transition transform hover:-translate-y-0.5">
                        <span>Get Started — It's Free</span>
                        <i class="fa-solid fa-arrow-right text-xs {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
                    </a>
                </div>

            </div>
        </section>

    </main>

    <!-- Dark Luxury Footer -->
    <footer class="border-t border-blue-950/70 pt-16 pb-12 text-xs text-slate-400">
        <div class="max-w-7xl mx-auto px-4 sm:px-8">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-10 pb-12 border-b border-blue-950/60">
                
                <div class="space-y-3">
                    <div class="flex items-center gap-2">
                        <img src="{{ asset('images/logo.png') }}" alt="Direct Work Logo" class="w-8 h-8 object-contain rounded-xl">
                        <span class="text-base font-black text-white">Direct Work</span>
                    </div>
                    <p class="text-slate-400 leading-relaxed">
                        Kuwait's largest employer-to-applicant direct hiring platform.
                    </p>
                </div>

                <div class="space-y-3">
                    <h4 class="font-black text-white uppercase tracking-wider text-[11px]">PLATFORM</h4>
                    <ul class="space-y-2 font-bold text-slate-300">
                        <li><a href="{{ route('applicants.index') }}" class="hover:text-blue-400 transition">Browse Candidates</a></li>
                        <li><a href="{{ route('login') }}" class="hover:text-blue-400 transition">Employer Login</a></li>
                        <li><a href="{{ route('register', ['role' => 'company']) }}" class="hover:text-blue-400 transition">Get Started</a></li>
                    </ul>
                </div>

                <div class="space-y-3">
                    <h4 class="font-black text-white uppercase tracking-wider text-[11px]">COMPANY</h4>
                    <ul class="space-y-2 font-bold text-slate-300">
                        <li><a href="{{ route('home') }}" class="hover:text-blue-400 transition">About Us</a></li>
                        <li><a href="{{ route('support') }}" class="hover:text-blue-400 transition">Contact</a></li>
                    </ul>
                </div>

                <div class="space-y-3">
                    <h4 class="font-black text-white uppercase tracking-wider text-[11px]">LEGAL</h4>
                    <ul class="space-y-2 font-bold text-slate-300">
                        <li><a href="#" class="hover:text-blue-400 transition">Privacy Policy</a></li>
                        <li><a href="#" class="hover:text-blue-400 transition">Terms of Service</a></li>
                    </ul>
                </div>

            </div>

            <div class="pt-8 text-center text-slate-500 font-semibold">
                © {{ date('Y') }} Direct Work. All rights reserved.
            </div>
        </div>
    </footer>

</body>
</html>
