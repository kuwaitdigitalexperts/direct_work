@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'تسجيل شركة جديدة | دايركت وورك' : 'Register Employer Account | Direct Work')

@section('content')
<div class="min-h-[85vh] flex flex-col justify-center items-center px-4 py-12">
    
    <!-- Back to Home Link -->
    <div class="w-full max-w-2xl mb-6 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }}">
        <a href="{{ route('home') }}" class="inline-flex items-center gap-2 text-xs font-bold text-slate-500 hover:text-blue-600 transition">
            <i class="fa-solid fa-arrow-left text-[10px] {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
            <span>{{ ($isArabic ?? false) ? 'العودة للرئيسية' : 'Back to Home' }}</span>
        </a>
    </div>

    <!-- Register Company Header -->
    <div class="text-center space-y-2 mb-8">
        <div class="flex items-center justify-center gap-2">
            <div class="w-10 h-10 rounded-2xl bg-gradient-to-br from-blue-700 to-blue-900 text-white flex items-center justify-center text-lg shadow-md shadow-blue-600/30">
                <i class="fa-solid fa-building"></i>
            </div>
            <h1 class="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight">
                {{ ($isArabic ?? false) ? 'تسجيل منشأة / شركة جديدة' : 'Register Employer Account' }}
            </h1>
        </div>
        <p class="text-xs sm:text-sm font-semibold text-blue-600">
            {{ ($isArabic ?? false) ? 'وظف أفضل الكفاءات والمهنيين في الكويت والخليج مباشرة بدون وسطاء' : 'Recruit top verified professionals directly in Kuwait with zero middlemen' }}
        </p>
    </div>

    <!-- Form Container -->
    <div class="w-full max-w-2xl bg-white rounded-3xl p-6 sm:p-10 border border-slate-200/90 shadow-card">
        
        @if ($errors->any())
            <div class="mb-6 p-4 rounded-2xl bg-red-50 border border-red-200 text-red-700 text-xs font-semibold space-y-1">
                @foreach ($errors->all() as $error)
                    <div class="flex items-center gap-1.5">
                        <i class="fa-solid fa-circle-exclamation text-xs"></i>
                        <span>{{ $error }}</span>
                    </div>
                @endforeach
            </div>
        @endif

        <form action="{{ route('employer.register.post') }}" method="POST" class="space-y-5">
            @csrf

            <!-- Row 1: Company Name & Contact Person -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                        {{ ($isArabic ?? false) ? 'اسم المنشأة أو الشركة' : 'COMPANY NAME' }} <span class="text-blue-600">*</span>
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                            <i class="fa-solid fa-building text-sm text-blue-600"></i>
                        </div>
                        <input type="text" name="company_name" value="{{ old('company_name') }}" required
                               placeholder="{{ ($isArabic ?? false) ? 'الاسم التجاري للشركة' : 'e.g. Al-Hamra Contracting Co.' }}"
                               class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/50 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3.5 {{ ($isArabic ?? false) ? 'pr-10 pl-4' : 'pl-10 pr-4' }} transition">
                    </div>
                </div>

                <div>
                    <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                        {{ ($isArabic ?? false) ? 'اسم مسؤول التوظيف' : 'CONTACT PERSON' }} <span class="text-blue-600">*</span>
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                            <i class="fa-regular fa-user text-sm text-blue-600"></i>
                        </div>
                        <input type="text" name="full_name" value="{{ old('full_name') }}" required
                               placeholder="{{ ($isArabic ?? false) ? 'الاسم الكامل لمسؤول الموارد البشرية' : 'HR Manager / Recruiter Name' }}"
                               class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/50 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3.5 {{ ($isArabic ?? false) ? 'pr-10 pl-4' : 'pl-10 pr-4' }} transition">
                    </div>
                </div>
            </div>

            <!-- Row 2: Email Address & Phone Number -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                        {{ ($isArabic ?? false) ? 'البريد الإلكتروني للعمل' : 'CORPORATE EMAIL' }} <span class="text-blue-600">*</span>
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                            <i class="fa-regular fa-envelope text-sm text-blue-600"></i>
                        </div>
                        <input type="email" name="email" value="{{ old('email') }}" required
                               placeholder="hr@company.com"
                               class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/50 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3.5 {{ ($isArabic ?? false) ? 'pr-10 pl-4' : 'pl-10 pr-4' }} transition">
                    </div>
                </div>

                <div>
                    <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                        {{ ($isArabic ?? false) ? 'رقم الهاتف / الواتساب' : 'PHONE NUMBER' }} <span class="text-blue-600">*</span>
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                            <i class="fa-solid fa-phone text-sm text-blue-600"></i>
                        </div>
                        <input type="tel" name="phone" value="{{ old('phone') }}" required
                               placeholder="+965 xxxx xxxx"
                               class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/50 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3.5 {{ ($isArabic ?? false) ? 'pr-10 pl-4' : 'pl-10 pr-4' }} transition">
                    </div>
                </div>
            </div>

            <!-- Row 3: Commercial License & Governorate -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                        {{ ($isArabic ?? false) ? 'السجل التجاري / الترخيص (اختياري)' : 'COMMERCIAL LICENSE (OPTIONAL)' }}
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                            <i class="fa-solid fa-file-contract text-sm text-blue-600"></i>
                        </div>
                        <input type="text" name="commercial_license" value="{{ old('commercial_license') }}"
                               placeholder="e.g. KW-2024-9910"
                               class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/50 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3.5 {{ ($isArabic ?? false) ? 'pr-10 pl-4' : 'pl-10 pr-4' }} transition">
                    </div>
                </div>

                <div>
                    <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                        {{ ($isArabic ?? false) ? 'المحافظة' : 'GOVERNORATE' }} <span class="text-blue-600">*</span>
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                            <i class="fa-solid fa-location-dot text-sm text-blue-600"></i>
                        </div>
                        <select name="governorate" required
                                class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/50 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3.5 {{ ($isArabic ?? false) ? 'pr-10 pl-4' : 'pl-10 pr-4' }} transition">
                            <option value="محافظة العاصمة" {{ old('governorate') === 'محافظة العاصمة' ? 'selected' : '' }}>Al Asimah (Capital)</option>
                            <option value="محافظة حولي" {{ old('governorate') === 'محافظة حولي' ? 'selected' : '' }}>Hawalli</option>
                            <option value="محافظة الفروانية" {{ old('governorate') === 'محافظة الفروانية' ? 'selected' : '' }}>Al Farwaniyah</option>
                            <option value="محافظة الأحمدي" {{ old('governorate') === 'محافظة الأحمدي' ? 'selected' : '' }}>Al Ahmadi</option>
                            <option value="محافظة مبارك الكبير" {{ old('governorate') === 'محافظة مبارك الكبير' ? 'selected' : '' }}>Mubarak Al-Kabeer</option>
                            <option value="محافظة الجهراء" {{ old('governorate') === 'محافظة الجهراء' ? 'selected' : '' }}>Al Jahra</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Row 4: Password -->
            <div>
                <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                    {{ ($isArabic ?? false) ? 'كلمة المرور' : 'PASSWORD' }} <span class="text-blue-600">*</span>
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                        <i class="fa-solid fa-lock text-sm text-blue-600"></i>
                    </div>
                    <input type="password" name="password" required
                           placeholder="••••••••"
                           class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/50 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3.5 {{ ($isArabic ?? false) ? 'pr-10 pl-4' : 'pl-10 pr-4' }} transition">
                </div>
            </div>

            <!-- Submit Button (Royal Blue Theme) -->
            <div class="pt-2">
                <button type="submit"
                        class="w-full py-4 rounded-2xl bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-black text-sm shadow-md shadow-blue-500/25 transition transform active:scale-[0.99] flex items-center justify-center gap-2">
                    <i class="fa-solid fa-user-plus text-xs"></i>
                    <span>{{ ($isArabic ?? false) ? 'إنشاء حساب الشركة والبدء بالتوظيف' : 'Create Company Account & Start Hiring' }}</span>
                </button>
            </div>

        </form>

        <!-- Sign in Link -->
        <div class="text-center pt-6 mt-6 border-t border-slate-100 text-xs text-slate-500 font-medium">
            <span>{{ ($isArabic ?? false) ? 'لديك حساب مسجل بالفعل؟' : 'Already have an employer account?' }}</span>
            <a href="{{ route('employer.login') }}" class="font-black text-blue-600 hover:text-blue-800 {{ ($isArabic ?? false) ? 'mr-1' : 'ml-1' }}">
                {{ ($isArabic ?? false) ? 'تسجيل الدخول' : 'Sign In' }}
            </a>
        </div>

    </div>

</div>
@endsection
