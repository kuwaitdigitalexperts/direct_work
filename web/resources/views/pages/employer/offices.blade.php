@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'بوابة مكاتب الطباعة والخدمات المعتمدة | دايركت وورك' : 'Typing & Affiliate Offices Portal | Direct Jobs')

@section('content')
<div class="max-w-5xl mx-auto px-4 sm:px-6 py-12 space-y-12">

    <!-- Header -->
    <div class="text-center max-w-2xl mx-auto space-y-3">
        <span class="inline-flex items-center gap-1.5 px-3.5 py-1.5 rounded-full bg-orange-50 border border-orange-200 text-orange-700 text-xs font-black uppercase">
            {{ ($isArabic ?? false) ? 'مكاتب الطباعة والخدمات المعتمدة' : 'AUTHORIZED TYPING OFFICES' }}
        </span>
        <h1 class="text-3xl sm:text-4xl font-black text-slate-900 tracking-tight">
            {{ ($isArabic ?? false) ? 'خدمة تسجيل ومساعدة الباحثين عن عمل' : 'Candidate Assistance & Registration Portal' }}
        </h1>
        <p class="text-xs sm:text-sm text-slate-500 font-semibold leading-relaxed">
            {{ ($isArabic ?? false) ? 'مخصص لمكاتب الطباعة لتسجيل السير الذاتية وإعلانات الوظائف للعملاء والباحثين عن عمل مباشرة.' : 'Dedicated for authorized typing offices to help job seekers register CV applications across Kuwait.' }}
        </p>
    </div>

    <!-- Quick Action Cards -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        
        <!-- Action 1: Register Candidate CV Ad -->
        <div class="bg-white rounded-3xl border border-slate-200/90 p-8 shadow-card flex flex-col justify-between space-y-6">
            <div class="space-y-3">
                <div class="w-12 h-12 rounded-2xl bg-orange-100 text-orange-600 flex items-center justify-center text-xl">
                    <i class="fa-solid fa-file-circle-plus"></i>
                </div>
                <h3 class="text-lg font-black text-slate-900">
                    {{ ($isArabic ?? false) ? 'تسجيل طلب توظيف جديد لعميل' : 'Register New Candidate Application' }}
                </h3>
                <p class="text-xs text-slate-500 font-semibold leading-relaxed">
                    {{ ($isArabic ?? false) ? 'إدخال بيانات الباحث عن عمل واختيار مهنته وتخصصه ورفع السيرة الذاتية ورسوم النشر (' . $activeCountry['fee_display'] . ' ' . $activeCountry['currency_ar'] . ').' : 'Submit applicant details, assign sector profession, upload CV document, and complete posting (' . $activeCountry['fee_display'] . ' ' . $activeCountry['currency_en'] . ').' }}
                </p>
            </div>
            <div>
                <a href="{{ route('apply.index') }}" 
                   class="w-full py-3.5 rounded-xl bg-orange-600 hover:bg-orange-700 text-white font-black text-xs flex items-center justify-center gap-2 shadow transition">
                    <span>{{ ($isArabic ?? false) ? 'بدء تسجيل الطلب الآن' : 'Start Application Now' }}</span>
                    <i class="fa-solid fa-arrow-right text-[10px] {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
                </a>
            </div>
        </div>

        <!-- Action 2: Office Affiliate Support -->
        <div class="bg-white rounded-3xl border border-slate-200/90 p-8 shadow-card flex flex-col justify-between space-y-6">
            <div class="space-y-3">
                <div class="w-12 h-12 rounded-2xl bg-blue-100 text-blue-600 flex items-center justify-center text-xl">
                    <i class="fa-solid fa-handshake"></i>
                </div>
                <h3 class="text-lg font-black text-slate-900">
                    {{ ($isArabic ?? false) ? 'طلب اعتماد مكتب طباعة جديد' : 'Become an Authorized Partner Office' }}
                </h3>
                <p class="text-xs text-slate-500 font-semibold leading-relaxed">
                    {{ ($isArabic ?? false) ? 'انضم لشبكة مكاتب الطباعة المعتمدة في الكويت واحصل على حساب وسيط معتمد لتسجيل العملاء.' : 'Join our authorized typing office affiliate network in Kuwait with corporate partner billing.' }}
                </p>
            </div>
            <div>
                <a href="{{ route('support') }}" 
                   class="w-full py-3.5 rounded-xl bg-slate-900 hover:bg-black text-white font-black text-xs flex items-center justify-center gap-2 shadow transition">
                    <span>{{ ($isArabic ?? false) ? 'تواصل مع الدعم للاعتماد' : 'Request Office Accreditation' }}</span>
                    <i class="fa-solid fa-arrow-right text-[10px] {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
                </a>
            </div>
        </div>

    </div>

</div>
@endsection
