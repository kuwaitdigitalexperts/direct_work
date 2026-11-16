@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'تسجيل دخول مكاتب الطباعة والتوظيف | دايركت وورك' : 'Affiliate Office Login | Direct Work')

@section('content')
<div class="min-h-[80vh] flex flex-col justify-center items-center px-4 py-12">
    
    <!-- Back to Home Link -->
    <div class="w-full max-w-md mb-6 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }}">
        <a href="{{ route('home') }}" class="inline-flex items-center gap-2 text-xs font-bold text-slate-500 hover:text-blue-600 transition">
            <i class="fa-solid fa-arrow-left text-[10px] {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
            <span>{{ ($isArabic ?? false) ? 'العودة للرئيسية' : 'Back to Home' }}</span>
        </a>
    </div>

    <!-- Affiliate Office Login Header -->
    <div class="text-center space-y-2 mb-8">
        <div class="flex items-center justify-center gap-2">
            <div class="w-8 h-8 rounded-lg bg-blue-100 text-blue-700 flex items-center justify-center text-base">
                <i class="fa-solid fa-building-user"></i>
            </div>
            <h1 class="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight">
                {{ ($isArabic ?? false) ? 'تسجيل دخول مكاتب الطباعة' : 'Affiliate Office Login' }}
            </h1>
        </div>
        <p class="text-xs sm:text-sm font-semibold text-blue-600">
            {{ ($isArabic ?? false) ? 'سجل دخولك لتسجيل وإدارة السير الذاتية للباحثين عن عمل' : 'Sign in to register and manage job seeker CVs' }}
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

        <form action="{{ route('affiliate.login.post') }}" method="POST" class="space-y-5">
            @csrf

            <!-- Email Address Field -->
            <div>
                <label class="block text-[11px] font-black tracking-wider text-slate-800 uppercase mb-2">
                    {{ ($isArabic ?? false) ? 'البريد الإلكتروني' : 'EMAIL ADDRESS' }}
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 {{ ($isArabic ?? false) ? 'left-auto right-0 pr-3.5' : 'pl-3.5' }} flex items-center pointer-events-none text-slate-400">
                        <i class="fa-regular fa-envelope text-sm text-blue-600"></i>
                    </div>
                    <input type="email" name="email" value="{{ old('email') }}" required autofocus
                           placeholder="office@example.com"
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
                    <span>{{ ($isArabic ?? false) ? 'تسجيل الدخول' : 'Sign In' }}</span>
                </button>
            </div>

        </form>

        <!-- Register Office Link -->
        <div class="text-center pt-6 mt-6 border-t border-slate-100 text-xs text-slate-500 font-medium">
            <span>{{ ($isArabic ?? false) ? 'ليس لديك حساب مكتب طباعة؟' : "Don't have an office account?" }}</span>
            <a href="{{ route('affiliate.register') }}" class="font-black text-blue-600 hover:text-blue-800 {{ ($isArabic ?? false) ? 'mr-1' : 'ml-1' }}">
                {{ ($isArabic ?? false) ? 'سجل مكتبك الآن' : 'Register your office' }}
            </a>
        </div>

    </div>

</div>
@endsection
