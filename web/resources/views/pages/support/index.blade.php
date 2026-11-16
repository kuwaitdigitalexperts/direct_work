@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'مركز المساعدة والدعم الفني | دايركت وورك' : 'Help & Support Center | Direct Jobs')

@section('content')
<div class="space-y-16 lg:space-y-24 py-8">

    <!-- 1. HERO & TOP CONTACT CARDS (Matching Screenshot 1) -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <!-- Header Text -->
        <div class="text-center max-w-3xl mx-auto space-y-4 mb-14">
            
            <!-- Pill Tag -->
            <div>
                <span class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-blue-50 border border-blue-200/80 text-blue-700 text-xs font-black shadow-xs">
                    <span class="text-blue-600">🎧</span>
                    <span>{{ ($isArabic ?? false) ? 'مركز المساعدة وخدمة العملاء' : 'Help & Support Center' }}</span>
                </span>
            </div>

            <!-- Main Heading -->
            <h1 class="text-3xl sm:text-5xl font-black text-slate-900 tracking-tight leading-tight">
                @if($isArabic ?? false)
                    كيف يمكننا مساعدتك اليوم في <br>
                    <span class="text-blue-600">دايركت وورك؟</span>
                @else
                    How can we help you today at <br>
                    <span class="text-blue-600">Direct Work?</span>
                @endif
            </h1>

            <!-- Subtitle -->
            <p class="text-sm sm:text-base text-slate-600 font-medium leading-relaxed max-w-2xl mx-auto">
                @if($isArabic ?? false)
                    سواء كنت شركة كويتية تبحث عن كفاءات موثوقة أو باحثاً عن عمل يخطو نحو مستقبله المهني، فإن فريق الدعم المحلي لدينا جاهز لمساعدتك.
                @else
                    Whether you are a Kuwait company hiring top verified candidates or a job seeker stepping forward in your career, our local support team is ready to assist you.
                @endif
            </p>

            <!-- 2 Top Action Buttons -->
            <div class="flex flex-wrap items-center justify-center gap-3 pt-3">
                <a href="#support-form" 
                   class="inline-flex items-center gap-2 px-6 py-3 rounded-full bg-blue-600 hover:bg-blue-700 text-white font-extrabold text-xs shadow-md shadow-blue-500/25 transition transform hover:-translate-y-0.5">
                    <span>{{ ($isArabic ?? false) ? 'إرسال تذكرة دعم' : 'Submit Support Ticket' }}</span>
                    <i class="fa-solid fa-arrow-right text-[11px] {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
                </a>
                <a href="#support-faqs" 
                   class="inline-flex items-center gap-2 px-6 py-3 rounded-full bg-white hover:bg-slate-50 text-slate-800 font-extrabold text-xs border border-slate-200 shadow-xs transition">
                    <span>{{ ($isArabic ?? false) ? 'تصفح الأسئلة الشائعة' : 'Browse FAQs' }}</span>
                </a>
            </div>

        </div>

        <!-- 3 Fast Contact Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            <!-- WhatsApp Support Card -->
            <div class="bg-white rounded-3xl border border-slate-200/90 p-6 shadow-card flex flex-col justify-between space-y-6">
                <div>
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-10 h-10 rounded-2xl bg-emerald-50 text-emerald-600 flex items-center justify-center text-lg">
                            <i class="fa-regular fa-comment-dots"></i>
                        </div>
                        <span class="px-2.5 py-1 rounded-full bg-emerald-50 text-emerald-700 text-[10px] font-black uppercase tracking-wider">
                            {{ ($isArabic ?? false) ? 'فوري' : 'Instant' }}
                        </span>
                    </div>
                    <h3 class="text-base font-black text-slate-900 mb-1.5">
                        {{ ($isArabic ?? false) ? 'الدعم عبر الواتساب' : 'WhatsApp Support' }}
                    </h3>
                    <p class="text-xs text-slate-500 font-semibold leading-relaxed">
                        {{ ($isArabic ?? false) ? 'تواصل مباشرة مع مسؤول الدعم الفني للاستفسارات السريعة وتوثيق الحساب.' : 'Chat directly with a support agent for quick inquiries and verification.' }}
                    </p>
                </div>
                <div>
                    <a href="https://wa.me/96566707126" target="_blank" rel="noopener noreferrer" 
                       class="w-full py-3 px-4 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white font-extrabold text-xs flex items-center justify-center gap-2 transition shadow-sm">
                        <span>+965 6670 7126</span>
                        <i class="fa-solid fa-arrow-right text-[10px] {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
                    </a>
                </div>
            </div>

            <!-- Official Email Card -->
            <div class="bg-white rounded-3xl border border-slate-200/90 p-6 shadow-card flex flex-col justify-between space-y-6">
                <div>
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-10 h-10 rounded-2xl bg-orange-50 text-orange-600 flex items-center justify-center text-lg">
                            <i class="fa-regular fa-envelope"></i>
                        </div>
                        <span class="px-2.5 py-1 rounded-full bg-orange-50 text-orange-700 text-[10px] font-black tracking-wider">
                            &lt; 2 Hours
                        </span>
                    </div>
                    <h3 class="text-base font-black text-slate-900 mb-1.5">
                        {{ ($isArabic ?? false) ? 'البريد الإلكتروني الرسمي' : 'Official Support Email' }}
                    </h3>
                    <p class="text-xs text-slate-500 font-semibold leading-relaxed">
                        {{ ($isArabic ?? false) ? 'للاستفسارات الرسمية، الفواتير والاشتراكات، والطلبات التقنية الخاصة.' : 'For official inquiries, billing, partnerships, and technical requests.' }}
                    </p>
                </div>
                <div>
                    <a href="mailto:directkwjobs@gmail.com" 
                       class="w-full py-3 px-4 rounded-xl bg-orange-50/70 border border-orange-200/70 hover:bg-orange-100 text-orange-800 font-black text-xs flex items-center justify-center transition">
                        directkwjobs@gmail.com
                    </a>
                </div>
            </div>

            <!-- Kuwait Phone Line Card -->
            <div class="bg-white rounded-3xl border border-slate-200/90 p-6 shadow-card flex flex-col justify-between space-y-6">
                <div>
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-10 h-10 rounded-2xl bg-blue-50 text-blue-600 flex items-center justify-center text-lg">
                            <i class="fa-solid fa-phone"></i>
                        </div>
                        <span class="px-2.5 py-1 rounded-full bg-blue-50 text-blue-700 text-[10px] font-black uppercase tracking-wider">
                            {{ ($isArabic ?? false) ? 'خط مباشر' : 'Hotline' }}
                        </span>
                    </div>
                    <h3 class="text-base font-black text-slate-900 mb-1.5">
                        {{ ($isArabic ?? false) ? 'الخط الهاتفي المباشر' : 'Kuwait Phone Line' }}
                    </h3>
                    <p class="text-xs text-slate-500 font-semibold leading-relaxed">
                        {{ ($isArabic ?? false) ? 'خط مخصص للشركات وأصحاب الأعمال ومسؤولي الموارد البشرية.' : 'Dedicated line for Kuwait employers and corporate HR managers.' }}
                    </p>
                </div>
                <div>
                    <a href="tel:+96566707126" 
                       class="w-full py-3 px-4 rounded-xl bg-slate-50 border border-slate-200 hover:bg-slate-100 text-slate-800 font-black text-xs flex items-center justify-center transition">
                        +965 6670 7126
                    </a>
                </div>
            </div>

        </div>

    </section>

    <!-- 2. SEND US A MESSAGE FORM & SIDEBARS (Matching Screenshot 2) -->
    <section id="support-form" class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
            
            <!-- Left: Message Form (7 cols) -->
            <div class="lg:col-span-7 bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-10 shadow-card space-y-6 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }}">
                
                <div>
                    <h2 class="text-2xl font-black text-slate-900">
                        {{ ($isArabic ?? false) ? 'أرسل لنا رسالة' : 'Send Us a Message' }}
                    </h2>
                    <p class="text-xs text-slate-500 font-semibold mt-1">
                        {{ ($isArabic ?? false) ? 'املأ النموذج أدناه وسيقوم فريق الدعم المخصص بالتواصل معك مباشرة.' : 'Fill out the form below and our dedicated support team will reach out directly.' }}
                    </p>
                </div>

                <form action="{{ route('support.send') }}" method="POST" class="space-y-5">
                    @csrf

                    <!-- Contacting As Switcher -->
                    <div>
                        <label class="block text-xs font-black text-slate-700 uppercase tracking-wider mb-2">
                            {{ ($isArabic ?? false) ? 'أتواصل بصفتي:' : 'I AM CONTACTING AS:' }}
                        </label>
                        <div class="grid grid-cols-2 gap-3" id="userTypeTabs">
                            <button type="button" onclick="setUserType('company')" id="tabEmployer"
                                    class="py-3 px-4 rounded-2xl border border-orange-300 bg-orange-50/80 text-orange-700 font-black text-xs flex items-center justify-center gap-2 transition shadow-xs">
                                <i class="fa-regular fa-building text-orange-600"></i>
                                <span>{{ ($isArabic ?? false) ? 'صاحب عمل / شركة' : 'Employer / Company' }}</span>
                            </button>
                            <button type="button" onclick="setUserType('applicant')" id="tabJobSeeker"
                                    class="py-3 px-4 rounded-2xl border border-slate-200 bg-white text-slate-600 font-bold text-xs flex items-center justify-center gap-2 transition hover:bg-slate-50">
                                <i class="fa-regular fa-user text-slate-400"></i>
                                <span>{{ ($isArabic ?? false) ? 'باحث عن عمل / مرشح' : 'Job Seeker / Applicant' }}</span>
                            </button>
                        </div>
                        <input type="hidden" name="user_type" id="userTypeInput" value="company">
                    </div>

                    <!-- Full Name & Email Grid -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-xs font-bold text-slate-700 mb-1">
                                {{ ($isArabic ?? false) ? 'الاسم الكامل' : 'Full Name' }} <span class="text-red-500">*</span>
                            </label>
                            <input type="text" name="full_name" required value="{{ old('full_name') }}"
                                   placeholder="{{ ($isArabic ?? false) ? 'مثال: جاسم المطيري' : 'e.g. Jassem Al-Mutairi' }}"
                                   class="w-full text-xs rounded-xl border-slate-300 focus:border-orange-500 focus:ring-orange-500 p-3 bg-slate-50/50">
                        </div>
                        <div>
                            <label class="block text-xs font-bold text-slate-700 mb-1">
                                {{ ($isArabic ?? false) ? 'البريد الإلكتروني' : 'Email Address' }} <span class="text-red-500">*</span>
                            </label>
                            <input type="email" name="email" required value="{{ old('email') }}"
                                   placeholder="name@company.com"
                                   class="w-full text-xs rounded-xl border-slate-300 focus:border-orange-500 focus:ring-orange-500 p-3 bg-slate-50/50">
                        </div>
                    </div>

                    <!-- Phone & Category Grid -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-xs font-bold text-slate-700 mb-1">
                                {{ ($isArabic ?? false) ? 'رقم الهاتف / الواتساب' : 'Phone / WhatsApp' }} <span class="text-red-500">*</span>
                            </label>
                            <input type="tel" name="phone" required value="{{ old('phone') }}"
                                   placeholder="+965 xxxx xxxx"
                                   class="w-full text-xs rounded-xl border-slate-300 focus:border-orange-500 focus:ring-orange-500 p-3 bg-slate-50/50">
                        </div>
                        <div>
                            <label class="block text-xs font-bold text-slate-700 mb-1">
                                {{ ($isArabic ?? false) ? 'تصنيف الاستفسار' : 'Inquiry Category' }}
                            </label>
                            <select name="category" required class="w-full text-xs rounded-xl border-slate-300 focus:border-orange-500 focus:ring-orange-500 p-3 bg-white">
                                <option value="general">{{ ($isArabic ?? false) ? 'استفسار عام' : 'General Inquiry' }}</option>
                                <option value="verification">{{ ($isArabic ?? false) ? 'توثيق حساب شركة' : 'Account Verification' }}</option>
                                <option value="billing">{{ ($isArabic ?? false) ? 'الفواتير والمدفوعات' : 'Billing & Payment' }}</option>
                                <option value="technical">{{ ($isArabic ?? false) ? 'الدعم الفني والتقني' : 'Technical Support' }}</option>
                                <option value="enterprise">{{ ($isArabic ?? false) ? 'باقات الشركات الكبرى' : 'Enterprise Packages' }}</option>
                            </select>
                        </div>
                    </div>

                    <!-- Subject -->
                    <div>
                        <label class="block text-xs font-bold text-slate-700 mb-1">
                            {{ ($isArabic ?? false) ? 'موضوع الرسالة' : 'Subject' }} <span class="text-red-500">*</span>
                        </label>
                        <input type="text" name="subject" required value="{{ old('subject') }}"
                               placeholder="{{ ($isArabic ?? false) ? 'ملخص موجز لاستفسارك' : 'Brief summary of your inquiry' }}"
                               class="w-full text-xs rounded-xl border-slate-300 focus:border-orange-500 focus:ring-orange-500 p-3 bg-slate-50/50">
                    </div>

                    <!-- Message Details -->
                    <div>
                        <label class="block text-xs font-bold text-slate-700 mb-1">
                            {{ ($isArabic ?? false) ? 'تفاصيل الرسالة' : 'Message Details' }} <span class="text-red-500">*</span>
                        </label>
                        <textarea name="message" rows="4" required
                                  placeholder="{{ ($isArabic ?? false) ? 'يرجى تزويدنا بتفاصيل استفسارك أو سؤالك لنتمكن من خدمتك بسرعة...' : 'Please provide details about your inquiry or technical question so we can help quickly...' }}"
                                  class="w-full text-xs rounded-xl border-slate-300 focus:border-orange-500 focus:ring-orange-500 p-3 bg-slate-50/50"></textarea>
                    </div>

                    <button type="submit" 
                            class="w-full py-4 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-black text-sm shadow-md shadow-blue-500/25 transition">
                        {{ ($isArabic ?? false) ? 'إرسال الرسالة إلى فريق الدعم' : 'Submit Support Ticket' }}
                    </button>
                </form>

            </div>

            <!-- Right: 2 Sidebars (5 cols) -->
            <div class="lg:col-span-5 space-y-6 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }}">
                
                <!-- Card 1: Our Commitment to Direct Hiring -->
                <div class="bg-white rounded-3xl border border-slate-200/90 p-6 sm:p-8 shadow-card space-y-4">
                    <div class="w-10 h-10 rounded-2xl bg-orange-100 text-orange-600 flex items-center justify-center text-lg">
                        <i class="fa-solid fa-shield-halved"></i>
                    </div>
                    <h3 class="text-lg font-black text-slate-900">
                        {{ ($isArabic ?? false) ? 'التزامنا بالتوظيف المباشر' : 'Our Commitment to Direct Hiring' }}
                    </h3>
                    <p class="text-xs text-slate-500 font-semibold leading-relaxed">
                        {{ ($isArabic ?? false) ? 'تأسست دايركت وورك على مبادئ الشفافية والاتصال المباشر. لا نتقاضى أي عمولة توظيف ولا نسمح بأي وساطة غير معتمدة.' : 'Direct Jobs is built on transparency and direct connection. We take zero recruitment commissions and permit no unauthorized middlemen.' }}
                    </p>

                    <div class="space-y-3 pt-2">
                        <div class="flex items-start gap-2.5 text-xs text-slate-700 font-bold">
                            <i class="fa-solid fa-circle-check text-emerald-500 mt-0.5 shrink-0"></i>
                            <span>{{ ($isArabic ?? false) ? 'توثيق بيانات وتراخيص الشركات خلال 24 ساعة عمل.' : 'Company credentials and commercial records verified within 24 business hours.' }}</span>
                        </div>
                        <div class="flex items-start gap-2.5 text-xs text-slate-700 font-bold">
                            <i class="fa-solid fa-circle-check text-emerald-500 mt-0.5 shrink-0"></i>
                            <span>{{ ($isArabic ?? false) ? 'أرقام هواتف وسير ذاتية حقيقية للمرشحين في الكويت.' : 'Direct phone contact & authentic CV attachments for candidates in Kuwait.' }}</span>
                        </div>
                        <div class="flex items-start gap-2.5 text-xs text-slate-700 font-bold">
                            <i class="fa-solid fa-circle-check text-emerald-500 mt-0.5 shrink-0"></i>
                            <span>{{ ($isArabic ?? false) ? 'رسوم رمزية جداً للظهور لمدة 3 أشهر، بدون أي اقتطاع من الراتب.' : 'A very nominal fee to display your candidate ad in front of employers for 3 months, with zero salary cuts or commissions.' }}</span>
                        </div>
                    </div>
                </div>

                <!-- Card 2: Enterprise & High-Volume Hiring -->
                <div class="rounded-3xl bg-[#0F172A] text-white p-6 sm:p-8 shadow-card space-y-4">
                    <div class="w-10 h-10 rounded-2xl bg-slate-800 text-amber-400 flex items-center justify-center text-lg">
                        <i class="fa-solid fa-wand-magic-sparkles"></i>
                    </div>
                    <h3 class="text-lg font-black text-white">
                        {{ ($isArabic ?? false) ? 'توظيف الشركات والكميات الكبرى' : 'Enterprise & High-Volume Hiring' }}
                    </h3>
                    <p class="text-xs text-slate-300 leading-relaxed font-normal">
                        {{ ($isArabic ?? false) ? 'إذا كانت منشأتك تتطلب استقطاب كفاءات بأعداد كبيرة عبر الكويت ودول الخليج، أو باقات مؤسسية مخصصة، تواصل مع فريق المؤسسات.' : 'If your organization requires bulk talent sourcing across Kuwait & the GCC, or customized corporate packages, connect with our Enterprise team.' }}
                    </p>
                    <div class="pt-2">
                        <a href="mailto:directkwjobs@gmail.com?subject=Enterprise%20Hiring%20Inquiry" 
                           class="inline-flex items-center justify-center gap-2 w-full py-3 px-4 rounded-xl bg-white hover:bg-slate-100 text-slate-900 font-black text-xs transition">
                            <i class="fa-regular fa-envelope text-orange-600"></i>
                            <span>{{ ($isArabic ?? false) ? 'تواصل مع فريق المؤسسات' : 'Contact Enterprise Team' }}</span>
                        </a>
                    </div>
                </div>

            </div>

        </div>

    </section>

    <!-- 3. QUICK ACTION BANNER (Matching Screenshot 3) -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex flex-wrap items-center justify-center gap-3">
            <a href="#support-form" 
               class="inline-flex items-center gap-2 px-6 py-3.5 rounded-2xl bg-orange-600 hover:bg-orange-700 text-white font-extrabold text-xs shadow-md shadow-orange-500/20 transition">
                <i class="fa-solid fa-paper-plane"></i>
                <span>{{ ($isArabic ?? false) ? 'إرسال تذكرة دعم' : 'Submit Support Ticket' }}</span>
            </a>
            <a href="https://wa.me/96566707126" target="_blank" rel="noopener noreferrer" 
               class="inline-flex items-center gap-2 px-6 py-3.5 rounded-2xl bg-emerald-50 border border-emerald-200 hover:bg-emerald-100 text-emerald-700 font-extrabold text-xs transition">
                <i class="fa-brands fa-whatsapp text-emerald-600 text-sm"></i>
                <span>{{ ($isArabic ?? false) ? 'محادثة عبر الواتساب' : 'Chat on WhatsApp' }}</span>
            </a>
        </div>
    </section>

    <!-- 4. SUPPORT FREQUENTLY ASKED QUESTIONS (Matching Screenshots 3, 4 & 5) -->
    <section id="support-faqs" class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
        
        <div class="text-center mb-8">
            <h2 class="text-2xl sm:text-3xl font-black text-slate-900">
                {{ ($isArabic ?? false) ? 'الأسئلة الشائعة في مركز الدعم' : 'Frequently Asked Questions' }}
            </h2>
        </div>

        <!-- Filter Bar & Search -->
        <div class="space-y-4 mb-8">
            <!-- Search -->
            <div class="relative max-w-md mx-auto">
                <i class="fa-solid fa-magnifying-glass absolute left-3.5 top-3.5 text-slate-400 text-xs"></i>
                <input type="text" id="faqSearchInput" onkeyup="filterSupportFaqs()"
                       placeholder="{{ ($isArabic ?? false) ? 'ابحث في الأسئلة الشائعة...' : 'Search frequent questions' }}"
                       class="w-full pl-9 pr-4 py-2.5 rounded-full border border-slate-200 text-xs bg-white focus:outline-none focus:border-orange-500 shadow-xs">
            </div>

            <!-- Category Pills -->
            <div class="flex flex-wrap items-center justify-center gap-2 text-xs font-bold" id="faqFilterPills">
                <button type="button" onclick="setFaqCategory('all', this)" class="faq-filter-btn px-4 py-2 rounded-full bg-orange-600 text-white shadow-xs">
                    {{ ($isArabic ?? false) ? 'جميع الأسئلة' : 'All Questions' }}
                </button>
                <button type="button" onclick="setFaqCategory('employers', this)" class="faq-filter-btn px-4 py-2 rounded-full bg-white border border-slate-200 text-slate-600 hover:bg-slate-50">
                    <i class="fa-regular fa-building {{ ($isArabic ?? false) ? 'ml-1' : 'mr-1' }}"></i>
                    {{ ($isArabic ?? false) ? 'للشركات' : 'For Employers' }}
                </button>
                <button type="button" onclick="setFaqCategory('seekers', this)" class="faq-filter-btn px-4 py-2 rounded-full bg-white border border-slate-200 text-slate-600 hover:bg-slate-50">
                    <i class="fa-regular fa-user {{ ($isArabic ?? false) ? 'ml-1' : 'mr-1' }}"></i>
                    {{ ($isArabic ?? false) ? 'للباحثين عن عمل' : 'For Job Seekers' }}
                </button>
                <button type="button" onclick="setFaqCategory('billing', this)" class="faq-filter-btn px-4 py-2 rounded-full bg-white border border-slate-200 text-slate-600 hover:bg-slate-50">
                    <i class="fa-regular fa-credit-card {{ ($isArabic ?? false) ? 'ml-1' : 'mr-1' }}"></i>
                    {{ ($isArabic ?? false) ? 'الدفع والرسوم' : 'Billing & Payments' }}
                </button>
                <button type="button" onclick="setFaqCategory('safety', this)" class="faq-filter-btn px-4 py-2 rounded-full bg-white border border-slate-200 text-slate-600 hover:bg-slate-50">
                    <i class="fa-solid fa-shield-halved {{ ($isArabic ?? false) ? 'ml-1' : 'mr-1' }}"></i>
                    {{ ($isArabic ?? false) ? 'الأمان والخصوصية' : 'Safety & Privacy' }}
                </button>
            </div>
        </div>

        <!-- Support FAQ Accordion List (Exact items from screenshots) -->
        <div class="space-y-3" id="faqAccordionContainer">
            
            <!-- Item 1: Employers Search (expanded by default in Screenshot 3) -->
            <div class="faq-card bg-white rounded-2xl border border-slate-200/90 shadow-xs transition overflow-hidden" data-category="employers">
                <button type="button" onclick="toggleSupportFaq(this)" class="w-full flex items-center justify-between p-5 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-900 gap-4">
                    <span>How do employers search and hire applicants on Direct Jobs?</span>
                    <i class="fa-solid fa-chevron-up text-xs text-orange-600 transition-transform"></i>
                </button>
                <div class="faq-answer px-5 pb-5 text-xs text-slate-600 font-medium leading-relaxed border-t border-slate-100 pt-3">
                    Verified employers can browse candidates across Kuwait by sector, profession, experience, and nationality. You can view their full profiles, verified contact numbers, and CV attachments, and contact candidates directly via phone call, WhatsApp, or built-in secure chat with zero middleman commissions.
                </div>
            </div>

            <!-- Item 2: Company verification -->
            <div class="faq-card bg-white rounded-2xl border border-slate-200/90 shadow-xs transition overflow-hidden" data-category="employers">
                <button type="button" onclick="toggleSupportFaq(this)" class="w-full flex items-center justify-between p-5 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-900 gap-4">
                    <span>How does the company account verification process work?</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-answer hidden px-5 pb-5 text-xs text-slate-600 font-medium leading-relaxed border-t border-slate-100 pt-3">
                    Our compliance team verifies each company against official commercial registry records within 24 business hours. Once verified, a blue badge is assigned, enabling immediate job posting and direct candidate contact.
                </div>
            </div>

            <!-- Item 3: Recruitment commissions -->
            <div class="faq-card bg-white rounded-2xl border border-slate-200/90 shadow-xs transition overflow-hidden" data-category="employers billing">
                <button type="button" onclick="toggleSupportFaq(this)" class="w-full flex items-center justify-between p-5 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-900 gap-4">
                    <span>Are there recruitment agency commissions when I hire through Direct Jobs?</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-answer hidden px-5 pb-5 text-xs text-slate-600 font-medium leading-relaxed border-t border-slate-100 pt-3">
                    No, there are zero commissions. Direct Jobs connects employers directly with candidates without any recruitment agency fees or percentage deductions.
                </div>
            </div>

            <!-- Item 4: Job seekers cost -->
            <div class="faq-card bg-white rounded-2xl border border-slate-200/90 shadow-xs transition overflow-hidden" data-category="seekers billing">
                <button type="button" onclick="toggleSupportFaq(this)" class="w-full flex items-center justify-between p-5 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-900 gap-4">
                    <span>How much does it cost for job seekers to post their CV / ad?</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-answer hidden px-5 pb-5 text-xs text-slate-600 font-medium leading-relaxed border-t border-slate-100 pt-3">
                    In Kuwait, the standard fee is only 2 KWD (35 SAR in Saudi Arabia, 30 AED in UAE) for a full 90-day active listing, giving your profile maximum visibility to hundreds of hiring companies.
                </div>
            </div>

            <!-- Item 5: How employers find me -->
            <div class="faq-card bg-white rounded-2xl border border-slate-200/90 shadow-xs transition overflow-hidden" data-category="seekers">
                <button type="button" onclick="toggleSupportFaq(this)" class="w-full flex items-center justify-between p-5 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-900 gap-4">
                    <span>How do employers find and reach out to me?</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-answer hidden px-5 pb-5 text-xs text-slate-600 font-medium leading-relaxed border-t border-slate-100 pt-3">
                    Employers search through our 27 specialized sectors using filters for profession, experience, and governorate. They can immediately view your verified profile and reach you directly via phone call, WhatsApp, or instant in-app chat.
                </div>
            </div>

            <!-- Item 6: Specialized sections -->
            <div class="faq-card bg-white rounded-2xl border border-slate-200/90 shadow-xs transition overflow-hidden" data-category="seekers employers">
                <button type="button" onclick="toggleSupportFaq(this)" class="w-full flex items-center justify-between p-5 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-900 gap-4">
                    <span>What are the specialized sections (GCC Citizens & Stateless Residents)?</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-answer hidden px-5 pb-5 text-xs text-slate-600 font-medium leading-relaxed border-t border-slate-100 pt-3">
                    We maintain designated categories for GCC national candidates and local resident talent to facilitate specialized hiring requirements and quotas compliant with regional labor laws.
                </div>
            </div>

            <!-- Item 7: Payment methods -->
            <div class="faq-card bg-white rounded-2xl border border-slate-200/90 shadow-xs transition overflow-hidden" data-category="billing">
                <button type="button" onclick="toggleSupportFaq(this)" class="w-full flex items-center justify-between p-5 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-900 gap-4">
                    <span>What payment methods are supported for employer subscriptions or featured ads?</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-answer hidden px-5 pb-5 text-xs text-slate-600 font-medium leading-relaxed border-t border-slate-100 pt-3">
                    We support K-NET (Kuwait), Mada (Saudi Arabia), Apple Pay, Visa, Mastercard, and direct bank transfer for corporate invoice accounts.
                </div>
            </div>

            <!-- Item 8: Privacy & data protection -->
            <div class="faq-card bg-white rounded-2xl border border-slate-200/90 shadow-xs transition overflow-hidden" data-category="safety">
                <button type="button" onclick="toggleSupportFaq(this)" class="w-full flex items-center justify-between p-5 text-left {{ ($isArabic ?? false) ? 'text-right' : '' }} font-black text-xs sm:text-sm text-slate-900 gap-4">
                    <span>How is personal data and privacy protected?</span>
                    <i class="fa-solid fa-chevron-down text-xs text-slate-400 transition-transform"></i>
                </button>
                <div class="faq-answer hidden px-5 pb-5 text-xs text-slate-600 font-medium leading-relaxed border-t border-slate-100 pt-3">
                    All personal data and CV documents are encrypted. Contact details are accessible only by verified employers on the platform, and we never sell your personal information to third-party marketing companies.
                </div>
            </div>

        </div>

    </section>

</div>

<script>
function setUserType(type) {
    document.getElementById('userTypeInput').value = type;
    const tabEmployer = document.getElementById('tabEmployer');
    const tabJobSeeker = document.getElementById('tabJobSeeker');

    if (type === 'company') {
        tabEmployer.className = "py-3 px-4 rounded-2xl border border-orange-300 bg-orange-50/80 text-orange-700 font-black text-xs flex items-center justify-center gap-2 transition shadow-xs";
        tabJobSeeker.className = "py-3 px-4 rounded-2xl border border-slate-200 bg-white text-slate-600 font-bold text-xs flex items-center justify-center gap-2 transition hover:bg-slate-50";
    } else {
        tabJobSeeker.className = "py-3 px-4 rounded-2xl border border-orange-300 bg-orange-50/80 text-orange-700 font-black text-xs flex items-center justify-center gap-2 transition shadow-xs";
        tabEmployer.className = "py-3 px-4 rounded-2xl border border-slate-200 bg-white text-slate-600 font-bold text-xs flex items-center justify-center gap-2 transition hover:bg-slate-50";
    }
}

function toggleSupportFaq(button) {
    const card = button.closest('.faq-card');
    const answer = card.querySelector('.faq-answer');
    const icon = button.querySelector('i');

    if (answer.classList.contains('hidden')) {
        answer.classList.remove('hidden');
        icon.classList.remove('fa-chevron-down');
        icon.classList.add('fa-chevron-up');
        icon.classList.add('text-orange-600');
    } else {
        answer.classList.add('hidden');
        icon.classList.add('fa-chevron-down');
        icon.classList.remove('fa-chevron-up');
        icon.classList.remove('text-orange-600');
    }
}

function setFaqCategory(category, button) {
    // Update active pill button style
    document.querySelectorAll('.faq-filter-btn').forEach(btn => {
        btn.className = "faq-filter-btn px-4 py-2 rounded-full bg-white border border-slate-200 text-slate-600 hover:bg-slate-50";
    });
    button.className = "faq-filter-btn px-4 py-2 rounded-full bg-orange-600 text-white shadow-xs";

    // Filter cards
    const cards = document.querySelectorAll('.faq-card');
    cards.forEach(card => {
        const cats = card.getAttribute('data-category') || '';
        if (category === 'all' || cats.includes(category)) {
            card.classList.remove('hidden');
        } else {
            card.classList.add('hidden');
        }
    });
}

function filterSupportFaqs() {
    const query = document.getElementById('faqSearchInput').value.toLowerCase();
    const cards = document.querySelectorAll('.faq-card');
    cards.forEach(card => {
        const text = card.textContent.toLowerCase();
        if (text.includes(query)) {
            card.classList.remove('hidden');
        } else {
            card.classList.add('hidden');
        }
    });
}
</script>
@endsection
