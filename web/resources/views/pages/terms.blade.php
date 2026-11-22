@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'الشروط والأحكام | دايركت وورك' : 'Terms & Conditions | Direct Work')

@section('content')
<div class="space-y-12 lg:space-y-16 py-8">

    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center max-w-4xl mx-auto space-y-4">
            
            <div class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-blue-50 border border-blue-200 text-blue-700 text-xs font-black shadow-xs">
                <i class="fa-solid fa-file-contract text-blue-600"></i>
                <span>{{ ($isArabic ?? false) ? 'اتفاقية الاستخدام والشروط الرسمية' : 'Terms of Service & User Agreement' }}</span>
            </div>

            <h1 class="text-3xl sm:text-5xl font-black text-slate-900 tracking-tight leading-tight">
                @if($isArabic ?? false)
                    الشروط والأحكام لاستخدام <span class="text-blue-600">دايركت وورك</span>
                @else
                    Direct Work <span class="text-blue-600">Terms & Conditions</span>
                @endif
            </h1>

            <p class="text-sm sm:text-base text-slate-600 font-medium leading-relaxed max-w-2xl mx-auto">
                @if($isArabic ?? false)
                    تنظم هذه الشروط استخدامك لتطبيق دايركت وورك على الهواتف الذكية وموقعنا الإلكتروني في الكويت والسعودية والإمارات.
                @else
                    These terms govern your access and use of the Direct Work mobile applications and website across Kuwait, Saudi Arabia, and the UAE.
                @endif
            </p>
        </div>
    </section>

    <section class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-10 shadow-card space-y-8 text-xs sm:text-sm text-slate-600 leading-relaxed font-medium">
            
            <div class="space-y-2">
                <h3 class="text-lg font-black text-slate-900">
                    {{ ($isArabic ?? false) ? '1. قبول الشروط' : '1. Acceptance of Terms' }}
                </h3>
                <p>
                    @if($isArabic ?? false)
                        باستخدامك لمنصة وتطبيقات دايركت وورك، فإنك تقر وتوافق على الالتزام الكامل بهذه الشروط والأحكام وجميع القوانين المعمول بها في الدولة التي تستخدم التطبيق منها.
                    @else
                        By accessing or using the Direct Work app or website, you confirm your acceptance of these Terms and Conditions and agree to comply with all applicable local labor and digital regulations.
                    @endif
                </p>
            </div>

            <div class="space-y-2">
                <h3 class="text-lg font-black text-slate-900">
                    {{ ($isArabic ?? false) ? '2. حسابات المستخدمين ومسؤولية البيانات' : '2. User Accounts & Integrity' }}
                </h3>
                <p>
                    @if($isArabic ?? false)
                        يتعهد الباحث عن عمل بصحة ودقة جميع المعلومات والشهادات والخبرات المدرجة في سيرته الذاتية. كما تتعهد الشركات بأن جميع الوظائف المعلنة حقيقية وقانونية وخالية من أي رسوم توظيف غير مشروعة على المرشحين.
                    @else
                        Candidates certify that all personal and professional credentials in their profiles are accurate and truthful. Employers warrant that all job posts represent genuine, lawful vacancies with zero illegal placement fees charged to candidates.
                    @endif
                </p>
            </div>

            <div class="space-y-2">
                <h3 class="text-lg font-black text-slate-900">
                    {{ ($isArabic ?? false) ? '3. سياسة الخصوصية وحماية البيانات' : '3. Privacy & Data Protection' }}
                </h3>
                <p>
                    @if($isArabic ?? false)
                        تعتبر <a href="{{ route('privacy') }}" class="text-blue-600 font-bold underline">سياسة الخصوصية</a> جزءاً لا يتجزأ من هذه الاتفاقية. يمكنك مراجعتها للاطلاع على كيفية تعاملنا مع بياناتك وأذونات الهواتف الذكية.
                    @else
                        Our <a href="{{ route('privacy') }}" class="text-blue-600 font-bold underline">Privacy Policy</a> is an integral part of these Terms. Please consult it to understand how your data and mobile device permissions are handled.
                    @endif
                </p>
            </div>

            <div class="space-y-2">
                <h3 class="text-lg font-black text-slate-900">
                    {{ ($isArabic ?? false) ? '4. إنهاء الحساب والحذف' : '4. Account Termination & Deletion' }}
                </h3>
                <p>
                    @if($isArabic ?? false)
                        يحق للمستخدم حذف حسابه نهائياً في أي وقت مباشرة عبر التطبيق أو مراسلة فريق الدعم الفني، وستتم إزالة جميع البيانات الشخصية والسيرة الذاتية فوراً.
                    @else
                        Users reserve the right to terminate and delete their account at any time either via the in-app settings or by contacting support, resulting in the permanent removal of profile data.
                    @endif
                </p>
            </div>

            <div class="space-y-2">
                <h3 class="text-lg font-black text-slate-900">
                    {{ ($isArabic ?? false) ? '5. التواصل والدعم' : '5. Contact & Support' }}
                </h3>
                <p>
                    @if($isArabic ?? false)
                        لأي استفسارات قانونية أو فنية، يمكنكم التواصل معنا عبر البريد الإلكتروني <a href="mailto:support@directwork.site" class="text-blue-600 font-bold">support@directwork.site</a> أو عبر الواتساب <a href="https://wa.me/96566707126" class="text-emerald-600 font-bold">+965 6670 7126</a>.
                    @else
                        For legal, technical, or compliance inquiries, please contact us at <a href="mailto:support@directwork.site" class="text-blue-600 font-bold">support@directwork.site</a> or WhatsApp <a href="https://wa.me/96566707126" class="text-emerald-600 font-bold">+965 6670 7126</a>.
                    @endif
                </p>
            </div>

        </div>
    </section>

</div>
@endsection
