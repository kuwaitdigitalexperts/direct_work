@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'تم تأكيد التقديم بنجاح | دايركت وورك' : 'Application Confirmed | Direct Work')

@section('content')
<div class="max-w-2xl mx-auto px-4 sm:px-6 lg:px-8 py-16 text-center">

    <div class="bg-white rounded-3xl p-8 sm:p-12 border border-slate-200 shadow-card space-y-6">
        
        <!-- Big Checkmark -->
        <div class="w-20 h-20 rounded-full bg-emerald-100 text-emerald-600 flex items-center justify-center text-4xl mx-auto shadow-inner">
            <i class="fa-solid fa-check"></i>
        </div>

        <div>
            <h1 class="text-2xl sm:text-3xl font-black text-slate-900">
                {{ ($isArabic ?? false) ? 'تم تأكيد الدفع والتقديم بنجاح!' : 'Payment & Application Confirmed!' }}
            </h1>
            <p class="text-sm text-slate-600 mt-2 max-w-md mx-auto">
                {{ ($isArabic ?? false)
                    ? 'تم استلام الرسوم بقيمة ' . $activeCountry['fee_display'] . ' ' . $activeCountry['currency_ar'] . ' وإضافة إعلانك في قطاع (' . ($applicant['sector'] ?? 'المهني') . '). إعلانك مرئي لأصحاب العمل لمدة 3 أشهر كاملة.'
                    : 'Fee of ' . $activeCountry['fee_display'] . ' ' . $activeCountry['currency_en'] . ' received and your profile is now active. Your ad is visible to employers for 3 full months.' }}
            </p>
        </div>

        <!-- Receipt Box -->
        <div class="bg-slate-50 p-5 rounded-2xl border border-slate-200 text-xs space-y-2.5 max-w-md mx-auto text-start">
            <div class="flex justify-between pb-2 border-b border-slate-200">
                <span class="text-slate-400">{{ ($isArabic ?? false) ? 'رقم الإيصال:' : 'Receipt Ref:' }}</span>
                <span class="font-mono font-bold text-slate-800">{{ $applicant['id'] }}</span>
            </div>
            <div class="flex justify-between pb-2 border-b border-slate-200">
                <span class="text-slate-400">{{ ($isArabic ?? false) ? 'المهنة المعلنة:' : 'Profession:' }}</span>
                <span class="font-bold text-blue-700">{{ $applicant['profession'] }}</span>
            </div>
            <div class="flex justify-between pb-2 border-b border-slate-200">
                <span class="text-slate-400">{{ ($isArabic ?? false) ? 'المبلغ المستلم:' : 'Amount Paid:' }}</span>
                <span class="font-bold text-emerald-600">{{ $activeCountry['fee_display'] }} {{ $activeCountry['currency_en'] }}</span>
            </div>
            <div class="flex justify-between">
                <span class="text-slate-400">{{ ($isArabic ?? false) ? 'صلاحية الظهور:' : 'Active Validity:' }}</span>
                <span class="font-bold text-slate-700">90 {{ ($isArabic ?? false) ? 'يوماً (3 أشهر كاملة)' : 'Days (3 Months)' }}</span>
            </div>
        </div>

        <!-- Buttons -->
        <div class="pt-4 flex flex-col sm:flex-row items-center justify-center gap-3">
            <a href="{{ route('applicants.show', $applicant['id']) }}" class="w-full sm:w-auto px-6 py-3 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-bold text-sm transition">
                <i class="fa-solid fa-id-card {{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}"></i>
                {{ ($isArabic ?? false) ? 'عرض ملفك الشخصي' : 'View Your Public Profile' }}
            </a>
            <a href="{{ route('home') }}" class="w-full sm:w-auto px-6 py-3 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-700 font-bold text-sm transition">
                {{ ($isArabic ?? false) ? 'العودة للرئيسية' : 'Return to Home' }}
            </a>
        </div>

    </div>

</div>
@endsection
