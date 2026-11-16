@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'دايركت وورك | المنصة الأولى للتوظيف المباشر في الكويت والخليج' : "Direct Work | Kuwait's #1 Direct Hiring App")

@section('content')
<div class="space-y-20 lg:space-y-28 overflow-hidden">

    <!-- 1. HERO SECTION (Direct Work Royal Blue Theme) -->
    <section class="relative pt-8 sm:pt-14 pb-12 sm:pb-20 overflow-hidden">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 lg:gap-8 items-center">
                
                <!-- Left Column: Copy & Download Card -->
                <div class="lg:col-span-7 space-y-6 sm:space-y-7 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }}">
                    
                    <!-- Pill Tag -->
                    <div>
                        <span class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-blue-50 border border-blue-200/80 text-blue-700 text-xs font-black tracking-wide uppercase shadow-xs">
                            <span class="text-blue-600">✨</span>
                            <span>{{ ($isArabic ?? false) ? 'تطبيق التوظيف المباشر رقم 1 في ' . $activeCountry['name_ar'] : ($activeCountry['name_en'] ?? 'KUWAIT') . "'S #1 DIRECT HIRING APP" }}</span>
                        </span>
                    </div>

                    <!-- Giant Headline -->
                    <h1 class="text-4xl sm:text-5xl lg:text-6xl font-black text-slate-900 tracking-tight leading-[1.12]">
                        @if($isArabic ?? false)
                            اجعل كبرى الشركات <br>
                            تكتشفك في <span class="text-blue-600">دول الخليج</span>
                        @else
                            Get seen by employers <br>
                            in <span class="text-blue-600 underline decoration-blue-300 decoration-wavy decoration-2">GCC</span>
                        @endif
                    </h1>

                    <!-- Subtitle -->
                    <p class="text-base sm:text-lg text-slate-600 font-medium leading-relaxed max-w-xl">
                        @if($isArabic ?? false)
                            أنشئ ملفك المهني، وارفع سيرتك الذاتية (CV)، واجعل الشركات في {{ $activeCountry['short_name_ar'] }} تكتشفك وتتواصل معك مباشرة بدون وسطاء وبدون انتظار.
                        @else
                            Create your profile, upload your CV, and let companies in {{ $activeCountry['name_en'] ?? 'Kuwait' }} discover you directly. No middlemen, no recruiters, no endless waiting.
                        @endif
                    </p>

                    <!-- QR Code & App Stores Card -->
                    <div id="download" class="inline-flex flex-col sm:flex-row items-center gap-5 p-4 sm:p-5 rounded-3xl bg-white border border-slate-200 shadow-card">
                        <!-- QR Code Box -->
                        <div class="flex items-center gap-3.5 pr-0 sm:pr-5 {{ ($isArabic ?? false) ? 'sm:border-l sm:pl-5 sm:pr-0' : 'sm:border-r' }} border-slate-200">
                            <img src="{{ asset('images/qr_code.svg') }}" alt="QR Code" class="w-16 h-16 rounded-xl border border-slate-100 shadow-xs">
                            <div class="text-left {{ ($isArabic ?? false) ? 'text-right' : '' }}">
                                <span class="block text-[11px] font-black text-slate-900 tracking-wider uppercase">
                                    {{ ($isArabic ?? false) ? 'امسح للتحميل' : 'SCAN TO DOWNLOAD' }}
                                </span>
                                <span class="text-[10px] text-slate-400 font-semibold block leading-tight mt-0.5">
                                    {{ ($isArabic ?? false) ? 'وجّه كاميرا هاتفك' : 'Point camera to scan' }}
                                </span>
                            </div>
                        </div>

                        <!-- Store Badges -->
                        <div class="space-y-1.5 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }}">
                            <span class="text-[9px] font-black text-slate-400 tracking-widest uppercase block">
                                {{ ($isArabic ?? false) ? 'متوفر على' : 'AVAILABLE ON' }}
                            </span>
                            <div class="flex items-center gap-2">
                                <a href="https://apple.com" target="_blank" rel="noopener noreferrer" 
                                   class="inline-flex items-center gap-2 px-3 py-2 rounded-xl bg-slate-900 hover:bg-black text-white transition shadow-sm">
                                    <i class="fa-brands fa-apple text-xl"></i>
                                    <span class="text-left leading-none">
                                        <span class="block text-[8px] text-slate-400 font-medium">Download on the</span>
                                        <span class="text-[11px] font-bold">App Store</span>
                                    </span>
                                </a>
                                <a href="https://google.com" target="_blank" rel="noopener noreferrer" 
                                   class="inline-flex items-center gap-2 px-3 py-2 rounded-xl bg-slate-900 hover:bg-black text-white transition shadow-sm">
                                    <i class="fa-brands fa-google-play text-lg text-amber-400"></i>
                                    <span class="text-left leading-none">
                                        <span class="block text-[8px] text-slate-400 font-medium">GET IT ON</span>
                                        <span class="text-[11px] font-bold">Google Play</span>
                                    </span>
                                </a>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Right Column: Realistic 3D Phone Mockup with Floating Badges -->
                <div class="lg:col-span-5 flex justify-center lg:justify-end relative">
                    
                    <!-- Floating Badge 1: Top Left "Viewed by Employer" -->
                    <div class="absolute -top-4 sm:top-8 left-2 sm:-left-8 z-30 glass-badge px-3.5 py-2.5 rounded-2xl flex items-center gap-3 animate-bounce shadow-floating">
                        <div class="w-8 h-8 rounded-xl bg-blue-100 text-blue-600 flex items-center justify-center font-bold text-sm">
                            <i class="fa-regular fa-eye"></i>
                        </div>
                        <div class="text-left">
                            <div class="text-xs font-black text-slate-900">
                                {{ ($isArabic ?? false) ? 'شاهده صاحب عمل' : 'Viewed by Employer' }}
                            </div>
                            <div class="text-[10px] text-slate-400 font-semibold">2m ago</div>
                        </div>
                    </div>

                    <!-- Floating Badge 2: Right "Engineering" -->
                    <div class="absolute top-1/2 -right-4 sm:-right-6 z-30 glass-badge px-3.5 py-2 rounded-2xl flex items-center gap-2 shadow-floating">
                        <div class="w-6 h-6 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center text-xs">
                            <i class="fa-solid fa-gear"></i>
                        </div>
                        <span class="text-xs font-black text-slate-900">
                            {{ ($isArabic ?? false) ? 'الهندسة والمشاريع' : 'Engineering' }}
                        </span>
                    </div>

                    <!-- Floating Badge 3: Bottom Right "Interview Request" -->
                    <div class="absolute bottom-6 sm:bottom-12 -left-2 sm:-left-6 z-30 glass-badge px-3.5 py-2.5 rounded-2xl flex items-center gap-3 shadow-floating">
                        <div class="w-8 h-8 rounded-xl bg-emerald-100 text-emerald-600 flex items-center justify-center font-bold text-sm">
                            <i class="fa-regular fa-calendar-check"></i>
                        </div>
                        <div class="text-left">
                            <div class="text-xs font-black text-slate-900">
                                {{ ($isArabic ?? false) ? 'طلب مقابلة عمل' : 'Interview Request' }}
                            </div>
                            <div class="text-[10px] text-emerald-600 font-bold">New Notification</div>
                        </div>
                    </div>

                    <!-- Realistic iPhone Bezel Frame with Authentic Direct Work App UI (Royal Blue Theme) -->
                    <div class="w-[280px] sm:w-[310px] h-[570px] sm:h-[620px] phone-frame relative border-4 border-slate-900 overflow-hidden shadow-2xl bg-white flex flex-col justify-between text-left select-none pointer-events-none">
                        <!-- Dynamic Island -->
                        <div class="dynamic-island"></div>

                        <!-- Top Status Bar -->
                        <div class="pt-2 px-6 flex items-center justify-between text-[11px] font-black text-slate-800 z-20">
                            <span>9:41</span>
                            <div class="flex items-center gap-1.5 text-[10px]">
                                <i class="fa-solid fa-signal"></i>
                                <i class="fa-solid fa-wifi"></i>
                                <i class="fa-solid fa-battery-full text-slate-900"></i>
                            </div>
                        </div>

                        <!-- Phone Scrollable Body -->
                        <div class="flex-1 overflow-hidden px-3 pt-2 pb-1 flex flex-col justify-between">
                            
                            <!-- App Header & Country Switcher -->
                            <div class="flex items-center justify-between pb-1.5 border-b border-slate-100">
                                <div class="flex items-center gap-1.5">
                                    <div class="w-7 h-7 rounded-full bg-slate-100 flex items-center justify-center text-xs shadow-xs border border-slate-200">
                                        🇰🇼
                                    </div>
                                    <div class="w-7 h-7 rounded-full bg-slate-100 flex items-center justify-center text-slate-600 text-[11px] shadow-xs border border-slate-200">
                                        <i class="fa-regular fa-user"></i>
                                    </div>
                                    <div class="w-7 h-7 rounded-full bg-slate-100 flex items-center justify-center text-slate-600 text-[11px] shadow-xs border border-slate-200 relative">
                                        <i class="fa-regular fa-bell"></i>
                                        <span class="absolute top-1 right-1 w-1.5 h-1.5 rounded-full bg-blue-600"></span>
                                    </div>
                                </div>
                                
                                <div class="flex items-center gap-1 px-2 py-0.5 rounded-full bg-blue-50 border border-blue-200 text-blue-700 font-bold text-[10px]">
                                    <img src="{{ asset('images/logo.png') }}" class="w-3.5 h-3.5 object-contain" alt="DW">
                                    <span>EN</span>
                                    <i class="fa-solid fa-chevron-down text-[8px]"></i>
                                </div>
                            </div>

                            <!-- App Title -->
                            <div class="pt-1">
                                <div class="text-xs font-black text-slate-900 tracking-tight leading-tight">Direct Work App</div>
                                <div class="text-[9px] font-semibold text-slate-500">Direct Hiring Platform in Kuwait</div>
                            </div>

                            <!-- Dark Luxury Hero Banner (Kuwait City Night Skyline) -->
                            <div class="relative rounded-xl overflow-hidden bg-gradient-to-br from-slate-950 via-blue-950 to-slate-900 text-white p-3 shadow-md border border-blue-900/40">
                                <div class="absolute -right-4 -bottom-4 opacity-15">
                                    <i class="fa-solid fa-city text-7xl text-blue-400"></i>
                                </div>
                                <div class="relative z-10 space-y-1">
                                    <div class="inline-flex items-center gap-1 px-1.5 py-0.5 rounded-md bg-blue-600/30 border border-blue-400/30 text-blue-300 text-[8px] font-black tracking-wider uppercase">
                                        <i class="fa-solid fa-bolt text-[7px] text-blue-400"></i>
                                        <span>Direct Work</span>
                                    </div>
                                    <div class="text-xs font-black leading-tight text-white">
                                        Find the right talent.<br><span class="text-blue-400">Build the future.</span>
                                    </div>
                                    <div class="text-[8px] text-slate-300 font-medium">
                                        Access 10,000+ active candidates across 27+ sectors in Kuwait.
                                    </div>
                                </div>
                            </div>

                            <!-- Banner Dots Indicator -->
                            <div class="flex items-center justify-center gap-1 -my-0.5">
                                <span class="w-4 h-1 rounded-full bg-blue-600"></span>
                                <span class="w-1 h-1 rounded-full bg-slate-300"></span>
                                <span class="w-1 h-1 rounded-full bg-slate-300"></span>
                            </div>

                            <!-- Support Callout Strip -->
                            <div class="py-1 px-2 rounded-lg bg-blue-50/80 border border-blue-200/80 flex items-center justify-between text-[8px]">
                                <div class="flex items-center gap-1.5 text-blue-900 font-bold">
                                    <i class="fa-solid fa-headset text-blue-600 text-[10px]"></i>
                                    <span>Direct hiring inquiries & support</span>
                                </div>
                                <i class="fa-solid fa-chevron-right text-[8px] text-blue-600"></i>
                            </div>

                            <!-- Seeker Action Card 1: Inside Kuwait (Royal Blue Theme) -->
                            <div class="bg-white rounded-xl p-2.5 border border-blue-100 shadow-xs flex items-center justify-between gap-2">
                                <div class="flex items-center gap-2">
                                    <div class="w-8 h-8 rounded-lg bg-blue-100 text-blue-700 flex items-center justify-center text-xs shrink-0">
                                        <i class="fa-solid fa-users"></i>
                                    </div>
                                    <div>
                                        <div class="text-[10px] font-black text-slate-900 leading-tight">Apply for jobs inside Kuwait</div>
                                        <div class="text-[8px] text-slate-400 font-medium">Browse verified jobs and apply directly</div>
                                    </div>
                                </div>
                                <div class="px-2.5 py-1 rounded-lg bg-gradient-to-r from-blue-600 to-blue-700 text-white font-black text-[9px] shadow-xs flex items-center gap-1 shrink-0">
                                    <span>Apply Now</span>
                                    <i class="fa-solid fa-arrow-right text-[7px]"></i>
                                </div>
                            </div>

                            <!-- Seeker Action Card 2: Outside Kuwait Applicants -->
                            <div class="bg-white rounded-xl p-2.5 border border-slate-100 shadow-xs flex items-center justify-between gap-2">
                                <div class="flex items-center gap-2">
                                    <div class="w-8 h-8 rounded-lg bg-pink-100 text-pink-600 flex items-center justify-center text-xs shrink-0">
                                        <i class="fa-solid fa-globe"></i>
                                    </div>
                                    <div>
                                        <div class="text-[10px] font-black text-slate-900 leading-tight">Jobs in Kuwait (Outside Applicants)</div>
                                        <div class="text-[8px] text-slate-400 font-medium">Apply from abroad for jobs in Kuwait</div>
                                    </div>
                                </div>
                                <div class="px-2 py-1 rounded-lg bg-gradient-to-r from-pink-600 to-rose-600 text-white font-black text-[9px] shadow-xs flex items-center gap-1 shrink-0">
                                    <span>Apply Overseas</span>
                                    <i class="fa-solid fa-arrow-right text-[7px]"></i>
                                </div>
                            </div>

                            <!-- Seeker Action Card 3: Part-Time Jobs -->
                            <div class="bg-white rounded-xl p-2 border border-slate-100 shadow-xs flex items-center justify-between gap-2">
                                <div class="flex items-center gap-2">
                                    <div class="w-7 h-7 rounded-lg bg-emerald-100 text-emerald-700 flex items-center justify-center text-[11px] shrink-0">
                                        <i class="fa-regular fa-clock"></i>
                                    </div>
                                    <div>
                                        <div class="text-[10px] font-black text-slate-900 leading-tight">Part-time jobs in Kuwait</div>
                                        <div class="text-[8px] text-slate-400 font-medium">Flexible & hourly career opportunities</div>
                                    </div>
                                </div>
                                <div class="px-2 py-1 rounded-lg bg-slate-900 text-white font-bold text-[8px] shrink-0">
                                    Explore
                                </div>
                            </div>

                        </div>

                        <!-- Authentic Direct Work Bottom Navigation Bar (Royal Blue Theme) -->
                        <div class="bg-white border-t border-slate-200 px-4 py-1.5 flex items-center justify-between text-center relative z-20">
                            <!-- Home (Active Royal Blue) -->
                            <div class="flex flex-col items-center">
                                <i class="fa-solid fa-house text-blue-600 text-xs"></i>
                                <span class="text-[8px] font-black text-blue-600 mt-0.5">Home</span>
                            </div>

                            <!-- Search -->
                            <div class="flex flex-col items-center">
                                <i class="fa-solid fa-magnifying-glass text-slate-400 text-xs"></i>
                                <span class="text-[8px] font-bold text-slate-400 mt-0.5">Search</span>
                            </div>

                            <!-- Post Ad Action Circle (Center FAB in Royal Blue) -->
                            <div class="flex flex-col items-center -mt-4">
                                <div class="w-9 h-9 rounded-full bg-gradient-to-r from-blue-600 to-blue-700 text-white flex items-center justify-center shadow-md shadow-blue-500/40 border-2 border-white">
                                    <i class="fa-solid fa-plus text-xs"></i>
                                </div>
                                <span class="text-[7px] font-black text-blue-700 mt-0.5">Add Ad</span>
                            </div>

                            <!-- Commercial -->
                            <div class="flex flex-col items-center">
                                <i class="fa-solid fa-bullhorn text-slate-400 text-xs"></i>
                                <span class="text-[8px] font-bold text-slate-400 mt-0.5">Commercial</span>
                            </div>

                            <!-- Chats -->
                            <div class="flex flex-col items-center">
                                <i class="fa-regular fa-comment-dots text-slate-400 text-xs"></i>
                                <span class="text-[8px] font-bold text-slate-400 mt-0.5">Chats</span>
                            </div>
                        </div>

                    </div>

                </div>

            </div>
        </div>
    </section>

    <!-- 2. METRICS & STATS ROW -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 py-10 border-y border-slate-200/80 text-center">
            <div>
                <div class="text-4xl sm:text-5xl font-black text-blue-600">50K+</div>
                <div class="text-sm font-bold text-slate-600 mt-1">
                    {{ ($isArabic ?? false) ? 'باحث نشط عن عمل' : 'Active Seekers' }}
                </div>
            </div>
            <div>
                <div class="text-4xl sm:text-5xl font-black text-slate-900">2,000+</div>
                <div class="text-sm font-bold text-slate-600 mt-1">
                    {{ ($isArabic ?? false) ? 'شركة وجهة عمل موثوقة' : 'Trusted Companies' }}
                </div>
            </div>
            <div>
                <div class="text-4xl sm:text-5xl font-black text-slate-900">10K+</div>
                <div class="text-sm font-bold text-slate-600 mt-1">
                    {{ ($isArabic ?? false) ? 'عملية توظيف ناجحة' : 'Successful Hires' }}
                </div>
            </div>
        </div>

        <!-- Four Feature Badges Row -->
        <div class="flex flex-wrap items-center justify-center gap-3 sm:gap-6 pt-10">
            <span class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white border border-slate-200 text-slate-700 font-bold text-xs shadow-xs">
                <i class="fa-solid fa-mobile-screen text-blue-600"></i>
                <span>iOS & Android</span>
            </span>
            <span class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white border border-slate-200 text-slate-700 font-bold text-xs shadow-xs">
                <i class="fa-solid fa-location-dot text-blue-600"></i>
                <span>{{ ($isArabic ?? false) ? 'مخصص لسوق ' . $activeCountry['short_name_ar'] : 'Built for ' . ($activeCountry['name_en'] ?? 'Kuwait') }}</span>
            </span>
            <span class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white border border-slate-200 text-slate-700 font-bold text-xs shadow-xs">
                <i class="fa-solid fa-user-check text-blue-600"></i>
                <span>{{ ($isArabic ?? false) ? 'تواصل مباشر مع صاحب العمل' : 'Direct employer contact' }}</span>
            </span>
            <span class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white border border-slate-200 text-slate-700 font-bold text-xs shadow-xs">
                <i class="fa-solid fa-shield-halved text-blue-600"></i>
                <span>{{ ($isArabic ?? false) ? 'بدون وسطاء وبدون عمولات' : 'No middlemen' }}</span>
            </span>
        </div>
    </section>

    <!-- 3. HOW DIRECT WORK WORKS WITH 3 PHONE MOCKUPS -->
    <section id="how-it-works" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-10">
        
        <!-- Section Header -->
        <div class="text-center max-w-2xl mx-auto space-y-3 mb-16">
            <h2 class="text-3xl sm:text-4xl font-black text-slate-900 tracking-tight">
                @if($isArabic ?? false)
                    كيف يعمل <span class="text-blue-600">دايركت وورك</span>
                @else
                    How <span class="text-blue-600">Direct Work</span> works
                @endif
            </h2>
            <p class="text-sm sm:text-base text-slate-600 font-medium">
                @if($isArabic ?? false)
                    أنشئ ملفك المهني في دقائق واجعل كبرى الشركات وأصحاب العمل في {{ $activeCountry['short_name_ar'] }} تكتشفك.
                @else
                    Create your profile in minutes and get discovered by employers in {{ $activeCountry['name_en'] ?? 'Kuwait' }}.
                @endif
            </p>
        </div>

        <!-- 3 Columns with Step Titles and 3 Phone Mockups -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-10 lg:gap-8 items-start">
            
            <!-- Step 1: Create Profile -->
            <div class="space-y-6 flex flex-col items-center text-center">
                <div class="w-10 h-10 rounded-full bg-blue-100 text-blue-700 font-black text-sm flex items-center justify-center">
                    1
                </div>
                <div>
                    <h3 class="text-lg font-black text-slate-900 mb-1.5">
                        {{ ($isArabic ?? false) ? 'أنشئ حسابك وارفع سيرتك الذاتية' : 'Create your profile and upload your CV' }}
                    </h3>
                    <p class="text-xs text-slate-500 font-semibold leading-relaxed max-w-xs mx-auto">
                        {{ ($isArabic ?? false) ? 'أضف بياناتك الشخصية وخبراتك ومهاراتك، وارفع سيرتك الذاتية والشهادات.' : 'Add your details, experience and skills. Upload your CV and certificates.' }}
                    </p>
                </div>

                <!-- Phone Mockup 1: Authentic App UI Application & CV Screen (Royal Blue Theme) -->
                <div class="w-[260px] h-[520px] phone-frame border-2 border-slate-900 relative shadow-card mt-2 overflow-hidden bg-slate-50 flex flex-col justify-between text-left select-none pointer-events-none">
                    <div class="dynamic-island"></div>

                    <!-- Top Bar -->
                    <div class="pt-8 px-3 pb-2 bg-white border-b border-slate-100 flex items-center justify-between">
                        <div class="flex items-center gap-2">
                            <div class="w-6 h-6 rounded-full bg-slate-100 flex items-center justify-center text-slate-700 text-xs">
                                <i class="fa-solid fa-arrow-left text-[10px]"></i>
                            </div>
                            <span class="text-[11px] font-black text-slate-900 truncate max-w-[170px]">Formwork Carpenter</span>
                        </div>
                    </div>

                    <!-- Scrollable Form Body -->
                    <div class="flex-1 px-3 py-2 space-y-2.5 overflow-hidden content-start">
                        
                        <!-- Attachments & Documents Box -->
                        <div class="p-2.5 rounded-xl bg-white border border-slate-200/90 shadow-xs space-y-2">
                            <div class="flex items-center justify-between text-blue-700">
                                <span class="text-[10px] font-black">Attachments & Documents</span>
                                <i class="fa-solid fa-paperclip text-[10px]"></i>
                            </div>

                            <!-- Resume / CV -->
                            <div>
                                <div class="text-[9px] font-bold text-slate-900">Resume / CV (Optional)</div>
                                <div class="text-[7.5px] text-slate-400 font-medium">Attach your CV in PDF or Word format</div>
                                <div class="mt-1 py-1.5 px-2 rounded-lg border border-blue-200 bg-blue-50/50 flex items-center justify-center gap-1.5 text-[9px] font-bold text-blue-700">
                                    <i class="fa-solid fa-arrow-up-from-bracket text-[8px]"></i>
                                    <span>Select CV File (PDF / Word)</span>
                                </div>
                            </div>

                            <!-- Experience Certificates -->
                            <div>
                                <div class="flex items-center justify-between text-[9px] font-bold text-slate-900">
                                    <span>Experience & Certificates</span>
                                    <span class="px-1.5 py-0.2 rounded bg-slate-100 text-slate-500 text-[8px]">0/5</span>
                                </div>
                                <div class="mt-1 py-1 px-2 rounded-lg border border-slate-200 bg-white flex items-center justify-center gap-1.5 text-[8.5px] font-bold text-slate-600">
                                    <i class="fa-regular fa-image text-[8px]"></i>
                                    <span>Add Certificate</span>
                                </div>
                            </div>
                        </div>

                        <!-- Visibility & Duration Box (Royal Blue Plan) -->
                        <div class="p-2.5 rounded-xl bg-white border border-slate-200/90 shadow-xs space-y-1.5">
                            <div class="flex items-center justify-between text-blue-700">
                                <span class="text-[10px] font-black">Choose Ad Visibility</span>
                                <i class="fa-regular fa-clock text-[10px]"></i>
                            </div>

                            <div class="p-2 rounded-lg bg-blue-50/80 border border-blue-200 flex items-center justify-between">
                                <div>
                                    <div class="text-[9px] font-black text-blue-900">Job Application (3 Months)</div>
                                    <div class="text-[7.5px] text-blue-700/80 font-medium">Active for 90 days, auto-removed</div>
                                </div>
                                <div class="text-right">
                                    <div class="text-xs font-black text-blue-700">2</div>
                                    <div class="text-[7.5px] font-bold text-blue-600">KWD</div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- Bottom Button in Royal Blue -->
                    <div class="p-3 bg-white border-t border-slate-100">
                        <div class="w-full py-2 rounded-xl bg-gradient-to-r from-blue-600 to-blue-700 text-white font-black text-[10px] text-center shadow-md shadow-blue-500/25 flex items-center justify-center gap-1.5">
                            <i class="fa-regular fa-credit-card text-[9px]"></i>
                            <span>Proceed to Payment (2 KWD)</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Step 2: Choose Sector -->
            <div class="space-y-6 flex flex-col items-center text-center">
                <div class="w-10 h-10 rounded-full bg-blue-100 text-blue-700 font-black text-sm flex items-center justify-center">
                    2
                </div>
                <div>
                    <h3 class="text-lg font-black text-slate-900 mb-1.5">
                        {{ ($isArabic ?? false) ? 'اختر قطاعك وتخصصك المهني' : 'Choose your sector and profession' }}
                    </h3>
                    <p class="text-xs text-slate-500 font-semibold leading-relaxed max-w-xs mx-auto">
                        {{ ($isArabic ?? false) ? 'حدد القطاع والتخصص الدقيق الذي يتطابق مع مهاراتك وخبرتك المهنية.' : 'Select the sector and exact profession that matches your expertise.' }}
                    </p>
                </div>

                <!-- Phone Mockup 2: Authentic App UI Sector Selection Screen (Royal Blue Theme) -->
                <div class="w-[260px] h-[520px] phone-frame border-2 border-slate-900 relative shadow-card mt-2 overflow-hidden bg-slate-50 flex flex-col justify-between text-left select-none pointer-events-none">
                    <div class="dynamic-island"></div>

                    <!-- Top Bar -->
                    <div class="pt-8 px-3 pb-2 bg-white border-b border-slate-100 flex items-center justify-between">
                        <div class="flex items-center gap-2">
                            <div class="w-6 h-6 rounded-full bg-slate-100 flex items-center justify-center text-slate-700 text-xs">
                                <i class="fa-solid fa-arrow-left text-[10px]"></i>
                            </div>
                            <span class="text-[11px] font-black text-slate-900">Select Sector</span>
                        </div>
                        <span class="px-2 py-0.5 rounded-full bg-blue-50 text-blue-700 font-bold text-[9px] border border-blue-200">
                            27 Sectors
                        </span>
                    </div>

                    <!-- Search Input -->
                    <div class="px-3 pt-2">
                        <div class="bg-white rounded-xl px-2.5 py-1.5 border border-slate-200 flex items-center gap-2 text-[10px] text-slate-400 shadow-xs">
                            <i class="fa-solid fa-magnifying-glass text-blue-600 text-xs"></i>
                            <span>Search sector or profession...</span>
                        </div>
                    </div>

                    <!-- Sectors 2-Column Grid -->
                    <div class="flex-1 px-3 py-2 grid grid-cols-2 gap-2 overflow-hidden content-start">
                        <!-- Sector 1 -->
                        <div class="p-2 rounded-xl bg-white border-2 border-blue-600 shadow-xs flex flex-col justify-between">
                            <div class="w-7 h-7 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center text-xs">
                                <i class="fa-solid fa-ruler-combined"></i>
                            </div>
                            <div class="mt-2">
                                <div class="text-[10px] font-black text-slate-900 leading-tight">Engineering</div>
                                <div class="text-[8px] font-bold text-blue-600">12,540 profiles</div>
                            </div>
                        </div>

                        <!-- Sector 2 -->
                        <div class="p-2 rounded-xl bg-white border border-slate-200 shadow-xs flex flex-col justify-between">
                            <div class="w-7 h-7 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center text-xs">
                                <i class="fa-solid fa-laptop-code"></i>
                            </div>
                            <div class="mt-2">
                                <div class="text-[10px] font-black text-slate-900 leading-tight">IT & Tech</div>
                                <div class="text-[8px] text-slate-400 font-semibold">3,764 profiles</div>
                            </div>
                        </div>

                        <!-- Sector 3 -->
                        <div class="p-2 rounded-xl bg-white border border-slate-200 shadow-xs flex flex-col justify-between">
                            <div class="w-7 h-7 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center text-xs">
                                <i class="fa-solid fa-user-doctor"></i>
                            </div>
                            <div class="mt-2">
                                <div class="text-[10px] font-black text-slate-900 leading-tight">Healthcare</div>
                                <div class="text-[8px] text-slate-400 font-semibold">4,892 profiles</div>
                            </div>
                        </div>

                        <!-- Sector 4 -->
                        <div class="p-2 rounded-xl bg-white border border-slate-200 shadow-xs flex flex-col justify-between">
                            <div class="w-7 h-7 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center text-xs">
                                <i class="fa-solid fa-calculator"></i>
                            </div>
                            <div class="mt-2">
                                <div class="text-[10px] font-black text-slate-900 leading-tight">Accounting</div>
                                <div class="text-[8px] text-slate-400 font-semibold">6,245 profiles</div>
                            </div>
                        </div>

                        <!-- Sector 5 -->
                        <div class="p-2 rounded-xl bg-white border border-slate-200 shadow-xs flex flex-col justify-between">
                            <div class="w-7 h-7 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center text-xs">
                                <i class="fa-solid fa-cart-shopping"></i>
                            </div>
                            <div class="mt-2">
                                <div class="text-[10px] font-black text-slate-900 leading-tight">Sales & Retail</div>
                                <div class="text-[8px] text-slate-400 font-semibold">7,103 profiles</div>
                            </div>
                        </div>

                        <!-- Sector 6 -->
                        <div class="p-2 rounded-xl bg-white border border-slate-200 shadow-xs flex flex-col justify-between">
                            <div class="w-7 h-7 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center text-xs">
                                <i class="fa-solid fa-utensils"></i>
                            </div>
                            <div class="mt-2">
                                <div class="text-[10px] font-black text-slate-900 leading-tight">Hospitality</div>
                                <div class="text-[8px] text-slate-400 font-semibold">5,341 profiles</div>
                            </div>
                        </div>
                    </div>

                    <!-- Bottom Action Button in Royal Blue -->
                    <div class="p-3 bg-white border-t border-slate-100">
                        <div class="w-full py-2 rounded-xl bg-gradient-to-r from-blue-600 to-blue-700 text-white font-black text-[10px] text-center shadow-md shadow-blue-500/25 flex items-center justify-center gap-1.5">
                            <span>Continue to Professions</span>
                            <i class="fa-solid fa-arrow-right text-[8px]"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Step 3: Direct Contact -->
            <div class="space-y-6 flex flex-col items-center text-center">
                <div class="w-10 h-10 rounded-full bg-blue-100 text-blue-700 font-black text-sm flex items-center justify-center">
                    3
                </div>
                <div>
                    <h3 class="text-lg font-black text-slate-900 mb-1.5">
                        {{ ($isArabic ?? false) ? 'تواصل فوري مع أصحاب العمل' : 'Get seen by employers who need you' }}
                    </h3>
                    <p class="text-xs text-slate-500 font-semibold leading-relaxed max-w-xs mx-auto">
                        {{ ($isArabic ?? false) ? 'تستعرض الشركات ملفك وتتواصل معك مباشرة عبر الهاتف والواتساب والمحادثة.' : 'Employers in your sector can view your profile and contact you directly.' }}
                    </p>
                </div>

                <!-- Phone Mockup 3: Chat Screen -->
                <div class="w-[260px] h-[520px] phone-frame border-2 border-slate-900 relative shadow-card mt-2">
                    <div class="dynamic-island"></div>
                    <div class="w-full h-full overflow-hidden bg-[#F8FAFC] pt-8 px-3 flex flex-col justify-between text-left">
                        
                        <!-- Chat Top -->
                        <div class="py-2 border-b border-slate-100 flex items-center justify-between">
                            <span class="px-2 py-0.5 rounded-full bg-blue-100 text-blue-700 text-[9px] font-bold">Company</span>
                            <span class="text-[10px] font-black text-slate-900">company.co</span>
                            <div class="w-5 h-5 rounded-full bg-blue-600 text-white flex items-center justify-center text-[9px] font-bold">C</div>
                        </div>

                        <!-- Chat Messages -->
                        <div class="flex-1 py-3 space-y-2.5 overflow-hidden text-[10px]">
                            <div class="bg-white p-2.5 rounded-xl rounded-tl-none border border-slate-200 text-slate-700 max-w-[80%] shadow-xs">
                                Hello! We saw your profile and we would like to interview you for the engineer role.
                            </div>
                            <div class="bg-blue-600 text-white p-2.5 rounded-xl rounded-tr-none max-w-[80%] ml-auto shadow-xs">
                                Hello! Thank you for getting in touch. I am ready for the interview anytime.
                            </div>
                            <div class="bg-white p-2.5 rounded-xl rounded-tl-none border border-slate-200 text-slate-700 max-w-[80%] shadow-xs">
                                Great! Are you available for a direct call today?
                            </div>
                        </div>

                        <!-- Chat Input Box -->
                        <div class="py-2 border-t border-slate-100 flex items-center gap-1.5">
                            <i class="fa-solid fa-paperclip text-slate-400 text-xs"></i>
                            <div class="flex-1 bg-white border border-slate-200 rounded-xl px-2 py-1 text-[9px] text-slate-400">Type a message...</div>
                            <div class="w-6 h-6 rounded-full bg-blue-600 text-white flex items-center justify-center"><i class="fa-solid fa-paper-plane text-[8px]"></i></div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </section>

    <!-- 4. BROWSE JOBS BY SECTOR -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-8">
            <div class="space-y-1.5">
                <h2 class="text-3xl sm:text-4xl font-black text-slate-900 tracking-tight">
                    @if($isArabic ?? false)
                        تصفح الوظائف حسب <span class="text-blue-600">القطاع</span>
                    @else
                        Browse jobs by <span class="text-blue-600">sector</span>
                    @endif
                </h2>
                <p class="text-xs sm:text-sm text-slate-500 font-semibold">
                    {{ ($isArabic ?? false) ? 'ابحث عن الفرص في المجال المناسب. مخصص لسوق ' . $activeCountry['short_name_ar'] . '.' : 'Find opportunities in the right field. Built for the ' . ($activeCountry['name_en'] ?? 'Kuwait') . ' job market.' }}
                </p>
            </div>

            <!-- Inside / Outside Kuwait Toggle -->
            <div class="inline-flex items-center p-1 bg-slate-100 rounded-full text-xs font-black">
                <button type="button" class="px-4 py-2 rounded-full bg-white shadow-xs text-blue-600 transition">
                    {{ ($isArabic ?? false) ? 'داخل ' . $activeCountry['short_name_ar'] : 'Inside ' . ($activeCountry['name_en'] ?? 'Kuwait') }}
                </button>
                <button type="button" class="px-4 py-2 rounded-full text-slate-600 hover:text-slate-900 transition">
                    {{ ($isArabic ?? false) ? 'خارج ' . $activeCountry['short_name_ar'] : 'Outside ' . ($activeCountry['name_en'] ?? 'Kuwait') }}
                </button>
            </div>
        </div>

        <!-- Horizontal Scrollable Cards of Sectors with Next & Previous Arrows -->
        <div class="relative flex items-center">
            
            <!-- Previous Arrow Button -->
            <button type="button" onclick="scrollSectors(-320)" 
                    class="w-10 h-10 rounded-full bg-white border border-slate-200 shadow-md hover:bg-slate-50 flex items-center justify-center text-slate-600 hover:text-blue-600 transition shrink-0 mr-2 z-10 focus:outline-none" 
                    title="Previous Sectors">
                <i class="fa-solid fa-chevron-left text-xs"></i>
            </button>

            <!-- Horizontal Scroll Carousel for All 27 Sectors (Non-clickable cards) -->
            <div id="sectorsCarousel" class="flex-1 flex gap-4 overflow-x-auto scroll-smooth no-scrollbar py-4 px-1">
                @php
                $sectorIcons = [
                    'construction' => 'fa-solid fa-helmet-safety',
                    'drivers' => 'fa-solid fa-car',
                    'medical' => 'fa-regular fa-heart',
                    'restaurants' => 'fa-solid fa-utensils',
                    'sales_retail' => 'fa-solid fa-bag-shopping',
                    'security' => 'fa-solid fa-shield-halved',
                    'cleaning_facility' => 'fa-solid fa-broom',
                    'factories' => 'fa-solid fa-industry',
                    'engineering' => 'fa-solid fa-ruler-combined',
                    'tech_ai' => 'fa-solid fa-laptop-code',
                    'accounting' => 'fa-solid fa-calculator',
                    'legal' => 'fa-solid fa-scale-balanced',
                    'education' => 'fa-solid fa-graduation-cap',
                    'secretarial' => 'fa-solid fa-user-tie',
                    'beauty_salon' => 'fa-solid fa-scissors',
                    'tailoring' => 'fa-solid fa-shirt',
                    'agriculture' => 'fa-solid fa-seedling',
                    'sports_health' => 'fa-solid fa-dumbbell',
                    'digital_marketing' => 'fa-solid fa-bullhorn',
                    'oil_gas' => 'fa-solid fa-oil-well',
                    'aviation' => 'fa-solid fa-plane',
                    'transport' => 'fa-solid fa-truck-moving',
                    'insurance' => 'fa-solid fa-file-invoice-dollar',
                    'car_rental' => 'fa-solid fa-key',
                    'car_bike_tech' => 'fa-solid fa-wrench',
                    'technical' => 'fa-solid fa-gears',
                    'medical_engineering' => 'fa-solid fa-microscope',
                    'online_sales_lady' => 'fa-solid fa-headset',
                ];
                $allDisplaySectors = $allSectors ?? $sectors ?? [];
                @endphp

                @foreach($allDisplaySectors as $s)
                    <div class="w-44 sm:w-48 shrink-0 p-5 rounded-2xl bg-white border border-slate-200/90 shadow-xs flex flex-col items-center text-center select-none cursor-default">
                        <div class="w-12 h-12 rounded-2xl bg-orange-50/80 text-orange-600 flex items-center justify-center text-xl mb-3">
                            <i class="{{ $sectorIcons[$s['code'] ?? ''] ?? 'fa-solid fa-briefcase' }}"></i>
                        </div>
                        <h4 class="text-xs font-black text-slate-900 truncate w-full" title="{{ ($isArabic ?? false) ? ($s['name_ar'] ?? '') : ($s['name_en'] ?? '') }}">
                            {{ ($isArabic ?? false) ? ($s['name_ar'] ?? '') : ($s['name_en'] ?? '') }}
                        </h4>
                        <span class="text-[10px] text-slate-400 font-semibold mt-1">
                            {{ number_format(max(120, count($s['professions'] ?? []) * 145 + 32)) }} jobs
                        </span>
                    </div>
                @endforeach
            </div>

            <!-- Next Arrow Button -->
            <button type="button" onclick="scrollSectors(320)" 
                    class="w-10 h-10 rounded-full bg-white border border-slate-200 shadow-md hover:bg-slate-50 flex items-center justify-center text-slate-600 hover:text-blue-600 transition shrink-0 ml-2 z-10 focus:outline-none" 
                    title="Next Sectors">
                <i class="fa-solid fa-chevron-right text-xs"></i>
            </button>

        </div>
    </section>

    <!-- 5. WHY CHOOSE DIRECT WORK -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="mb-12">
            <h2 class="text-3xl sm:text-4xl font-black text-slate-900 tracking-tight">
                @if($isArabic ?? false)
                    لماذا تختار <span class="text-blue-600">دايركت وورك</span>؟
                @else
                    Why choose <span class="text-blue-600">Direct Work</span>?
                @endif
            </h2>
            <p class="text-sm text-slate-500 font-semibold mt-1">
                {{ ($isArabic ?? false) ? 'أرسلت مئات السير الذاتية دون رد؟ نحن نغير المعادلة بالكامل.' : 'Sent 100 CVs and heard nothing? We flip it.' }}
            </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            
            <!-- Value Prop 1 -->
            <div class="space-y-3">
                <div class="w-12 h-12 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center text-xl">
                    <i class="fa-regular fa-eye"></i>
                </div>
                <h3 class="text-base font-black text-slate-900">
                    {{ ($isArabic ?? false) ? 'احصل على الظهور أمام أصحاب العمل المناسبين' : 'Get seen by the right employers' }}
                </h3>
                <p class="text-xs text-slate-500 font-semibold leading-relaxed">
                    {{ ($isArabic ?? false) ? 'ملفك الشخصي يظهر فوراً لأصحاب العمل والشركات التي تبحث بنشاط في تخصصك الدقيق.' : 'Your profile is visible to employers who are actively looking in your sector.' }}
                </p>
            </div>

            <!-- Value Prop 2 -->
            <div class="space-y-3">
                <div class="w-12 h-12 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center text-xl">
                    <i class="fa-regular fa-comment-dots"></i>
                </div>
                <h3 class="text-base font-black text-slate-900">
                    {{ ($isArabic ?? false) ? 'تواصل مباشر بدون وسطاء' : 'Direct contact, no middlemen' }}
                </h3>
                <p class="text-xs text-slate-500 font-semibold leading-relaxed">
                    {{ ($isArabic ?? false) ? 'تتواصل معك الشركات مباشرة عبر الهاتف والواتساب والمحادثة. بدون وكالات توظيف وبدون أي رسوم إضافية.' : 'Employers contact you directly. No agencies, no extra fees.' }}
                </p>
            </div>

            <!-- Value Prop 3 -->
            <div class="space-y-3">
                <div class="w-12 h-12 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center text-xl">
                    <i class="fa-solid fa-location-dot"></i>
                </div>
                <h3 class="text-base font-black text-slate-900">
                    {{ ($isArabic ?? false) ? 'مخصص لسوق الكويت والخليج، موثوق من الكفاءات' : 'Built for Kuwait, loved by talent' }}
                </h3>
                <p class="text-xs text-slate-500 font-semibold leading-relaxed">
                    {{ ($isArabic ?? false) ? 'منصة مصممة خصيصاً لتلبية متطلبات سوق العمل المحلي واحتياجات القوى العاملة المتنوعة.' : 'A platform made for the Kuwait job market and the diverse workforce.' }}
                </p>
            </div>

        </div>
    </section>

    <!-- 6. FREQUENTLY ASKED QUESTIONS -->
    <section id="faq" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="flex flex-col sm:flex-row sm:items-end justify-between gap-4 mb-10">
            <div>
                <h2 class="text-3xl sm:text-4xl font-black text-slate-900 tracking-tight">
                    @if($isArabic ?? false)
                        الأسئلة <span class="text-blue-600">الشائعة</span>
                    @else
                        Frequently asked <span class="text-blue-600">questions</span>
                    @endif
                </h2>
            </div>
            <div>
                <a href="{{ route('support') }}" class="text-xs font-bold text-slate-500 hover:text-blue-600 transition flex items-center gap-1">
                    <span>{{ ($isArabic ?? false) ? 'لا زال لديك سؤال؟ تواصل معنا' : 'Still have questions? Contact us' }}</span>
                    <i class="fa-solid fa-arrow-right text-[10px] {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
                </a>
            </div>
        </div>

        <!-- 2 Columns FAQ Accordion Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            
            <!-- FAQ 1 -->
            <div class="bg-white rounded-2xl border border-slate-200/90 p-5 shadow-xs transition">
                <button type="button" onclick="toggleFaq(this)" class="w-full flex items-center justify-between text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-800 gap-4">
                    <span>{{ ($isArabic ?? false) ? 'كم تبلغ تكلفة نشر السيرة الذاتية للباحثين عن عمل؟' : 'How much does it cost for job seekers to post their CV?' }}</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-content hidden pt-3 text-xs text-slate-500 leading-relaxed font-semibold">
                    {{ ($isArabic ?? false) ? 'التكلفة في دولة الكويت هي 2 د.ك فقط (35 ر.س في السعودية، 30 د.إ في الإمارات) لصلاحية ظهور كاملة لمدة 90 يوماً متواصلة.' : 'The fee in Kuwait is only 2 KWD (35 SAR in Saudi Arabia, 30 AED in UAE) for a 90-day active listing visible to all employers.' }}
                </div>
            </div>

            <!-- FAQ 2 -->
            <div class="bg-white rounded-2xl border border-slate-200/90 p-5 shadow-xs transition">
                <button type="button" onclick="toggleFaq(this)" class="w-full flex items-center justify-between text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-800 gap-4">
                    <span>{{ ($isArabic ?? false) ? 'هل يمكنني التقدم للوظائف الشاغرة عبر التطبيق؟' : 'Can I apply for jobs through this app?' }}</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-content hidden pt-3 text-xs text-slate-500 leading-relaxed font-semibold">
                    {{ ($isArabic ?? false) ? 'نعم، يمكنك استعراض كافة إعلانات الوظائف والتواصل المباشر مع أصحاب العمل عبر الهاتف أو الواتساب فوراً.' : 'Yes! You can browse active job postings and directly contact employers via WhatsApp, phone, or instant chat.' }}
                </div>
            </div>

            <!-- FAQ 3 -->
            <div class="bg-white rounded-2xl border border-slate-200/90 p-5 shadow-xs transition">
                <button type="button" onclick="toggleFaq(this)" class="w-full flex items-center justify-between text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-800 gap-4">
                    <span>{{ ($isArabic ?? false) ? 'هل التواصل مع أصحاب العمل مباشر 100%؟' : 'Is it really direct contact with employers?' }}</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-content hidden pt-3 text-xs text-slate-500 leading-relaxed font-semibold">
                    {{ ($isArabic ?? false) ? 'نعم، التواصل مباشر بنسبة 100% بدون أي وسيط وبدون أي نسبة عمولة تقتطع من راتبك.' : 'Yes, 100% direct contact with zero recruiters, zero commissions, and zero fees deducted from your salary.' }}
                </div>
            </div>

            <!-- FAQ 4 -->
            <div class="bg-white rounded-2xl border border-slate-200/90 p-5 shadow-xs transition">
                <button type="button" onclick="toggleFaq(this)" class="w-full flex items-center justify-between text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-800 gap-4">
                    <span>{{ ($isArabic ?? false) ? 'هل يشترط وجود إقامة صالحة للعمل في الكويت؟' : 'Do I need a valid visa or IQAMA to join in Kuwait?' }}</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-content hidden pt-3 text-xs text-slate-500 leading-relaxed font-semibold">
                    {{ ($isArabic ?? false) ? 'نعم، تتطلب قوانين العمل في الكويت والخليج استيفاء شروط الإقامة أو تأشيرة العمل النظامية وفقاً لمتطلبات الشركة.' : 'Yes, legal hiring in Kuwait and GCC requires compliance with standard labor residency and visa regulations.' }}
                </div>
            </div>

            <!-- FAQ 5 -->
            <div class="bg-white rounded-2xl border border-slate-200/90 p-5 shadow-xs transition">
                <button type="button" onclick="toggleFaq(this)" class="w-full flex items-center justify-between text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-800 gap-4">
                    <span>{{ ($isArabic ?? false) ? 'كيف تجدني الشركات وأصحاب العمل؟' : 'How do employers find me?' }}</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-content hidden pt-3 text-xs text-slate-500 leading-relaxed font-semibold">
                    {{ ($isArabic ?? false) ? 'تقوم الشركات بالبحث والفلترة عبر قطاعك وتخصصك الدقيق، ثم يظهر ملفك المعتمد مع بيانات الاتصال المباشرة.' : 'Employers filter verified talent by sector and exact specialization, then contact you directly through your profile.' }}
                </div>
            </div>

            <!-- FAQ 6 -->
            <div class="bg-white rounded-2xl border border-slate-200/90 p-5 shadow-xs transition">
                <button type="button" onclick="toggleFaq(this)" class="w-full flex items-center justify-between text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-800 gap-4">
                    <span>{{ ($isArabic ?? false) ? 'لم أجد مهنتي ضمن القائمة، ماذا أفعل؟' : "I can't find my profession. What should I do?" }}</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-content hidden pt-3 text-xs text-slate-500 leading-relaxed font-semibold">
                    {{ ($isArabic ?? false) ? 'نوفر أكثر من 27 قطاعاً ومئات المهن. يمكنك التواصل مع فريق الدعم الفني لمساعدتك في تصنيف مهنتك.' : 'Our catalog covers 27 specialized sectors and hundreds of roles. You can contact support anytime for assistance.' }}
                </div>
            </div>

            <!-- FAQ 7 -->
            <div class="bg-white rounded-2xl border border-slate-200/90 p-5 shadow-xs transition">
                <button type="button" onclick="toggleFaq(this)" class="w-full flex items-center justify-between text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-800 gap-4">
                    <span>{{ ($isArabic ?? false) ? 'ماذا عن حماية بياناتي وخصوصيتي؟' : 'What about my privacy?' }}</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-content hidden pt-3 text-xs text-slate-500 leading-relaxed font-semibold">
                    {{ ($isArabic ?? false) ? 'بياناتك مشفرة ومحمية، ولا نشاركها إطلاقاً مع أي جهات خارجية غير أصحاب العمل والشركات المسجلة.' : 'Your data is secured and protected. We never sell your personal information or share it outside verified employers.' }}
                </div>
            </div>

            <!-- FAQ 8 -->
            <div class="bg-white rounded-2xl border border-slate-200/90 p-5 shadow-xs transition">
                <button type="button" onclick="toggleFaq(this)" class="w-full flex items-center justify-between text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-800 gap-4">
                    <span>{{ ($isArabic ?? false) ? 'من يستطيع استخدام منصة دايركت وورك؟' : 'Who can use Direct Work?' }}</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-content hidden pt-3 text-xs text-slate-500 leading-relaxed font-semibold">
                    {{ ($isArabic ?? false) ? 'المنصة متاحة لجميع الكفاءات والمهنيين الباحثين عن عمل، ولكافة الشركات والمؤسسات والمكاتب في الكويت والخليج.' : 'Both individual professionals seeking employment and licensed companies or offices in Kuwait and GCC can use the platform.' }}
                </div>
            </div>

        </div>
    </section>

    <!-- 7. BOTTOM BIG CTA BANNER (Direct Work Blue Theme) -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="rounded-[40px] bg-gradient-to-br from-blue-900 via-blue-800 to-indigo-950 p-8 sm:p-14 lg:p-16 relative overflow-hidden shadow-card border border-blue-700/50 text-white">
            
            <!-- Subtle Skyline Silhouette in background -->
            <div class="absolute bottom-0 right-0 sm:right-16 opacity-10 pointer-events-none">
                <i class="fa-solid fa-city text-9xl text-white"></i>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-center relative z-10">
                
                <!-- Left Banner Copy -->
                <div class="lg:col-span-7 space-y-6 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }}">
                    <span class="text-[11px] font-black text-blue-200 tracking-widest uppercase block">
                        {{ ($isArabic ?? false) ? 'فرصتك المهنية القادمة بانتظارك' : 'YOUR NEXT OPPORTUNITY IS WAITING.' }}
                    </span>

                    <h2 class="text-3xl sm:text-5xl font-black text-white tracking-tight leading-tight">
                        {{ ($isArabic ?? false) ? 'احصل على الظهور. انطلق نحو الأمام.' : 'Get seen. Move forward.' }}
                    </h2>

                    <p class="text-sm sm:text-base text-blue-100 font-medium leading-relaxed max-w-lg">
                        {{ ($isArabic ?? false) ? 'فرصتك الوظيفية القادمة في الكويت تنتظرك الآن. حمّل التطبيق وفعّل ظهورك المباشر اليوم.' : 'Your next professional opportunity in Kuwait is waiting. Download the app and activate your visibility today.' }}
                    </p>

                    <!-- QR Code & App Badges -->
                    <div class="flex flex-col sm:flex-row items-center gap-4 pt-2">
                        <!-- App Store & Google Play -->
                        <div class="flex flex-col sm:flex-row gap-2.5 w-full sm:w-auto">
                            <a href="https://apple.com" target="_blank" rel="noopener noreferrer" 
                               class="inline-flex items-center gap-2.5 px-4 py-2.5 rounded-2xl bg-black hover:bg-slate-900 text-white transition shadow-sm">
                                <i class="fa-brands fa-apple text-xl"></i>
                                <span class="text-left leading-tight">
                                    <span class="block text-[8px] text-slate-400 font-medium">Download on the</span>
                                    <span class="text-xs font-bold">App Store</span>
                                </span>
                            </a>
                            <a href="https://google.com" target="_blank" rel="noopener noreferrer" 
                               class="inline-flex items-center gap-2.5 px-4 py-2.5 rounded-2xl bg-black hover:bg-slate-900 text-white transition shadow-sm">
                                <i class="fa-brands fa-google-play text-lg text-amber-400"></i>
                                <span class="text-left leading-none">
                                    <span class="block text-[8px] text-slate-400 font-medium">GET IT ON</span>
                                    <span class="text-xs font-bold">Google Play</span>
                                </span>
                            </a>
                        </div>

                        <!-- Scan QR Code Box -->
                        <div class="flex items-center gap-3 p-2.5 rounded-2xl bg-white text-slate-900 border border-white/20 shadow-xs">
                            <img src="{{ asset('images/qr_code.svg') }}" alt="QR Code" class="w-12 h-12 rounded-lg">
                            <div class="text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} pr-2">
                                <span class="block text-[10px] font-black text-slate-900 uppercase">
                                    {{ ($isArabic ?? false) ? 'امسح للتحميل' : 'SCAN TO DOWNLOAD' }}
                                </span>
                                <span class="text-[9px] text-slate-500 font-semibold block leading-tight">
                                    {{ ($isArabic ?? false) ? 'وجّه كاميرا هاتفك نحو الرمز' : 'Point camera at QR code' }}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Phone Mockup showing Real App Onboarding Screen -->
                <div class="lg:col-span-5 flex justify-center lg:justify-end">
                    <div class="w-[240px] sm:w-[270px] h-[480px] sm:h-[530px] phone-frame border-2 border-slate-900 relative shadow-2xl overflow-hidden">
                        <div class="dynamic-island"></div>
                        <img src="{{ asset('images/onboarding_slide1.png') }}" 
                             alt="Direct Work App Onboarding" 
                             class="w-full h-full object-cover object-top">
                    </div>
                </div>

            </div>

        </div>
    </section>

</div>

<script>
function scrollSectors(distance) {
    const el = document.getElementById('sectorsCarousel');
    if (el) {
        el.scrollBy({ left: distance, behavior: 'smooth' });
    }
}

function toggleFaq(button) {
    const content = button.nextElementSibling;
    const icon = button.querySelector('i');
    if (content.classList.contains('hidden')) {
        content.classList.remove('hidden');
        icon.classList.add('rotate-180');
    } else {
        content.classList.add('hidden');
        icon.classList.remove('rotate-180');
    }
}
</script>
@endsection
