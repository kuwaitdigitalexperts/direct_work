@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'تسجيل الدخول | دايركت وورك' : 'Sign In | Direct Work')

@section('content')
<div class="max-w-md mx-auto px-4 py-16">

    <div class="bg-white rounded-3xl p-8 border border-slate-200 shadow-card space-y-6">
        <div class="text-center space-y-2">
            <div class="w-14 h-14 rounded-2xl bg-blue-600 text-white font-black text-2xl flex items-center justify-center mx-auto shadow-md">
                DJ
            </div>
            <h1 class="text-2xl font-black text-slate-900">
                {{ ($isArabic ?? false) ? 'مرحباً بك مجدداً' : 'Welcome Back' }}
            </h1>
            <p class="text-xs text-slate-500">
                {{ ($isArabic ?? false) ? 'سجل دخولك للوصول إلى طلباتك وإعلاناتك' : 'Sign in to access your applications and ads' }}
            </p>
        </div>

        <form action="{{ route('login.post') }}" method="POST" class="space-y-4">
            @csrf

            <div>
                <label class="block text-xs font-bold text-slate-700 mb-1">
                    {{ ($isArabic ?? false) ? 'البريد الإلكتروني أو رقم الهاتف' : 'Email or Phone Number' }}
                </label>
                <input type="text" name="credential" value="{{ old('credential') }}" required
                       placeholder="{{ ($isArabic ?? false) ? 'أدخل بريدك أو رقم هاتفك' : 'Enter email or phone' }}"
                       class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
            </div>

            <div>
                <label class="block text-xs font-bold text-slate-700 mb-1">
                    {{ ($isArabic ?? false) ? 'كلمة المرور' : 'Password' }}
                </label>
                <input type="password" name="password" required
                       placeholder="••••••••"
                       class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
            </div>

            <div class="pt-2">
                <button type="submit" 
                        class="w-full py-3.5 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-extrabold text-sm shadow-md transition">
                    {{ ($isArabic ?? false) ? 'تسجيل الدخول' : 'Sign In' }}
                </button>
            </div>
        </form>

        <div class="text-center pt-4 border-t border-slate-100 text-xs text-slate-500">
            <span>{{ ($isArabic ?? false) ? 'ليس لديك حساب؟' : "Don't have an account?" }}</span>
            <a href="{{ route('register') }}" class="font-bold text-blue-600 hover:text-blue-800 {{ ($isArabic ?? false) ? 'mr-1' : 'ml-1' }}">
                {{ ($isArabic ?? false) ? 'أنشئ حساباً جديداً' : 'Create an Account' }}
            </a>
        </div>
    </div>

</div>
@endsection
