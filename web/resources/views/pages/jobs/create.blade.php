@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'نشر إعلان وظيفة شاغرة | دايركت وورك' : 'Post a Job Vacancy | Direct Work')

@section('content')
<div class="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-10 space-y-8">

    <div class="text-center space-y-2">
        <span class="px-3 py-1 rounded-full bg-blue-100 text-blue-800 text-xs font-bold">
            {{ $activeCountry['flag'] }} {{ $activeCountry['name_en'] }}
        </span>
        <h1 class="text-3xl font-black text-slate-900">
            {{ ($isArabic ?? false) ? 'أعلن عن فرصة عمل شاغرة' : 'Post a Job Vacancy' }}
        </h1>
        <p class="text-sm text-slate-500 max-w-lg mx-auto">
            {{ ($isArabic ?? false) 
                ? 'استقطب أمهر الكفاءات والكوادر المهنية المتواجدة داخل ' . $activeCountry['name_ar'] . ' مباشرة وبدون وسيط.' 
                : 'Directly attract top talent and professionals residing inside ' . $activeCountry['name_en'] . '.' }}
        </p>
    </div>

    <div class="bg-white rounded-3xl p-6 sm:p-10 border border-slate-200 shadow-card">
        <form action="{{ route('jobs.store') }}" method="POST" class="space-y-6">
            @csrf

            <!-- Job Title -->
            <div>
                <label class="block text-xs font-bold text-slate-700 mb-1">
                    {{ ($isArabic ?? false) ? 'المسمى الوظيفي *' : 'Job Title *' }}
                </label>
                <input type="text" name="title" value="{{ old('title') }}" required
                       placeholder="{{ ($isArabic ?? false) ? 'مثال: فني تكييف مركزي، ممرض عام، محاسب مالي...' : 'e.g. HVAC Technician, General Nurse, Accountant...' }}"
                       class="w-full text-sm rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
            </div>

            <!-- Company Name -->
            <div>
                <label class="block text-xs font-bold text-slate-700 mb-1">
                    {{ ($isArabic ?? false) ? 'اسم الشركة أو المنشأة *' : 'Company or Employer Name *' }}
                </label>
                <input type="text" name="company_name" value="{{ old('company_name') }}" required
                       placeholder="{{ ($isArabic ?? false) ? 'اسم شركتك أو المؤسسة' : 'Your company name' }}"
                       class="w-full text-sm rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
            </div>

            <!-- Sector & Governorate -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">
                        {{ ($isArabic ?? false) ? 'القطاع التخصصي *' : 'Sector *' }}
                    </label>
                    <select name="sector_code" required class="w-full text-sm rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                        @foreach($sectors as $sec)
                            <option value="{{ $sec['code'] }}" {{ old('sector_code') === $sec['code'] ? 'selected' : '' }}>
                                {{ ($isArabic ?? false) ? $sec['name_ar'] : $sec['name_en'] }}
                            </option>
                        @endforeach
                    </select>
                </div>

                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">
                        {{ ($isArabic ?? false) ? 'المحافظة / الإمارة *' : 'Governorate / Region *' }}
                    </label>
                    <select name="governorate_id" required class="w-full text-sm rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                        @foreach($activeCountry['regions'] as $reg)
                            <option value="{{ $reg['id'] }}" {{ old('governorate_id') === $reg['id'] ? 'selected' : '' }}>
                                {{ ($isArabic ?? false) ? $reg['name_ar'] : $reg['name_en'] }}
                            </option>
                        @endforeach
                    </select>
                </div>
            </div>

            <!-- Salary & Work Type -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">
                        {{ ($isArabic ?? false) ? 'الراتب المقترح (' . $activeCountry['currency_en'] . ')' : 'Salary (' . $activeCountry['currency_en'] . ')' }}
                    </label>
                    <input type="number" name="salary" value="{{ old('salary') }}" step="1"
                           placeholder="0"
                           class="w-full text-sm rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                </div>

                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">
                        {{ ($isArabic ?? false) ? 'نوع الدوام *' : 'Work Type *' }}
                    </label>
                    <select name="work_type" required class="w-full text-sm rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                        <option value="full_time">{{ ($isArabic ?? false) ? 'دوام كامل' : 'Full Time' }}</option>
                        <option value="part_time">{{ ($isArabic ?? false) ? 'دوام جزئي' : 'Part Time' }}</option>
                        <option value="contract">{{ ($isArabic ?? false) ? 'عقد مشروع' : 'Contract' }}</option>
                    </select>
                </div>
            </div>

            <!-- Description -->
            <div>
                <label class="block text-xs font-bold text-slate-700 mb-1">
                    {{ ($isArabic ?? false) ? 'الوصف الوظيفي والمهام *' : 'Job Description & Duties *' }}
                </label>
                <textarea name="description" rows="4" required
                          placeholder="{{ ($isArabic ?? false) ? 'صف متطلبات العمل ومسؤوليات الوظيفة...' : 'Describe the responsibilities and scope...' }}"
                          class="w-full text-sm rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">{{ old('description') }}</textarea>
            </div>

            <!-- Requirements -->
            <div>
                <label class="block text-xs font-bold text-slate-700 mb-1">
                    {{ ($isArabic ?? false) ? 'الشروط والمؤهلات (سطر لكل شرط)' : 'Requirements (one per line)' }}
                </label>
                <textarea name="requirements" rows="3"
                          placeholder="{{ ($isArabic ?? false) ? 'مثال:\nخبرة لا تقل عن سنتين\nإقامة قابلة للتحويل' : 'e.g.\nAt least 2 years experience\nTransferable residency' }}"
                          class="w-full text-sm rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">{{ old('requirements') }}</textarea>
            </div>

            <!-- Contact Numbers -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">
                        {{ ($isArabic ?? false) ? 'رقم الواتساب للتواصل *' : 'WhatsApp Number *' }}
                    </label>
                    <input type="text" name="whatsapp_number" value="{{ old('whatsapp_number') }}" required
                           placeholder="{{ $activeCountry['phone_code'] }} ..."
                           class="w-full text-sm rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                </div>

                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">
                        {{ ($isArabic ?? false) ? 'هاتف الاتصال (اختياري)' : 'Contact Phone (Optional)' }}
                    </label>
                    <input type="text" name="phone_number" value="{{ old('phone_number') }}"
                           placeholder="{{ $activeCountry['phone_code'] }} ..."
                           class="w-full text-sm rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                </div>
            </div>

            <div class="pt-4">
                <button type="submit" 
                        class="w-full py-4 rounded-2xl bg-blue-600 hover:bg-blue-700 text-white font-extrabold text-base shadow-lg shadow-blue-500/25 transition">
                    <i class="fa-solid fa-paper-plane {{ ($isArabic ?? false) ? 'ml-2' : 'mr-2' }}"></i>
                    {{ ($isArabic ?? false) ? 'نشر الإعلان الوظيفي فوراً' : 'Publish Vacancy Now' }}
                </button>
            </div>

        </form>
    </div>

</div>
@endsection
