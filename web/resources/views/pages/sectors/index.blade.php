@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'جميع القطاعات الـ 27 | دايركت وورك' : 'All 27 Sectors | Direct Work')

@section('content')
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 space-y-8">
    
    <!-- Header -->
    <div class="flex flex-col md:flex-row md:items-end justify-between pb-6 border-b border-slate-200">
        <div>
            <div class="inline-flex items-center text-xs font-bold text-blue-600 uppercase tracking-wider mb-1">
                <i class="fa-solid fa-shapes {{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}"></i>
                {{ ($isArabic ?? false) ? 'الدليل المهني الشامل' : 'Comprehensive Career Directory' }}
            </div>
            <h1 class="text-3xl sm:text-4xl font-black text-slate-900">
                {{ ($isArabic ?? false) ? 'قطاعات التوظيف المعتمدة (27 قطاعاً)' : 'Official Job Sectors (27 Sectors)' }}
            </h1>
            <p class="text-sm text-slate-500 mt-2 max-w-xl">
                {{ ($isArabic ?? false) 
                    ? 'اختر القطاع الذي تبحث عن كوادر فيه أو ترغب في نشر إعلانك المهني داخله.' 
                    : 'Choose the sector where you want to hire candidates or publish your verified application.' }}
            </p>
        </div>

        <!-- Search input -->
        <div class="mt-4 md:mt-0 w-full md:w-80">
            <form action="{{ route('sectors.index') }}" method="GET" class="relative flex items-center bg-white p-1.5 rounded-xl border border-slate-300 shadow-sm">
                <i class="fa-solid fa-magnifying-glass text-slate-400 text-sm {{ ($isArabic ?? false) ? 'mr-3' : 'ml-3' }}"></i>
                <input type="text" name="q" value="{{ $q ?? '' }}" 
                       placeholder="{{ ($isArabic ?? false) ? 'ابحث عن قطاع...' : 'Filter sectors...' }}" 
                       class="w-full bg-transparent border-0 text-xs text-slate-800 placeholder-slate-400 focus:outline-none focus:ring-0">
                <button type="submit" class="px-3 py-1.5 bg-blue-600 text-white rounded-lg text-xs font-bold">
                    {{ ($isArabic ?? false) ? 'بحث' : 'Filter' }}
                </button>
            </form>
        </div>
    </div>

    <!-- Sectors Grid -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        @foreach($sectors as $sector)
            <div class="group rounded-2xl overflow-hidden bg-white border border-slate-200 shadow-soft hover:shadow-card transition flex flex-col justify-between">
                <a href="{{ route('sectors.show', $sector['code']) }}" class="block overflow-hidden relative h-48">
                    <img src="{{ asset($sector['image']) }}" 
                         alt="{{ $sector['name_en'] }}" 
                         class="w-full h-full object-cover group-hover:scale-105 transition duration-500 ease-out"
                         onerror="this.src='/images/sectors/sector_construction.jpg'">
                    <div class="absolute inset-0 bg-gradient-to-t from-slate-950/80 via-slate-900/20 to-transparent"></div>
                    <div class="absolute bottom-3 {{ ($isArabic ?? false) ? 'right-4 left-4' : 'left-4 right-4' }}">
                        <span class="inline-block px-2 py-0.5 rounded-md bg-blue-600/90 text-white text-[10px] font-bold uppercase tracking-wider mb-1">
                            {{ $sector['code'] }}
                        </span>
                        <h3 class="text-lg font-bold text-white group-hover:text-blue-300 transition">
                            {{ ($isArabic ?? false) ? $sector['name_ar'] : $sector['name_en'] }}
                        </h3>
                    </div>
                </a>

                <div class="p-4 bg-white flex items-center justify-between border-t border-slate-100 text-xs">
                    <span class="font-semibold text-slate-500">
                        {{ count($sector['professions'] ?? []) }} {{ ($isArabic ?? false) ? 'مهنة تخصصية' : 'Professions' }}
                    </span>
                    <a href="{{ route('apply.index', ['sector' => $sector['code']]) }}" 
                       class="px-3 py-1.5 rounded-lg bg-blue-50 text-blue-700 hover:bg-blue-600 hover:text-white font-bold transition">
                        {{ ($isArabic ?? false) ? 'أضف إعلانك بهذا القطاع' : 'Apply in Sector' }}
                    </a>
                </div>
            </div>
        @endforeach
    </div>

</div>
@endsection
