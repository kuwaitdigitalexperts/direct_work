@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'الوظائف الشاغرة | دايركت وورك' : 'Job Vacancies | Direct Work')

@section('content')
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 space-y-8">

    <!-- Header & Post Job Button -->
    <div class="flex flex-col sm:flex-row sm:items-center justify-between pb-6 border-b border-slate-200">
        <div>
            <div class="inline-flex items-center text-xs font-bold text-indigo-600 uppercase tracking-wider mb-1">
                <i class="fa-solid fa-briefcase {{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}"></i>
                {{ ($isArabic ?? false) ? 'سوق العمل الفعلي' : 'Active Career Market' }}
            </div>
            <h1 class="text-3xl font-black text-slate-900">
                {{ ($isArabic ?? false) ? 'فرص العمل والوظائف الشاغرة في ' . $activeCountry['name_ar'] : 'Active Job Openings in ' . $activeCountry['name_en'] }}
            </h1>
        </div>

        <div class="mt-4 sm:mt-0">
            <a href="{{ route('jobs.create') }}" class="inline-flex items-center px-4 py-2.5 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-bold text-xs shadow-md transition">
                <i class="fa-solid fa-plus {{ ($isArabic ?? false) ? 'ml-2' : 'mr-2' }}"></i>
                {{ ($isArabic ?? false) ? 'أعلن عن شاغر وظيفي' : 'Post a Job Vacancy' }}
            </a>
        </div>
    </div>

    <!-- Filter Form -->
    <div class="bg-white rounded-2xl p-5 border border-slate-200 shadow-soft">
        <form action="{{ route('jobs.index') }}" method="GET" class="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <div>
                <input type="text" name="search" value="{{ $filters['search'] ?? '' }}" 
                       placeholder="{{ ($isArabic ?? false) ? 'ابحث باسم الوظيفة أو الشركة...' : 'Search by job title or company...' }}"
                       class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-2.5">
            </div>

            <div>
                <select name="sector" class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-2.5">
                    <option value="all">{{ ($isArabic ?? false) ? 'جميع القطاعات' : 'All Sectors' }}</option>
                    @foreach($sectors as $sec)
                        <option value="{{ $sec['code'] }}" {{ ($filters['sector'] ?? '') === $sec['code'] ? 'selected' : '' }}>
                            {{ ($isArabic ?? false) ? $sec['name_ar'] : $sec['name_en'] }}
                        </option>
                    @endforeach
                </select>
            </div>

            <div class="flex items-center space-x-2 {{ ($isArabic ?? false) ? 'space-x-reverse' : '' }}">
                <button type="submit" class="flex-grow py-2.5 bg-blue-600 hover:bg-blue-700 text-white font-bold text-xs rounded-xl transition">
                    {{ ($isArabic ?? false) ? 'بحث' : 'Filter' }}
                </button>
                <a href="{{ route('jobs.index') }}" class="py-2.5 px-3 bg-slate-100 text-slate-700 font-bold text-xs rounded-xl">
                    {{ ($isArabic ?? false) ? 'إعادة ضبط' : 'Reset' }}
                </a>
            </div>
        </form>
    </div>

    <!-- Jobs Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        @forelse($jobs as $job)
            <div class="bg-white rounded-2xl border border-slate-200 shadow-soft p-5 hover:shadow-card transition flex flex-col justify-between">
                <div>
                    <div class="flex items-start justify-between mb-2">
                        <span class="text-xs font-bold px-2.5 py-1 rounded-lg bg-blue-50 text-blue-700 border border-blue-100">
                            {{ $job['sector_name'] ?? 'General' }}
                        </span>
                        @if(!empty($job['is_pinned']))
                            <span class="text-[10px] font-bold px-2 py-0.5 rounded-full bg-amber-100 text-amber-800 flex items-center">
                                <i class="fa-solid fa-thumbtack {{ ($isArabic ?? false) ? 'ml-1' : 'mr-1' }}"></i>
                                {{ ($isArabic ?? false) ? 'مثبت' : 'Pinned' }}
                            </span>
                        @endif
                    </div>

                    <h3 class="text-base font-bold text-slate-900 mt-2 line-clamp-1">
                        <a href="{{ route('jobs.show', $job['id']) }}" class="hover:text-blue-600 transition">
                            {{ $job['title'] }}
                        </a>
                    </h3>
                    <p class="text-xs text-slate-500 font-semibold truncate mt-0.5">
                        {{ $job['company_name'] }}
                    </p>

                    <p class="text-xs text-slate-600 line-clamp-2 mt-3 bg-slate-50 p-2 rounded-xl">
                        {{ $job['description'] ?? '' }}
                    </p>

                    <div class="mt-4 pt-3 border-t border-slate-100 space-y-1.5 text-xs text-slate-600">
                        <div class="flex items-center justify-between">
                            <span class="text-slate-400">{{ ($isArabic ?? false) ? 'الراتب المعروض:' : 'Offered Salary:' }}</span>
                            <span class="font-bold text-blue-700">
                                {{ $job['salary_kwd'] ?? $job['salary_amount'] ?? 0 }} {{ $activeCountry['currency_en'] }}
                            </span>
                        </div>
                        <div class="flex items-center justify-between">
                            <span class="text-slate-400">{{ ($isArabic ?? false) ? 'المحافظة / الإمارة:' : 'Location:' }}</span>
                            <span class="font-medium text-slate-700">{{ $job['governorate_name'] ?? $activeCountry['short_name_en'] }}</span>
                        </div>
                    </div>
                </div>

                <div class="pt-4 mt-4 border-t border-slate-100 flex items-center space-x-2 {{ ($isArabic ?? false) ? 'space-x-reverse' : '' }}">
                    <a href="{{ route('jobs.show', $job['id']) }}" class="flex-grow py-2 rounded-xl bg-slate-900 hover:bg-slate-800 text-white font-bold text-xs text-center transition">
                        {{ ($isArabic ?? false) ? 'التفاصيل والتقديم' : 'View & Apply' }}
                    </a>
                    <a href="https://wa.me/{{ preg_replace('/[^0-9]/', '', $job['whatsapp_number'] ?? '96566707126') }}" target="_blank" 
                       class="w-9 h-9 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white flex items-center justify-center transition">
                        <i class="fa-brands fa-whatsapp"></i>
                    </a>
                </div>
            </div>
        @empty
            <div class="col-span-3 text-center py-16 bg-white rounded-3xl border border-slate-200">
                <i class="fa-solid fa-briefcase text-4xl text-slate-300 mb-2"></i>
                <h3 class="text-base font-bold text-slate-800">{{ ($isArabic ?? false) ? 'لا توجد شواغر مطابقة حالياً' : 'No jobs found matching criteria' }}</h3>
                <a href="{{ route('jobs.create') }}" class="mt-4 inline-block px-4 py-2 bg-blue-600 text-white font-bold text-xs rounded-xl">
                    {{ ($isArabic ?? false) ? 'أضف أول فرصة عمل الآن' : 'Post New Job' }}
                </a>
            </div>
        @endforelse
    </div>

</div>
@endsection
