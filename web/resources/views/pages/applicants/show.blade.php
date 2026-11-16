@extends('layouts.app')

@section('title', $applicant['name'] . ' | ' . $applicant['profession'] . ' | Direct Work')

@section('content')
<div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10 space-y-8">

    <!-- Top Breadcrumb / Back button -->
    <div>
        <a href="{{ route('applicants.index') }}" class="inline-flex items-center text-xs font-bold text-slate-500 hover:text-blue-600 transition">
            <i class="fa-solid {{ ($isArabic ?? false) ? 'fa-arrow-right ml-1.5' : 'fa-arrow-left mr-1.5' }}"></i>
            <span>{{ ($isArabic ?? false) ? 'العودة لقائمة المرشحين' : 'Back to Candidates' }}</span>
        </a>
    </div>

    <!-- Candidate Main Card (Matching Mobile Screen Structure) -->
    <div class="bg-white rounded-3xl border border-slate-200 shadow-card overflow-hidden">
        
        <!-- Top Branded Banner with DJ Logo (Matches Mobile Header) -->
        <div class="h-44 bg-gradient-to-r from-orange-500 to-amber-500 relative flex items-center justify-center">
            <div class="w-20 h-20 rounded-2xl bg-white/20 backdrop-blur-md border border-white/30 flex items-center justify-center text-white font-black text-3xl shadow-lg">
                DJ
            </div>
            <div class="absolute top-4 {{ ($isArabic ?? false) ? 'right-4' : 'left-4' }}">
                <span class="px-3 py-1 rounded-full bg-black/20 text-white text-xs font-bold backdrop-blur-sm">
                    {{ $activeCountry['flag'] }} {{ $applicant['governorate'] ?? $activeCountry['name_en'] }}
                </span>
            </div>
        </div>

        <div class="p-6 sm:p-10 space-y-8">
            
            <!-- Name & Profession -->
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-6 border-b border-slate-100">
                <div>
                    <div class="flex items-center space-x-2 {{ ($isArabic ?? false) ? 'space-x-reverse' : '' }}">
                        <h1 class="text-2xl sm:text-3xl font-black text-slate-900">
                            {{ $applicant['name'] }}
                        </h1>
                        <span class="inline-flex items-center text-xs font-bold px-2.5 py-0.5 rounded-full bg-emerald-50 text-emerald-700 border border-emerald-200">
                            <i class="fa-solid fa-circle-check {{ ($isArabic ?? false) ? 'ml-1' : 'mr-1' }}"></i>
                            {{ ($isArabic ?? false) ? 'ملف موثق' : 'Verified' }}
                        </span>
                    </div>
                    <div class="flex items-center text-sm font-semibold text-blue-600 mt-1">
                        <i class="fa-solid fa-briefcase {{ ($isArabic ?? false) ? 'ml-2' : 'mr-2' }} text-amber-500"></i>
                        <span>{{ $applicant['profession'] }}</span>
                    </div>
                </div>

                <div class="flex items-center gap-3">
                    <span class="text-xs text-slate-400">
                        <i class="fa-regular fa-eye {{ ($isArabic ?? false) ? 'ml-1' : 'mr-1' }}"></i>
                        {{ $applicant['views'] ?? 140 }} {{ ($isArabic ?? false) ? 'مشاهدة' : 'views' }}
                    </span>
                </div>
            </div>

            <!-- Key Details Grid -->
            <div class="grid grid-cols-2 sm:grid-cols-4 gap-4">
                <div class="p-4 rounded-2xl bg-slate-50 border border-slate-100">
                    <div class="text-xs text-slate-400 font-semibold">{{ ($isArabic ?? false) ? 'سنوات الخبرة' : 'Experience' }}</div>
                    <div class="text-base font-bold text-slate-800 mt-1">{{ $applicant['experience'] ?? '3 سنوات' }}</div>
                </div>
                <div class="p-4 rounded-2xl bg-slate-50 border border-slate-100">
                    <div class="text-xs text-slate-400 font-semibold">{{ ($isArabic ?? false) ? 'الجنسية' : 'Nationality' }}</div>
                    <div class="text-base font-bold text-slate-800 mt-1">{{ $applicant['nationality'] ?? 'كويتي' }}</div>
                </div>
                <div class="p-4 rounded-2xl bg-slate-50 border border-slate-100">
                    <div class="text-xs text-slate-400 font-semibold">{{ ($isArabic ?? false) ? 'الموقع الحالي' : 'Location' }}</div>
                    <div class="text-base font-bold text-slate-800 mt-1 truncate">{{ $applicant['governorate'] ?? $activeCountry['short_name_en'] }}</div>
                </div>
                <div class="p-4 rounded-2xl bg-slate-50 border border-slate-100">
                    <div class="text-xs text-slate-400 font-semibold">{{ ($isArabic ?? false) ? 'نوع التواجد' : 'Residence' }}</div>
                    <div class="text-base font-bold text-emerald-600 mt-1">
                        {{ ($applicant['location_type'] ?? 'inside') === 'inside' ? (($isArabic ?? false) ? 'داخل الدولة' : 'Inside Market') : (($isArabic ?? false) ? 'خارج الدولة' : 'Outside') }}
                    </div>
                </div>
            </div>

            <!-- Bio Card -->
            <div class="space-y-3">
                <h2 class="text-base font-bold text-slate-900">
                    {{ ($isArabic ?? false) ? 'نبذة تعريفية وخبرات مهنية' : 'Professional Summary & Bio' }}
                </h2>
                <div class="p-5 rounded-2xl bg-slate-50 border border-slate-200 text-sm text-slate-700 leading-relaxed">
                    {{ !empty($applicant['bio']) ? $applicant['bio'] : (($isArabic ?? false) ? 'لا توجد نبذة إضافية مسجلة.' : 'No additional bio provided.') }}
                </div>
            </div>

            <!-- Attachments & Resume (CV) Card (Matches Mobile) -->
            <div class="space-y-3">
                <h2 class="text-base font-bold text-slate-900">
                    {{ ($isArabic ?? false) ? 'المرفقات والسيرة الذاتية' : 'Attachments & Documents' }}
                </h2>
                
                <div class="p-4 rounded-2xl border border-slate-200 bg-slate-50 flex items-center justify-between">
                    <div class="flex items-center space-x-3 {{ ($isArabic ?? false) ? 'space-x-reverse' : '' }}">
                        <div class="w-11 h-11 rounded-xl bg-blue-100 text-blue-700 flex items-center justify-center text-lg">
                            <i class="fa-solid fa-file-pdf"></i>
                        </div>
                        <div>
                            <div class="text-sm font-bold text-slate-800">
                                {{ ($isArabic ?? false) ? 'السيرة الذاتية الرسمية (CV)' : 'Resume / Curriculum Vitae' }}
                            </div>
                            <div class="text-xs text-slate-400 mt-0.5">
                                {{ !empty($applicant['cv_path']) ? basename($applicant['cv_path']) : (($isArabic ?? false) ? 'ملف مرفق معتمد' : 'Verified Attachment File') }}
                            </div>
                        </div>
                    </div>

                    @if(!empty($applicant['cv_path']))
                        <a href="{{ asset('uploads/cvs/' . $applicant['cv_path']) }}" target="_blank" 
                           class="px-4 py-2 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-bold text-xs transition">
                            <i class="fa-solid fa-download {{ ($isArabic ?? false) ? 'ml-1' : 'mr-1' }}"></i>
                            {{ ($isArabic ?? false) ? 'تحميل السيرة' : 'Download CV' }}
                        </a>
                    @else
                        <span class="text-xs font-semibold text-slate-400 bg-slate-200 px-3 py-1.5 rounded-lg">
                            {{ ($isArabic ?? false) ? 'متاحة للشركات' : 'Employer Access Only' }}
                        </span>
                    @endif
                </div>
            </div>

            <!-- THE 3 MODERN ACTION BUTTONS (Direct Call, WhatsApp, Chat) -->
            <div class="pt-6 border-t border-slate-200">
                <div class="text-center text-xs font-semibold text-slate-500 mb-3">
                    {{ ($isArabic ?? false) ? 'تواصل فوري ومباشر مع المرشح:' : 'Direct and immediate contact with candidate:' }}
                </div>
                
                <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                    <!-- 1. Direct Phone Call (Warm Orange) -->
                    <a href="tel:{{ $applicant['phone'] ?? '+96566707126' }}" 
                       class="h-14 rounded-2xl bg-gradient-to-r from-orange-500 to-orange-600 hover:from-orange-600 hover:to-orange-700 text-white font-bold text-sm flex items-center justify-center shadow-lg shadow-orange-500/20 transition transform hover:-translate-y-0.5">
                        <i class="fa-solid fa-phone text-lg {{ ($isArabic ?? false) ? 'ml-2' : 'mr-2' }}"></i>
                        <span>{{ ($isArabic ?? false) ? 'اتصال مباشر' : 'Direct Call' }}</span>
                    </a>

                    <!-- 2. WhatsApp Button (Emerald Green) -->
                    <a href="https://wa.me/{{ preg_replace('/[^0-9]/', '', $applicant['whatsapp'] ?? $applicant['phone'] ?? '96566707126') }}" 
                       target="_blank"
                       class="h-14 rounded-2xl bg-gradient-to-r from-emerald-500 to-emerald-600 hover:from-emerald-600 hover:to-emerald-700 text-white font-bold text-sm flex items-center justify-center shadow-lg shadow-emerald-500/20 transition transform hover:-translate-y-0.5">
                        <i class="fa-brands fa-whatsapp text-2xl {{ ($isArabic ?? false) ? 'ml-2' : 'mr-2' }}"></i>
                        <span>WhatsApp</span>
                    </a>

                    <!-- 3. In-App Chat Button (Royal Blue) -->
                    <a href="{{ route('chats.show', $applicant['id']) }}" 
                       class="h-14 rounded-2xl bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-bold text-sm flex items-center justify-center shadow-lg shadow-blue-500/20 transition transform hover:-translate-y-0.5">
                        <i class="fa-solid fa-comment-dots text-lg {{ ($isArabic ?? false) ? 'ml-2' : 'mr-2' }}"></i>
                        <span>{{ ($isArabic ?? false) ? 'محادثة فورية' : 'In-App Chat' }}</span>
                    </a>
                </div>
            </div>

        </div>
    </div>

</div>
@endsection
