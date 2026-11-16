@extends('layouts.app')

@section('title', (($isArabic ?? false) ? $sector['name_ar'] : $sector['name_en']) . ' | Direct Work')

@section('content')
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 space-y-10">

    <!-- Sector Banner Hero Card -->
    <div class="relative rounded-3xl overflow-hidden h-64 sm:h-80 shadow-card border border-slate-200">
        <img src="{{ asset($sector['image']) }}" 
             alt="{{ $sector['name_en'] }}" 
             class="w-full h-full object-cover"
             onerror="this.src='/images/sectors/sector_construction.jpg'">
        <div class="absolute inset-0 bg-gradient-to-t from-slate-950 via-slate-950/60 to-transparent"></div>
        
        <div class="absolute bottom-6 {{ ($isArabic ?? false) ? 'right-6 left-6' : 'left-6 right-6' }} text-white max-w-3xl">
            <div class="inline-flex items-center px-3 py-1 rounded-full bg-blue-600/90 text-white text-xs font-bold uppercase tracking-wider mb-2">
                {{ ($isArabic ?? false) ? 'قطاع رسمي معتمد' : 'Official Market Sector' }}
            </div>
            <h1 class="text-3xl sm:text-5xl font-black">
                {{ ($isArabic ?? false) ? $sector['name_ar'] : $sector['name_en'] }}
            </h1>
            <div class="flex flex-wrap items-center gap-4 mt-3 text-xs sm:text-sm text-slate-300">
                <span><i class="fa-solid fa-list-check {{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}"></i> {{ count($sector['professions'] ?? []) }} {{ ($isArabic ?? false) ? 'مهنة متاحة' : 'Professions' }}</span>
                <span><i class="fa-solid fa-users {{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}"></i> {{ count($applicants) }} {{ ($isArabic ?? false) ? 'مرشح موثق' : 'Verified Candidates' }}</span>
                <span><i class="fa-solid fa-briefcase {{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}"></i> {{ count($jobs) }} {{ ($isArabic ?? false) ? 'وظيفة نشطة' : 'Active Vacancies' }}</span>
            </div>
        </div>
    </div>

    <!-- Sub-Sectors & Professions Grid -->
    <div class="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-soft">
        <div class="flex items-center justify-between mb-6 pb-4 border-b border-slate-100">
            <div>
                <h2 class="text-xl font-bold text-slate-900">
                    {{ ($isArabic ?? false) ? 'المهن التخصصية داخل القطاع' : 'Specialized Professions' }}
                </h2>
                <p class="text-xs text-slate-500 mt-0.5">
                    {{ ($isArabic ?? false) ? 'انقر على أي مهنة للتقديم المباشر أو تصفح المرشحين' : 'Click any profession to apply or browse talent directly' }}
                </p>
            </div>
            <a href="{{ route('apply.index', ['sector' => $sector['code']]) }}" 
               class="px-4 py-2 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-bold text-xs shadow-md transition">
                <i class="fa-solid fa-plus-circle {{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}"></i>
                {{ ($isArabic ?? false) ? 'قدّم طلبك بهذا القطاع (' . $activeCountry['fee_display'] . ' ' . $activeCountry['currency_ar'] . ')' : 'Post CV Ad in Sector (' . $activeCountry['fee_display'] . ' ' . $activeCountry['currency_en'] . ')' }}
            </a>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
            @foreach($sector['professions'] ?? [] as $prof)
                <div class="p-3.5 rounded-xl border border-slate-200 hover:border-blue-400 hover:bg-blue-50/50 transition flex items-center justify-between group">
                    <div class="truncate {{ ($isArabic ?? false) ? 'ml-2' : 'mr-2' }}">
                        <div class="text-sm font-bold text-slate-800 group-hover:text-blue-700 truncate">
                            {{ ($isArabic ?? false) ? $prof['name_ar'] : $prof['name_en'] }}
                        </div>
                        <div class="text-[11px] text-slate-400 mt-0.5 truncate">
                            {{ $prof['subSector'] ?? 'General' }}
                        </div>
                    </div>
                    <a href="{{ route('apply.index', ['sector' => $sector['code'], 'profession' => ($isArabic ?? false ? $prof['name_ar'] : $prof['name_en'])]) }}" 
                       class="px-2.5 py-1 rounded-lg bg-slate-100 group-hover:bg-blue-600 text-slate-600 group-hover:text-white text-xs font-bold transition whitespace-nowrap">
                        {{ ($isArabic ?? false) ? 'تقديم' : 'Apply' }}
                    </a>
                </div>
            @endforeach
        </div>
    </div>

    <!-- Active Candidates in this Sector -->
    <div>
        <h2 class="text-2xl font-bold text-slate-900 mb-6 pb-3 border-b border-slate-200">
            {{ ($isArabic ?? false) ? 'المرشحون المعتمدون في هذا القطاع' : 'Active Candidates in this Sector' }}
        </h2>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            @forelse($applicants as $applicant)
                <div class="bg-white rounded-2xl border border-slate-200 shadow-soft p-5 hover:shadow-card transition flex flex-col justify-between">
                    <div>
                        <div class="flex items-start justify-between mb-3">
                            <div class="w-12 h-12 rounded-xl bg-blue-100 text-blue-700 font-bold flex items-center justify-center text-lg">
                                {{ mb_substr($applicant['name'], 0, 1) }}
                            </div>
                            <span class="text-[10px] font-bold px-2 py-0.5 rounded-full bg-emerald-50 text-emerald-700 border border-emerald-200">
                                {{ ($isArabic ?? false) ? 'موثق' : 'Verified' }}
                            </span>
                        </div>
                        <h3 class="text-base font-bold text-slate-900 truncate">{{ $applicant['name'] }}</h3>
                        <p class="text-xs font-semibold text-blue-600 truncate">{{ $applicant['profession'] }}</p>
                        <div class="mt-2 text-xs text-slate-500 space-y-1">
                            <div><i class="fa-solid fa-briefcase text-slate-400 w-4"></i> {{ $applicant['experience'] ?? '3 سنوات' }}</div>
                            <div><i class="fa-solid fa-location-dot text-slate-400 w-4"></i> {{ $applicant['governorate'] ?? $activeCountry['short_name_en'] }}</div>
                        </div>
                    </div>

                    <!-- 3 Action buttons -->
                    <div class="pt-4 mt-4 border-t border-slate-100 grid grid-cols-3 gap-2">
                        <a href="tel:{{ $applicant['phone'] ?? '+96566707126' }}" class="h-9 rounded-lg bg-orange-600 hover:bg-orange-700 text-white flex items-center justify-center transition">
                            <i class="fa-solid fa-phone text-xs"></i>
                        </a>
                        <a href="https://wa.me/{{ preg_replace('/[^0-9]/', '', $applicant['whatsapp'] ?? '96566707126') }}" target="_blank" class="h-9 rounded-lg bg-emerald-600 hover:bg-emerald-700 text-white flex items-center justify-center transition">
                            <i class="fa-brands fa-whatsapp text-base"></i>
                        </a>
                        <a href="{{ route('chats.show', $applicant['id']) }}" class="h-9 rounded-lg bg-blue-600 hover:bg-blue-700 text-white flex items-center justify-center transition">
                            <i class="fa-solid fa-comment-dots text-xs"></i>
                        </a>
                    </div>
                </div>
            @empty
                <div class="col-span-4 text-center py-12 bg-white rounded-2xl border border-slate-200">
                    <p class="text-sm text-slate-500">
                        {{ ($isArabic ?? false) ? 'كن أول من يقدم في هذا القطاع وينشر إعلانه الآن!' : 'Be the first to post your CV in this sector!' }}
                    </p>
                    <a href="{{ route('apply.index', ['sector' => $sector['code']]) }}" class="mt-3 inline-block px-4 py-2 bg-blue-600 text-white font-bold text-xs rounded-xl">
                        {{ ($isArabic ?? false) ? 'أضف إعلانك الآن' : 'Post Ad Now' }}
                    </a>
                </div>
            @endforelse
        </div>
    </div>

</div>
@endsection
