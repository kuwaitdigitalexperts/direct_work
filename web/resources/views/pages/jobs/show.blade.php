@extends('layouts.app')

@section('title', $job['title'] . ' | ' . $job['company_name'] . ' | Direct Work')

@section('content')
<div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10 space-y-8">

    <div>
        <a href="{{ route('jobs.index') }}" class="inline-flex items-center text-xs font-bold text-slate-500 hover:text-blue-600 transition">
            <i class="fa-solid {{ ($isArabic ?? false) ? 'fa-arrow-right ml-1.5' : 'fa-arrow-left mr-1.5' }}"></i>
            <span>{{ ($isArabic ?? false) ? 'العودة لفرص العمل' : 'Back to Job Openings' }}</span>
        </a>
    </div>

    <!-- Job Header Card -->
    <div class="bg-white rounded-3xl p-6 sm:p-10 border border-slate-200 shadow-card space-y-6">
        <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-6 border-b border-slate-100">
            <div>
                <div class="inline-flex items-center text-xs font-bold px-3 py-1 rounded-full bg-blue-50 text-blue-700 border border-blue-100 mb-2">
                    {{ $job['sector_name'] ?? 'General' }}
                </div>
                <h1 class="text-2xl sm:text-3xl font-black text-slate-900">
                    {{ $job['title'] }}
                </h1>
                <div class="text-sm font-bold text-slate-500 mt-1">
                    {{ $job['company_name'] }}
                </div>
            </div>

            <div class="text-start sm:text-end">
                <div class="text-xs text-slate-400 font-semibold">{{ ($isArabic ?? false) ? 'الراتب المقترح' : 'Salary' }}</div>
                <div class="text-2xl font-black text-blue-700">
                    {{ $job['salary_kwd'] ?? $job['salary_amount'] ?? 0 }} {{ $activeCountry['currency_en'] }}
                </div>
            </div>
        </div>

        <!-- Info Badges -->
        <div class="grid grid-cols-2 sm:grid-cols-4 gap-4">
            <div class="p-4 rounded-2xl bg-slate-50 border border-slate-100">
                <div class="text-xs text-slate-400">{{ ($isArabic ?? false) ? 'الموقع' : 'Location' }}</div>
                <div class="text-sm font-bold text-slate-800 mt-1">{{ $job['governorate_name'] ?? $activeCountry['name_en'] }}</div>
            </div>
            <div class="p-4 rounded-2xl bg-slate-50 border border-slate-100">
                <div class="text-xs text-slate-400">{{ ($isArabic ?? false) ? 'نوع الدوام' : 'Work Type' }}</div>
                <div class="text-sm font-bold text-slate-800 mt-1 uppercase">{{ $job['work_type'] ?? 'full_time' }}</div>
            </div>
            <div class="p-4 rounded-2xl bg-slate-50 border border-slate-100">
                <div class="text-xs text-slate-400">{{ ($isArabic ?? false) ? 'السوق الإقليمي' : 'Regional Market' }}</div>
                <div class="text-sm font-bold text-slate-800 mt-1">{{ $activeCountry['flag'] }} {{ $activeCountry['name_en'] }}</div>
            </div>
            <div class="p-4 rounded-2xl bg-slate-50 border border-slate-100">
                <div class="text-xs text-slate-400">{{ ($isArabic ?? false) ? 'تاريخ النشر' : 'Published' }}</div>
                <div class="text-sm font-bold text-slate-800 mt-1">{{ date('d M Y', strtotime($job['created_at'] ?? 'now')) }}</div>
            </div>
        </div>

        <!-- Description -->
        <div class="space-y-3">
            <h2 class="text-base font-bold text-slate-900">{{ ($isArabic ?? false) ? 'الوصف الوظيفي' : 'Job Description' }}</h2>
            <div class="p-5 rounded-2xl bg-slate-50 text-sm text-slate-700 leading-relaxed border border-slate-200">
                {{ $job['description'] }}
            </div>
        </div>

        <!-- Requirements -->
        @if(!empty($job['requirements']) && is_array($job['requirements']))
            <div class="space-y-3">
                <h2 class="text-base font-bold text-slate-900">{{ ($isArabic ?? false) ? 'الشروط والمتطلبات' : 'Requirements' }}</h2>
                <ul class="space-y-2 text-sm text-slate-700">
                    @foreach($job['requirements'] as $req)
                        <li class="flex items-start">
                            <i class="fa-solid fa-check text-emerald-500 mt-1 {{ ($isArabic ?? false) ? 'ml-2.5' : 'mr-2.5' }}"></i>
                            <span>{{ $req }}</span>
                        </li>
                    @endforeach
                </ul>
            </div>
        @endif

        <!-- Action CTAs -->
        <div class="pt-6 border-t border-slate-200 flex flex-col sm:flex-row items-center gap-4">
            <a href="https://wa.me/{{ preg_replace('/[^0-9]/', '', $job['whatsapp_number'] ?? '96566707126') }}?text={{ urlencode('مرحباً، أود التقديم على وظيفة: ' . $job['title']) }}" 
               target="_blank" 
               class="w-full sm:w-auto flex-grow h-13 py-3.5 px-6 rounded-2xl bg-emerald-600 hover:bg-emerald-700 text-white font-bold text-sm flex items-center justify-center shadow-lg shadow-emerald-500/20 transition">
                <i class="fa-brands fa-whatsapp text-xl {{ ($isArabic ?? false) ? 'ml-2' : 'mr-2' }}"></i>
                <span>{{ ($isArabic ?? false) ? 'التقديم والتواصل عبر الواتساب' : 'Apply via WhatsApp' }}</span>
            </a>

            @if(!empty($job['phone_number']))
                <a href="tel:{{ $job['phone_number'] }}" 
                   class="w-full sm:w-auto h-13 py-3.5 px-6 rounded-2xl bg-orange-600 hover:bg-orange-700 text-white font-bold text-sm flex items-center justify-center shadow-lg shadow-orange-500/20 transition">
                    <i class="fa-solid fa-phone {{ ($isArabic ?? false) ? 'ml-2' : 'mr-2' }}"></i>
                    <span>{{ ($isArabic ?? false) ? 'اتصال مباشر' : 'Call' }}</span>
                </a>
            @endif
        </div>

    </div>

</div>
@endsection
