@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'قائمة المرشحين والكفاءات | دايركت وورك' : 'Verified Candidates Pool | Direct Work')

@section('content')
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10 space-y-8">

    <!-- Page Title & Search Bar -->
    <div class="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-soft">
        <div class="max-w-3xl">
            <div class="inline-flex items-center text-xs font-bold text-emerald-600 uppercase tracking-wider mb-1">
                <i class="fa-solid fa-users {{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}"></i>
                {{ ($isArabic ?? false) ? 'قاعدة بيانات الكفاءات المعتمدة' : 'Verified Talent Directory' }}
            </div>
            <h1 class="text-3xl font-black text-slate-900">
                {{ ($isArabic ?? false) ? 'تصفح المرشحين والكوادر المتاحة' : 'Discover Verified Candidates' }}
            </h1>
            <p class="text-sm text-slate-500 mt-1">
                {{ ($isArabic ?? false) 
                    ? 'تواصل مباشرة وفورياً مع أصحاب المهن والكوادر المقيمة في ' . $activeCountry['name_ar'] . ' عبر الاتصال المباشر، الواتساب، أو المحادثة الفورية.'
                    : 'Connect directly with certified job seekers residing in ' . $activeCountry['name_en'] . ' via Direct Call, WhatsApp, or In-App Chat.' }}
            </p>
        </div>

        <!-- Filter Form -->
        <form action="{{ route('applicants.index') }}" method="GET" class="mt-6 pt-6 border-t border-slate-100 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            
            <!-- Search Keyword -->
            <div>
                <label class="block text-xs font-bold text-slate-700 mb-1.5">
                    {{ ($isArabic ?? false) ? 'البحث بالاسم أو المهنة' : 'Name or Profession' }}
                </label>
                <div class="relative">
                    <input type="text" name="search" value="{{ $filters['search'] ?? '' }}" 
                           placeholder="{{ ($isArabic ?? false) ? 'اكتب مهنة أو اسم...' : 'Search by title...' }}" 
                           class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-2.5">
                </div>
            </div>

            <!-- Sector Filter -->
            <div>
                <label class="block text-xs font-bold text-slate-700 mb-1.5">
                    {{ ($isArabic ?? false) ? 'القطاع' : 'Sector' }}
                </label>
                <select name="sector" class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-2.5">
                    <option value="all">{{ ($isArabic ?? false) ? 'جميع القطاعات الـ 27' : 'All 27 Sectors' }}</option>
                    @foreach($sectors as $sec)
                        <option value="{{ $sec['code'] }}" {{ ($filters['sector'] ?? '') === $sec['code'] ? 'selected' : '' }}>
                            {{ ($isArabic ?? false) ? $sec['name_ar'] : $sec['name_en'] }}
                        </option>
                    @endforeach
                </select>
            </div>

            <!-- Governorate / Region Filter -->
            <div>
                <label class="block text-xs font-bold text-slate-700 mb-1.5">
                    {{ ($isArabic ?? false) ? 'المحافظة / الإمارة' : 'Governorate / Region' }}
                </label>
                <select name="governorate" class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-2.5">
                    <option value="all">{{ ($isArabic ?? false) ? 'كافة المناطق' : 'All Regions' }}</option>
                    @foreach($activeCountry['regions'] as $reg)
                        <option value="{{ $reg['id'] }}" {{ ($filters['governorate'] ?? '') === $reg['id'] ? 'selected' : '' }}>
                            {{ ($isArabic ?? false) ? $reg['name_ar'] : $reg['name_en'] }}
                        </option>
                    @endforeach
                </select>
            </div>

            <!-- Filter Buttons -->
            <div class="flex items-end space-x-2 {{ ($isArabic ?? false) ? 'space-x-reverse' : '' }}">
                <button type="submit" class="flex-grow py-2.5 px-4 bg-blue-600 hover:bg-blue-700 text-white font-bold text-xs rounded-xl transition shadow-md">
                    <i class="fa-solid fa-filter {{ ($isArabic ?? false) ? 'ml-1' : 'mr-1' }}"></i>
                    {{ ($isArabic ?? false) ? 'تطبيق الفلتر' : 'Apply Filter' }}
                </button>
                <a href="{{ route('applicants.index') }}" class="py-2.5 px-3 bg-slate-100 hover:bg-slate-200 text-slate-700 font-bold text-xs rounded-xl transition text-center">
                    {{ ($isArabic ?? false) ? 'إعادة ضبط' : 'Reset' }}
                </a>
            </div>

        </form>
    </div>

    <!-- Results Header -->
    <div class="flex items-center justify-between text-xs text-slate-500 px-2">
        <span>{{ count($applicants) }} {{ ($isArabic ?? false) ? 'مرشح معتمد متطابق مع البحث' : 'matching verified candidates' }}</span>
        <span>{{ ($isArabic ?? false) ? 'يتم التحديث فورياً' : 'Live Real-Time Directory' }}</span>
    </div>

    <!-- Candidates Grid -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        @forelse($applicants as $applicant)
            <div class="bg-white rounded-2xl border border-slate-200 shadow-soft hover:shadow-card transition flex flex-col justify-between p-5">
                <div>
                    <!-- Header: Photo & Verified Badge -->
                    <div class="flex items-start justify-between mb-3">
                        <div class="w-14 h-14 rounded-2xl bg-blue-100 border border-blue-200 overflow-hidden flex items-center justify-center text-blue-700 font-extrabold text-xl shadow-sm">
                            @if(!empty($applicant['photo_url']))
                                <img src="{{ asset($applicant['photo_url']) }}" alt="{{ $applicant['name'] }}" class="w-full h-full object-cover">
                            @else
                                {{ mb_substr($applicant['name'], 0, 1) }}
                            @endif
                        </div>
                        <span class="inline-flex items-center text-[10px] font-bold px-2 py-0.5 rounded-full bg-emerald-50 text-emerald-700 border border-emerald-200">
                            <i class="fa-solid fa-circle-check {{ ($isArabic ?? false) ? 'ml-1' : 'mr-1' }}"></i>
                            {{ ($isArabic ?? false) ? 'موثق' : 'Verified' }}
                        </span>
                    </div>

                    <!-- Name & Profession -->
                    <h3 class="text-base font-bold text-slate-900 truncate">
                        <a href="{{ route('applicants.show', $applicant['id']) }}" class="hover:text-blue-600 transition">
                            {{ $applicant['name'] }}
                        </a>
                    </h3>
                    <p class="text-xs font-semibold text-blue-600 truncate mt-0.5">
                        {{ $applicant['profession'] }}
                    </p>

                    <!-- Details -->
                    <div class="mt-3 space-y-1.5 text-xs text-slate-500">
                        <div class="flex items-center">
                            <i class="fa-solid fa-briefcase w-4 text-slate-400"></i>
                            <span class="{{ ($isArabic ?? false) ? 'mr-1.5' : 'ml-1.5' }} font-medium">{{ $applicant['experience'] ?? '3 سنوات' }}</span>
                        </div>
                        <div class="flex items-center">
                            <i class="fa-solid fa-location-dot w-4 text-slate-400"></i>
                            <span class="{{ ($isArabic ?? false) ? 'mr-1.5' : 'ml-1.5' }} font-medium truncate">{{ $applicant['governorate'] ?? $activeCountry['name_en'] }}</span>
                        </div>
                        <div class="flex items-center">
                            <i class="fa-solid fa-globe w-4 text-slate-400"></i>
                            <span class="{{ ($isArabic ?? false) ? 'mr-1.5' : 'ml-1.5' }} font-medium">{{ $applicant['nationality'] ?? 'كويتي' }}</span>
                        </div>
                    </div>

                    @if(!empty($applicant['bio']))
                        <p class="text-xs text-slate-600 line-clamp-2 mt-3 bg-slate-50 p-2 rounded-xl border border-slate-100">
                            {{ $applicant['bio'] }}
                        </p>
                    @endif
                </div>

                <!-- 3 PILL ACTION BUTTONS -->
                <div class="pt-4 mt-4 border-t border-slate-100">
                    <div class="grid grid-cols-3 gap-2">
                        <!-- Direct Call Button (Warm Orange) -->
                        <a href="tel:{{ $applicant['phone'] ?? '+96566707126' }}" 
                           title="{{ ($isArabic ?? false) ? 'اتصال هاتفي' : 'Phone Call' }}"
                           class="h-10 rounded-xl bg-orange-600 hover:bg-orange-700 text-white flex items-center justify-center transition shadow-sm hover:shadow">
                            <i class="fa-solid fa-phone text-sm"></i>
                        </a>

                        <!-- WhatsApp Button (Emerald Green) -->
                        <a href="https://wa.me/{{ preg_replace('/[^0-9]/', '', $applicant['whatsapp'] ?? $applicant['phone'] ?? '96566707126') }}" 
                           target="_blank"
                           title="WhatsApp"
                           class="h-10 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white flex items-center justify-center transition shadow-sm hover:shadow">
                            <i class="fa-brands fa-whatsapp text-lg"></i>
                        </a>

                        <!-- In-App Chat Button (Royal Blue) -->
                        <a href="{{ route('chats.show', $applicant['id']) }}" 
                           title="{{ ($isArabic ?? false) ? 'محادثة مباشرة' : 'In-App Chat' }}"
                           class="h-10 rounded-xl bg-blue-600 hover:bg-blue-700 text-white flex items-center justify-center transition shadow-sm hover:shadow">
                            <i class="fa-solid fa-comment-dots text-sm"></i>
                        </a>
                    </div>
                </div>

            </div>
        @empty
            <div class="col-span-4 text-center py-16 bg-white rounded-3xl border border-slate-200">
                <i class="fa-solid fa-users-slash text-4xl text-slate-300 mb-3"></i>
                <h3 class="text-lg font-bold text-slate-800">{{ ($isArabic ?? false) ? 'لم يتم العثور على مرشحين' : 'No candidates found' }}</h3>
                <p class="text-xs text-slate-500 mt-1 max-w-sm mx-auto">
                    {{ ($isArabic ?? false) ? 'جرب تغيير خيارات الفلتر أو البحث عن مهنة أخرى.' : 'Try adjusting your search criteria or resetting filters.' }}
                </p>
                <a href="{{ route('applicants.index') }}" class="mt-4 inline-block px-4 py-2 bg-blue-600 text-white font-bold text-xs rounded-xl">
                    {{ ($isArabic ?? false) ? 'إعادة ضبط الفلاتر' : 'Reset Filters' }}
                </a>
            </div>
        @endforelse
    </div>

</div>
@endsection
