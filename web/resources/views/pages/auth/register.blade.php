@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'إنشاء حساب جديد | دايركت وورك' : 'Create Account | Direct Work')

@section('content')
<div class="max-w-xl mx-auto px-4 py-12">

    <div class="bg-white rounded-3xl p-8 border border-slate-200 shadow-card space-y-6">
        <div class="text-center space-y-2">
            <div class="w-14 h-14 rounded-2xl bg-blue-600 text-white font-black text-2xl flex items-center justify-center mx-auto shadow-md">
                DJ
            </div>
            <h1 class="text-2xl font-black text-slate-900">
                {{ ($isArabic ?? false) ? 'إنشاء حساب جديد' : 'Create New Account' }}
            </h1>
            <p class="text-xs text-slate-500">
                {{ ($isArabic ?? false) ? 'انضم إلى المنصة الرائدة للتوظيف في الشرق الأوسط' : 'Join the premier job platform in the Middle East' }}
            </p>
        </div>

        <!-- Account Type Switcher -->
        <div class="flex items-center p-1 bg-slate-100 rounded-2xl text-xs font-bold" id="roleTabs">
            <button type="button" onclick="switchRole('applicant')" id="tabApplicant"
                    class="flex-1 py-2.5 rounded-xl transition text-center {{ ($role ?? 'applicant') === 'applicant' ? 'bg-white shadow text-blue-600' : 'text-slate-600 hover:text-slate-900' }}">
                <i class="fa-solid fa-user {{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}"></i>
                {{ ($isArabic ?? false) ? 'باحث عن عمل' : 'Job Seeker' }}
            </button>
            <button type="button" onclick="switchRole('company')" id="tabCompany"
                    class="flex-1 py-2.5 rounded-xl transition text-center {{ ($role ?? 'applicant') === 'company' ? 'bg-white shadow text-blue-600' : 'text-slate-600 hover:text-slate-900' }}">
                <i class="fa-solid fa-building {{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}"></i>
                {{ ($isArabic ?? false) ? 'شركة / صاحب عمل' : 'Company / Employer' }}
            </button>
        </div>

        <form action="{{ route('register.post') }}" method="POST" class="space-y-4">
            @csrf
            <input type="hidden" name="role" id="roleInput" value="{{ $role ?? 'applicant' }}">

            <!-- Full Name -->
            <div>
                <label class="block text-xs font-bold text-slate-700 mb-1">
                    {{ ($isArabic ?? false) ? 'الاسم الكامل' : 'Full Name' }} <span class="text-red-500">*</span>
                </label>
                <input type="text" name="full_name" value="{{ old('full_name') }}" required
                       placeholder="{{ ($isArabic ?? false) ? 'أدخل اسمك الكامل' : 'Enter your full name' }}"
                       class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
            </div>

            <!-- Company specific fields -->
            <div id="companyFields" class="{{ ($role ?? 'applicant') === 'company' ? '' : 'hidden' }} space-y-4">
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">
                        {{ ($isArabic ?? false) ? 'اسم المنشأة أو الشركة' : 'Company Name' }} <span class="text-red-500">*</span>
                    </label>
                    <input type="text" name="company_name" value="{{ old('company_name') }}"
                           placeholder="{{ ($isArabic ?? false) ? 'أدخل الاسم التجاري المسجل' : 'Enter registered company name' }}"
                           class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                </div>

                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">
                        {{ ($isArabic ?? false) ? 'رقم السجل التجاري / الترخيص' : 'Commercial License Number' }} <span class="text-red-500">*</span>
                    </label>
                    <input type="text" name="commercial_license" value="{{ old('commercial_license') }}"
                           placeholder="{{ ($isArabic ?? false) ? 'مثال: 2024/99120' : 'e.g. 2024/99120' }}"
                           class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                </div>
            </div>

            <!-- Contact Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">
                        {{ ($isArabic ?? false) ? 'البريد الإلكتروني' : 'Email Address' }} <span class="text-red-500">*</span>
                    </label>
                    <input type="email" name="email" value="{{ old('email') }}" required
                           placeholder="name@example.com"
                           class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                </div>
                <div>
                    <label class="block text-xs font-bold text-slate-700 mb-1">
                        {{ ($isArabic ?? false) ? 'رقم الهاتف (واتساب)' : 'Phone Number (WhatsApp)' }} <span class="text-red-500">*</span>
                    </label>
                    <div class="flex items-center dir-ltr">
                        <span class="inline-flex items-center px-3 rounded-l-xl border border-r-0 border-slate-300 bg-slate-50 text-slate-600 text-xs font-bold">
                            {{ $activeCountry['phone_code'] ?? '+965' }}
                        </span>
                        <input type="tel" name="phone" value="{{ old('phone') }}" required
                               placeholder="12345678"
                               class="w-full text-xs rounded-r-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
                    </div>
                </div>
            </div>

            <!-- Governorate / Region -->
            <div>
                <label class="block text-xs font-bold text-slate-700 mb-1">
                    {{ ($isArabic ?? false) ? ($activeCountry['governorate_label_ar'] ?? 'المحافظة') : ($activeCountry['governorate_label_en'] ?? 'Region / Governorate') }} <span class="text-red-500">*</span>
                </label>
                <select name="governorate" required
                        class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3 bg-white">
                    <option value="">{{ ($isArabic ?? false) ? '-- اختر المنطقة --' : '-- Select Region --' }}</option>
                    @foreach($activeCountry['governorates'] ?? [] as $gov)
                        <option value="{{ $gov['id'] }}" {{ old('governorate') === $gov['id'] ? 'selected' : '' }}>
                            {{ ($isArabic ?? false) ? $gov['name_ar'] : $gov['name_en'] }}
                        </option>
                    @endforeach
                </select>
            </div>

            <!-- Password -->
            <div>
                <label class="block text-xs font-bold text-slate-700 mb-1">
                    {{ ($isArabic ?? false) ? 'كلمة المرور' : 'Password' }} <span class="text-red-500">*</span>
                </label>
                <input type="password" name="password" required minlength="6"
                       placeholder="•••••••• (6+ characters)"
                       class="w-full text-xs rounded-xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 p-3">
            </div>

            <div class="pt-3">
                <button type="submit" 
                        class="w-full py-3.5 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-extrabold text-sm shadow-md transition">
                    {{ ($isArabic ?? false) ? 'إتمام التسجيل والدخول' : 'Complete Registration' }}
                </button>
            </div>
        </form>

        <div class="text-center pt-4 border-t border-slate-100 text-xs text-slate-500">
            <span>{{ ($isArabic ?? false) ? 'لديك حساب بالفعل؟' : 'Already have an account?' }}</span>
            <a href="{{ route('login') }}" class="font-bold text-blue-600 hover:text-blue-800 {{ ($isArabic ?? false) ? 'mr-1' : 'ml-1' }}">
                {{ ($isArabic ?? false) ? 'سجل دخولك الآن' : 'Sign In' }}
            </a>
        </div>
    </div>

</div>

<script>
function switchRole(role) {
    document.getElementById('roleInput').value = role;
    const tabApplicant = document.getElementById('tabApplicant');
    const tabCompany = document.getElementById('tabCompany');
    const companyFields = document.getElementById('companyFields');

    if (role === 'company') {
        tabCompany.className = "flex-1 py-2.5 rounded-xl transition text-center bg-white shadow text-blue-600";
        tabApplicant.className = "flex-1 py-2.5 rounded-xl transition text-center text-slate-600 hover:text-slate-900";
        companyFields.classList.remove('hidden');
    } else {
        tabApplicant.className = "flex-1 py-2.5 rounded-xl transition text-center bg-white shadow text-blue-600";
        tabCompany.className = "flex-1 py-2.5 rounded-xl transition text-center text-slate-600 hover:text-slate-900";
        companyFields.classList.add('hidden');
    }
}
</script>
@endsection
