@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'تسجيل مكتب طباعة جديد | دايركت وورك' : 'Register Affiliate Office | Direct Work')

@section('content')
<div class="min-h-[85vh] flex flex-col justify-center items-center px-4 py-12">
    
    <!-- Back to Home Link -->
    <div class="w-full max-w-2xl mb-6 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }}">
        <a href="{{ route('home') }}" class="inline-flex items-center gap-2 text-xs font-bold text-slate-500 hover:text-blue-600 transition">
            <i class="fa-solid fa-arrow-left text-[10px] {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
            <span>{{ ($isArabic ?? false) ? 'العودة للرئيسية' : 'Back to Home' }}</span>
        </a>
    </div>

    <!-- Register Office Header -->
    <div class="text-center space-y-2 mb-8">
        <div class="flex items-center justify-center gap-2">
            <div class="w-9 h-9 rounded-xl bg-blue-100 text-blue-700 flex items-center justify-center text-lg shadow-xs">
                <i class="fa-solid fa-building-user"></i>
            </div>
            <h1 class="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight">
                {{ ($isArabic ?? false) ? 'تسجيل مكتب طباعة جديد' : 'Register Affiliate Office' }}
            </h1>
        </div>
        <p class="text-xs sm:text-sm font-semibold text-blue-600">
            {{ ($isArabic ?? false) ? 'سجل مكتبك للبدء في رفع وتوثيق السير الذاتية للباحثين عن عمل' : 'Sign up your office to begin registering job seekers' }}
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

        <form action="{{ route('affiliate.register.post') }}" method="POST" class="space-y-5">
            @csrf

            <!-- Row 1: Office Name & Contact Username -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                        {{ ($isArabic ?? false) ? 'اسم المكتب' : 'OFFICE NAME' }}
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                            <i class="fa-solid fa-building text-sm text-blue-600"></i>
                        </div>
                        <input type="text" name="office_name" value="{{ old('office_name') }}" required
                               placeholder="{{ ($isArabic ?? false) ? 'الاسم التجاري للمكتب' : 'Legal Office Name' }}"
                               class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/50 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3.5 {{ ($isArabic ?? false) ? 'pr-10 pl-4' : 'pl-10 pr-4' }} transition">
                    </div>
                </div>

                <div>
                    <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                        {{ ($isArabic ?? false) ? 'اسم الشخص المسؤول' : 'CONTACT USERNAME' }}
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                            <i class="fa-regular fa-user text-sm text-blue-600"></i>
                        </div>
                        <input type="text" name="contact_username" value="{{ old('contact_username') }}" required
                               placeholder="{{ ($isArabic ?? false) ? 'اسم مسؤول المكتب' : 'Contact Person Name' }}"
                               class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/50 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3.5 {{ ($isArabic ?? false) ? 'pr-10 pl-4' : 'pl-10 pr-4' }} transition">
                    </div>
                </div>
            </div>

            <!-- Row 2: Email Address & Phone Number -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                        {{ ($isArabic ?? false) ? 'البريد الإلكتروني' : 'EMAIL ADDRESS' }}
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                            <i class="fa-regular fa-envelope text-sm text-blue-600"></i>
                        </div>
                        <input type="email" name="email" value="{{ old('email') }}" required
                               placeholder="office@example.com"
                               class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/50 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3.5 {{ ($isArabic ?? false) ? 'pr-10 pl-4' : 'pl-10 pr-4' }} transition">
                    </div>
                </div>

                <div>
                    <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                        {{ ($isArabic ?? false) ? 'رقم الهاتف' : 'PHONE NUMBER' }}
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

            <!-- Row 3: Governorate & Address -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                        {{ ($isArabic ?? false) ? 'المحافظة' : 'GOVERNORATE' }}
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                            <i class="fa-solid fa-location-dot text-sm text-blue-600"></i>
                        </div>
                        <input type="text" name="governorate" value="{{ old('governorate', 'محافظة العاصمة') }}" required
                               placeholder="e.g. Al Asimah"
                               class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/50 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3.5 {{ ($isArabic ?? false) ? 'pr-10 pl-4' : 'pl-10 pr-4' }} transition">
                    </div>
                </div>

                <div>
                    <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                        {{ ($isArabic ?? false) ? 'العنوان التفصيلي' : 'ADDRESS' }}
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                            <i class="fa-solid fa-map-pin text-sm text-blue-600"></i>
                        </div>
                        <input type="text" name="address" value="{{ old('address') }}" required
                               placeholder="{{ ($isArabic ?? false) ? 'الشارع، المبنى، الدور' : 'Street, Bldg, Floor' }}"
                               class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/50 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3.5 {{ ($isArabic ?? false) ? 'pr-10 pl-4' : 'pl-10 pr-4' }} transition">
                    </div>
                </div>
            </div>

            <!-- Row 4: Password -->
            <div>
                <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                    {{ ($isArabic ?? false) ? 'كلمة المرور' : 'PASSWORD' }}
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

            <!-- Agreement Box matching Screenshot 2 -->
            <div class="p-4 rounded-2xl bg-blue-50/60 border border-blue-200/80 text-slate-700">
                <label class="flex items-start gap-3 cursor-pointer">
                    <input type="checkbox" name="agree_terms" value="1" required
                           class="mt-1 w-4 h-4 rounded text-blue-600 border-slate-300 focus:ring-blue-500">
                    <span class="text-xs font-medium leading-relaxed">
                        @if($isArabic ?? false)
                            أوافق على <span class="font-bold text-blue-700">الشروط والأحكام الخاصة بمكاتب الطباعة</span>، وأتحمل المسؤولية القانونية والأخلاقية الكاملة عن صحة ودقة جميع بيانات ومستندات السير الذاتية المرفوعة.
                        @else
                            I agree to the <span class="font-bold text-blue-700">Terms and Conditions for Typing Offices</span>, and assume full legal and moral responsibility for the correctness and accuracy of all uploaded candidate profiles and documents.
                        @endif
                    </span>
                </label>
            </div>

            <!-- Submit Button (Royal Blue Theme) -->
            <div class="pt-2">
                <button type="submit"
                        class="w-full py-4 rounded-2xl bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-black text-sm shadow-md shadow-blue-500/25 transition transform active:scale-[0.99] flex items-center justify-center gap-2">
                    <span>{{ ($isArabic ?? false) ? 'إنشاء الحساب وإرسال الطلب' : 'Create Account & Submit' }}</span>
                </button>
            </div>

        </form>

        <!-- Sign in Link -->
        <div class="text-center pt-6 mt-6 border-t border-slate-100 text-xs text-slate-500 font-medium">
            <span>{{ ($isArabic ?? false) ? 'لديك حساب بالفعل؟' : 'Already have an office account?' }}</span>
            <a href="{{ route('affiliate.login') }}" class="font-black text-blue-600 hover:text-blue-800 {{ ($isArabic ?? false) ? 'mr-1' : 'ml-1' }}">
                {{ ($isArabic ?? false) ? 'تسجيل الدخول لمكتبك' : 'Sign in to your office' }}
            </a>
        </div>

    </div>

</div>
@endsection
