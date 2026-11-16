@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'باقات الإعلانات والأسعار | دايركت وورك' : 'Pricing Plans & Packages | Direct Work')

@section('content')
<div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-12 space-y-12">

    <!-- Header -->
    <div class="text-center space-y-3 max-w-2xl mx-auto">
        <span class="px-3.5 py-1.5 rounded-full bg-blue-100 text-blue-800 text-xs font-bold inline-flex items-center">
            <span class="{{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}">{{ $activeCountry['flag'] }}</span>
            <span>{{ ($isArabic ?? false) ? 'أسعار وباقات ' . $activeCountry['name_ar'] : 'Official Packages for ' . $activeCountry['name_en'] }}</span>
        </span>
        <h1 class="text-3xl sm:text-4xl font-black text-slate-900">
            {{ ($isArabic ?? false) ? 'باقات مخصصة لتحقيق أعلى وصول مهني' : 'Simple, Transparent Career Pricing' }}
        </h1>
        <p class="text-sm text-slate-500">
            {{ ($isArabic ?? false) 
                ? 'اختر الخطة المناسبة لمهنتك وادفع بأمان عبر وسائل الدفع الوطنية المعتمدة.' 
                : 'Choose the ideal plan to get discovered and pay securely via authorized payment gateways.' }}
        </p>
    </div>

    <!-- Pricing Cards Grid -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        @foreach($packages as $plan)
            @php
                $isPopular = ($plan['id'] === 'plan_basic');
            @endphp
            <div class="rounded-3xl bg-white border {{ $isPopular ? 'border-2 border-blue-600 shadow-xl' : 'border-slate-200 shadow-soft' }} p-6 sm:p-8 flex flex-col justify-between relative">
                
                @if($isPopular)
                    <div class="absolute -top-3.5 {{ ($isArabic ?? false) ? 'left-6' : 'right-6' }}">
                        <span class="px-3 py-1 rounded-full bg-blue-600 text-white text-[10px] font-extrabold uppercase tracking-wider shadow-sm">
                            {{ ($isArabic ?? false) ? $plan['badge'] : $plan['badge_en'] }}
                        </span>
                    </div>
                @endif

                <div>
                    <h3 class="text-lg font-bold text-slate-900">
                        {{ ($isArabic ?? false) ? $plan['title_ar'] : $plan['title_en'] }}
                    </h3>

                    <div class="mt-4 flex items-baseline">
                        <span class="text-4xl font-black text-slate-900">{{ $plan['price_display'] }}</span>
                        <span class="text-xs font-bold text-slate-500 {{ ($isArabic ?? false) ? 'mr-2' : 'ml-2' }}">
                            {{ ($isArabic ?? false) ? $plan['currency_ar'] : $plan['currency'] }}
                        </span>
                        <span class="text-xs text-slate-400 {{ ($isArabic ?? false) ? 'mr-1' : 'ml-1' }}">/ 3 {{ ($isArabic ?? false) ? 'أشهر' : 'Months' }}</span>
                    </div>

                    <ul class="mt-6 pt-6 border-t border-slate-100 space-y-3 text-xs text-slate-600">
                        @foreach($plan['features'] as $feat)
                            <li class="flex items-start">
                                <i class="fa-solid fa-check text-blue-600 mt-0.5 {{ ($isArabic ?? false) ? 'ml-2' : 'mr-2' }}"></i>
                                <span>{{ $feat }}</span>
                            </li>
                        @endforeach
                    </ul>
                </div>

                <div class="pt-8">
                    <a href="{{ route('apply.index') }}" 
                       class="w-full py-3.5 rounded-xl font-bold text-xs text-center block transition {{ $isPopular ? 'bg-blue-600 hover:bg-blue-700 text-white shadow-md' : 'bg-slate-100 hover:bg-slate-200 text-slate-800' }}">
                        {{ ($isArabic ?? false) ? 'اختيار هذه الباقة' : 'Select Plan' }}
                    </a>
                </div>

            </div>
        @endforeach
    </div>

    <!-- Security & Guarantee Notice -->
    <div class="bg-blue-50 border border-blue-200 rounded-3xl p-6 sm:p-8 flex flex-col sm:flex-row items-center justify-between gap-4">
        <div class="flex items-center space-x-4 {{ ($isArabic ?? false) ? 'space-x-reverse' : '' }}">
            <div class="w-12 h-12 rounded-2xl bg-blue-600 text-white flex items-center justify-center text-xl">
                <i class="fa-solid fa-shield-halved"></i>
            </div>
            <div>
                <h4 class="text-sm font-bold text-slate-900">
                    {{ ($isArabic ?? false) ? 'دفع إلكتروني آمن ومضمون 100%' : '100% Secure Authorized Checkout' }}
                </h4>
                <p class="text-xs text-slate-600 mt-0.5">
                    {{ ($isArabic ?? false) 
                        ? 'نظام الدفع متوافق مع شبكات الدفع الخليجية K-Net و Mada وبطاقات الائتمان.' 
                        : 'Fully compliant with K-Net, Mada, Visa, and Mastercard payment networks.' }}
                </p>
            </div>
        </div>

        <a href="https://wa.me/96566707126" target="_blank" 
           class="px-5 py-2.5 rounded-xl bg-white hover:bg-slate-50 text-slate-800 font-bold text-xs border border-slate-200 transition shadow-sm whitespace-nowrap">
            <i class="fa-brands fa-whatsapp text-emerald-600 {{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}"></i>
            {{ ($isArabic ?? false) ? 'استفسار عن الباقات' : 'Inquire on WhatsApp' }}
        </a>
    </div>

</div>
@endsection
