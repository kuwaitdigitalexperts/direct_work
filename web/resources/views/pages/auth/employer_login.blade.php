@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'تسجيل دخول أصحاب العمل والشركات | دايركت وورك' : 'Employer Sign In | Direct Work')

@section('content')
<div class="min-h-[80vh] flex flex-col justify-center items-center px-4 py-12">
    
    <!-- Back to Home Link -->
    <div class="w-full max-w-md mb-6 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }}">
        <a href="{{ route('home') }}" class="inline-flex items-center gap-2 text-xs font-bold text-slate-500 hover:text-blue-600 transition">
            <i class="fa-solid fa-arrow-left text-[10px] {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
            <span>{{ ($isArabic ?? false) ? 'العودة للرئيسية' : 'Back to Home' }}</span>
        </a>
    </div>

    <!-- Employer Login Header -->
    <div class="text-center space-y-2 mb-8">
        <div class="flex items-center justify-center gap-2">
            <div class="w-10 h-10 rounded-2xl bg-gradient-to-br from-blue-700 to-blue-900 text-white flex items-center justify-center text-lg shadow-md shadow-blue-600/30">
                <i class="fa-solid fa-building"></i>
            </div>
            <h1 class="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight">
                {{ ($isArabic ?? false) ? 'تسجيل دخول أصحاب العمل' : 'Employer Portal Login' }}
            </h1>
        </div>
        <p class="text-xs sm:text-sm font-semibold text-slate-500 max-w-sm mx-auto">
            {{ ($isArabic ?? false) ? 'سجل دخولك لاستعراض الكفاءات والتواصل المباشر مع المرشحين' : 'Sign in to access verified candidate profiles and hire top talent directly' }}
        </p>
    </div>

    <!-- Login Card Container -->
    <div class="w-full max-w-md bg-white rounded-3xl p-6 sm:p-8 border border-slate-200/90 shadow-card">
        
        @if ($errors->any())
            <div class="mb-5 p-3.5 rounded-2xl bg-red-50 border border-red-200 text-red-700 text-xs font-semibold space-y-1">
                @foreach ($errors->all() as $error)
                    <div class="flex items-center gap-1.5">
                        <i class="fa-solid fa-circle-exclamation text-xs"></i>
                        <span>{{ $error }}</span>
                    </div>
                @endforeach
            </div>
        @endif

        @if (session('success'))
            <div class="mb-5 p-3.5 rounded-2xl bg-emerald-50 border border-emerald-200 text-emerald-700 text-xs font-semibold flex items-center gap-2">
                <i class="fa-solid fa-circle-check text-xs"></i>
                <span>{{ session('success') }}</span>
            </div>
        @endif

        <form action="{{ route('employer.login.post') }}" method="POST" class="space-y-5">
            @csrf

            <!-- Email Address or Phone Field -->
            <div>
                <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                    {{ ($isArabic ?? false) ? 'البريد الإلكتروني أو رقم الهاتف' : 'CORPORATE EMAIL OR PHONE' }}
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                        <i class="fa-regular fa-envelope text-sm text-blue-600"></i>
                    </div>
                    <input type="text" name="credential" value="{{ old('credential') }}" required autofocus
                           placeholder="hr@company.com / +965 xxxx xxxx"
                           class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/50 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3.5 {{ ($isArabic ?? false) ? 'pr-10 pl-4' : 'pl-10 pr-4' }} transition">
                </div>
            </div>

            <!-- Password Field -->
            <div>
                <div class="flex items-center justify-between mb-2">
                    <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase">
                        {{ ($isArabic ?? false) ? 'كلمة المرور' : 'PASSWORD' }}
                    </label>
                    <a href="{{ route('support') }}" class="text-[11px] font-bold text-blue-600 hover:text-blue-700 transition">
                        {{ ($isArabic ?? false) ? 'نسيت كلمة المرور؟' : 'Forgot Password?' }}
                    </a>
                </div>
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
                        class="w-full py-3.5 rounded-2xl bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-black text-sm shadow-md shadow-blue-500/25 transition transform active:scale-[0.99] flex items-center justify-center gap-2">
                    <i class="fa-solid fa-arrow-right-to-bracket text-xs"></i>
                    <span>{{ ($isArabic ?? false) ? 'تسجيل الدخول لبوابة الشركات' : 'Sign In to Employer Portal' }}</span>
                </button>
            </div>

        </form>

        <!-- Register Company Link -->
        <div class="text-center pt-6 mt-6 border-t border-slate-100 text-xs text-slate-500 font-medium">
            <span>{{ ($isArabic ?? false) ? 'شركة جديدة؟' : 'New employer?' }}</span>
            <a href="{{ route('employer.register') }}" class="font-black text-blue-600 hover:text-blue-800 {{ ($isArabic ?? false) ? 'mr-1' : 'ml-1' }}">
                {{ ($isArabic ?? false) ? 'سجل شركتك الآن' : 'Register your company' }}
            </a>
        </div>

        <!-- Office Portal Link Switcher -->
        <div class="mt-4 p-3 rounded-2xl bg-slate-50 border border-slate-200 text-center text-[11px] text-slate-600 font-medium flex items-center justify-between">
            <span class="flex items-center gap-1.5">
                <i class="fa-solid fa-print text-blue-600"></i>
                <span>{{ ($isArabic ?? false) ? 'مكتب طباعة وتوظيف؟' : 'Typing & Affiliate Office?' }}</span>
            </span>
            <a href="{{ route('affiliate.login') }}" class="font-bold text-blue-700 hover:underline">
                {{ ($isArabic ?? false) ? 'دخول المكاتب' : 'Office Portal →' }}
            </a>
        </div>

    </div>

</div>
@endsection
