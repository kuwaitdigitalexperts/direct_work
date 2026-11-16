@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'تقديم طلب توظيف ونشر إعلانك | دايركت وورك' : 'Post CV Application | Direct Work')

@section('content')
<div class="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-10 space-y-8">

    <!-- Header & Country Badge -->
    <div class="text-center space-y-2">
        <span class="inline-flex items-center px-3 py-1 rounded-full bg-blue-100 text-blue-800 text-xs font-bold">
            <span class="{{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}">{{ $activeCountry['flag'] }}</span>
            <span>{{ ($isArabic ?? false) ? 'سوق ' . $activeCountry['name_ar'] : $activeCountry['name_en'] . ' Market' }}</span>
        </span>
        <h1 class="text-3xl sm:text-4xl font-black text-slate-900">
            {{ ($isArabic ?? false) ? 'طلب التوظيف ونشر السيرة الذاتية' : 'Publish Your Verified Job Application' }}
        </h1>
        <p class="text-sm text-slate-500 max-w-lg mx-auto">
            {{ ($isArabic ?? false) 
                ? 'انشر ملفك المهني المعتمد ليظهر مباشرة لكبرى الشركات وأصحاب العمل في ' . $activeCountry['name_ar'] . ' لمدة 3 أشهر كاملة (90 يوماً).' 
                : 'Publish your professional profile directly to hiring companies in ' . $activeCountry['name_en'] . ' for 3 full months (90 days).' }}
        </p>
    </div>

    <div class="bg-white rounded-3xl p-6 sm:p-10 border border-slate-200 shadow-card">
        <form action="{{ route('apply.store') }}" method="POST" enctype="multipart/form-data" class="space-y-8" id="applicationForm">
            @csrf

            <!-- CARD 1: Sector & Profession -->
            <div class="space-y-4">
                <div class="flex items-center space-x-2 {{ ($isArabic ?? false) ? 'space-x-reverse' : '' }} pb-3 border-b border-slate-100">
                    <div class="w-7 h-7 rounded-lg bg-blue-600 text-white font-black text-xs flex items-center justify-center">1</div>
                    <h2 class="text-base font-bold text-slate-900">
                        {{ ($isArabic ?? false) ? 'القطاع والمسمى المهني' : 'Sector & Profession' }}
                    </h2>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <!-- Sector Selector -->
                    <div>
                        <label class="block text-xs font-bold text-slate-700 mb-1.5">
                            {{ ($isArabic ?? false) ? 'القطاع التخصصي *' : 'Specialized Sector *' }}
                        </label>
                        <select name="sector" id="sectorSelect" required class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                            @foreach($sectors as $sec)
                                <option value="{{ $sec['code'] }}" {{ $selectedSector === $sec['code'] ? 'selected' : '' }} data-professions="{{ json_encode($sec['professions'] ?? []) }}">
                                    {{ ($isArabic ?? false) ? $sec['name_ar'] : $sec['name_en'] }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    <!-- Profession -->
                    <div>
                        <label class="block text-xs font-bold text-slate-700 mb-1.5">
                            {{ ($isArabic ?? false) ? 'المسمى المهني / الوظيفة *' : 'Profession Title *' }}
                        </label>
                        <input type="text" name="profession" id="professionInput" value="{{ old('profession', $selectedProfession) }}" required
                               placeholder="{{ ($isArabic ?? false) ? 'مثال: نجار، كهربائي، ممرض، محاسب...' : 'e.g. Carpenter, Electrician, Nurse...' }}"
                               class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                    </div>
                </div>
            </div>

            <!-- CARD 2: Personal Information -->
            <div class="space-y-4">
                <div class="flex items-center space-x-2 {{ ($isArabic ?? false) ? 'space-x-reverse' : '' }} pb-3 border-b border-slate-100">
                    <div class="w-7 h-7 rounded-lg bg-blue-600 text-white font-black text-xs flex items-center justify-center">2</div>
                    <h2 class="text-base font-bold text-slate-900">
                        {{ ($isArabic ?? false) ? 'البيانات الشخصية والخبرات' : 'Personal Details & Experience' }}
                    </h2>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-xs font-bold text-slate-700 mb-1.5">
                            {{ ($isArabic ?? false) ? 'الاسم الكامل *' : 'Full Name *' }}
                        </label>
                        <input type="text" name="name" value="{{ old('name') }}" required
                               placeholder="{{ ($isArabic ?? false) ? 'الاسم الثلاثي' : 'Full Name' }}"
                               class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                    </div>

                    <div>
                        <label class="block text-xs font-bold text-slate-700 mb-1.5">
                            {{ ($isArabic ?? false) ? 'رقم الهاتف / الواتساب *' : 'Phone / WhatsApp *' }}
                        </label>
                        <input type="text" name="phone" value="{{ old('phone') }}" required
                               placeholder="{{ $activeCountry['phone_code'] }} ..."
                               class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                    </div>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <div>
                        <label class="block text-xs font-bold text-slate-700 mb-1.5">
                            {{ ($isArabic ?? false) ? 'المحافظة / الإمارة *' : 'Governorate / Region *' }}
                        </label>
                        <select name="governorate" required class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                            @foreach($activeCountry['regions'] as $reg)
                                <option value="{{ ($isArabic ?? false) ? $reg['name_ar'] : $reg['name_en'] }}">
                                    {{ ($isArabic ?? false) ? $reg['name_ar'] : $reg['name_en'] }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    <div>
                        <label class="block text-xs font-bold text-slate-700 mb-1.5">
                            {{ ($isArabic ?? false) ? 'الجنسية *' : 'Nationality *' }}
                        </label>
                        <select name="nationality" required class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                            @foreach($nationalities as $nat)
                                <option value="{{ ($isArabic ?? false) ? $nat['name_ar'] : $nat['name_en'] }}">
                                    {{ ($isArabic ?? false) ? $nat['name_ar'] : $nat['name_en'] }}
                                </option>
                            @endforeach
                        </select>
                    </div>

                    <div>
                        <label class="block text-xs font-bold text-slate-700 mb-1.5">
                            {{ ($isArabic ?? false) ? 'سنوات الخبرة *' : 'Experience Years *' }}
                        </label>
                        <input type="number" name="experience_years" value="{{ old('experience_years', 3) }}" min="0" max="40" required
                               class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                    </div>
                </div>

                <!-- Email -->
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1.5">
                        {{ ($isArabic ?? false) ? 'البريد الإلكتروني (اختياري)' : 'Email (Optional)' }}
                    </label>
                    <input type="email" name="email" value="{{ old('email') }}"
                           placeholder="example@mail.com"
                           class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                </div>

                <!-- Bio -->
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1.5">
                        {{ ($isArabic ?? false) ? 'نبذة عن مهاراتك وخبراتك *' : 'About Your Skills & Experience *' }}
                    </label>
                    <textarea name="bio" rows="3" required
                              placeholder="{{ ($isArabic ?? false) ? 'صف مهاراتك الفنية وأبرز المشاريع التي أنجزتها...' : 'Briefly describe your craft and work history...' }}"
                              class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">{{ old('bio') }}</textarea>
                </div>

                <!-- Attachments: CV Upload -->
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1.5">
                        {{ ($isArabic ?? false) ? 'السيرة الذاتية (CV / Resume) - PDF أو Word' : 'Upload Resume / CV (PDF or Word)' }}
                    </label>
                    <div class="p-4 border-2 border-dashed border-slate-300 rounded-2xl bg-slate-50 hover:bg-slate-100 transition text-center cursor-pointer relative">
                        <input type="file" name="cv_file" accept=".pdf,.doc,.docx" class="absolute inset-0 opacity-0 cursor-pointer w-full h-full">
                        <i class="fa-solid fa-cloud-arrow-up text-2xl text-blue-600 mb-2"></i>
                        <div class="text-xs font-bold text-slate-700">
                            {{ ($isArabic ?? false) ? 'انقر لاختيار ملف السيرة الذاتية' : 'Click to select your CV file' }}
                        </div>
                        <div class="text-[11px] text-slate-400 mt-1">PDF, DOC, DOCX (Max 10MB)</div>
                    </div>
                </div>
            </div>

            <!-- CARD 3: Country Pricing & Validity Plan (Matches Mobile Exactly!) -->
            <div class="space-y-4">
                <div class="flex items-center space-x-2 {{ ($isArabic ?? false) ? 'space-x-reverse' : '' }} pb-3 border-b border-slate-100">
                    <div class="w-7 h-7 rounded-lg bg-blue-600 text-white font-black text-xs flex items-center justify-center">3</div>
                    <h2 class="text-base font-bold text-slate-900">
                        {{ ($isArabic ?? false) ? 'مدة الصلاحية ورسوم الإعلان المعتمدة' : 'Visibility Duration & Ad Fee' }}
                    </h2>
                </div>

                <!-- Country Fee Box (2 KWD for Kuwait, 35 SAR for Saudi, 30 AED for UAE) -->
                <div class="p-5 rounded-2xl bg-blue-50 border-2 border-blue-200 flex items-center justify-between">
                    <div>
                        <div class="text-sm font-bold text-slate-900">
                            {{ ($isArabic ?? false) ? 'إعلان التوظيف الرسمي (صلاحية 3 أشهر)' : 'Official Job Application (3 Months Validity)' }}
                        </div>
                        <div class="text-xs text-slate-500 mt-0.5">
                            {{ ($isArabic ?? false) ? 'صالح لمدة 90 يوماً كاملاً ويحذف تلقائياً بعد 3 أشهر' : 'Active for 90 full days, auto-removed after 3 months' }}
                        </div>
                    </div>
                    <div class="text-end">
                        <div class="text-3xl font-black text-blue-700 leading-none">
                            {{ $activeCountry['fee_display'] }}
                        </div>
                        <div class="text-xs font-bold text-blue-700 mt-0.5">
                            {{ ($isArabic ?? false) ? $activeCountry['currency_ar'] : $activeCountry['currency_en'] }}
                        </div>
                    </div>
                </div>

                <!-- Payment Method Selection -->
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-2">
                        {{ ($isArabic ?? false) ? 'اختر وسيلة الدفع الإلكتروني المعتمدة:' : 'Select Authorized Payment Method:' }}
                    </label>

                    <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                        <label class="p-3.5 rounded-xl border border-slate-200 hover:border-blue-500 bg-white cursor-pointer flex items-center space-x-3 {{ ($isArabic ?? false) ? 'space-x-reverse' : '' }}">
                            <input type="radio" name="payment_method" value="knet" checked class="text-blue-600 focus:ring-blue-500">
                            <div>
                                <div class="text-xs font-bold text-slate-800">
                                    @if($activeCountry['id'] === 'sa')
                                        مدى (Mada)
                                    @elseif($activeCountry['id'] === 'ae')
                                        بطاقة مصرفية (Debit)
                                    @else
                                        كي نت (K-Net)
                                    @endif
                                </div>
                                <div class="text-[10px] text-slate-400">{{ ($isArabic ?? false) ? 'بطاقة السحب الآلي' : 'Debit Card' }}</div>
                            </div>
                        </label>

                        <label class="p-3.5 rounded-xl border border-slate-200 hover:border-blue-500 bg-white cursor-pointer flex items-center space-x-3 {{ ($isArabic ?? false) ? 'space-x-reverse' : '' }}">
                            <input type="radio" name="payment_method" value="card" class="text-blue-600 focus:ring-blue-500">
                            <div>
                                <div class="text-xs font-bold text-slate-800">Visa / Mastercard</div>
                                <div class="text-[10px] text-slate-400">{{ ($isArabic ?? false) ? 'بطاقة ائتمانية' : 'Credit Card' }}</div>
                            </div>
                        </label>

                        <label class="p-3.5 rounded-xl border border-slate-200 hover:border-blue-500 bg-white cursor-pointer flex items-center space-x-3 {{ ($isArabic ?? false) ? 'space-x-reverse' : '' }}">
                            <input type="radio" name="payment_method" value="apple_pay" class="text-blue-600 focus:ring-blue-500">
                            <div>
                                <div class="text-xs font-bold text-slate-800">Apple Pay</div>
                                <div class="text-[10px] text-slate-400">{{ ($isArabic ?? false) ? 'دفع فوري سريع' : 'Instant 1-Touch' }}</div>
                            </div>
                        </label>
                    </div>
                </div>
            </div>

            <!-- Submit CTA Button -->
            <div class="pt-4">
                <button type="submit" 
                        class="w-full py-4 rounded-2xl bg-gradient-to-r from-blue-700 to-blue-600 hover:from-blue-800 hover:to-blue-700 text-white font-extrabold text-base shadow-lg shadow-blue-500/25 transition transform hover:-translate-y-0.5">
                    <i class="fa-solid fa-lock {{ ($isArabic ?? false) ? 'ml-2' : 'mr-2' }} text-amber-300"></i>
                    <span>
                        {{ ($isArabic ?? false) 
                            ? 'المتابعة للدفع وتأكيد الإعلان (' . $activeCountry['fee_display'] . ' ' . $activeCountry['currency_ar'] . ')' 
                            : 'Proceed to Payment (' . $activeCountry['fee_display'] . ' ' . $activeCountry['currency_en'] . ')' }}
                    </span>
                </button>
                <p class="text-center text-[11px] text-slate-400 mt-2">
                    {{ ($isArabic ?? false) ? 'معاملة آمنة ومشفرة 256-Bit SSL وفق المعايير البنكية' : '256-Bit SSL Encrypted and Authorized Banking Checkout' }}
                </p>
            </div>

        </form>
    </div>

</div>
@endsection
