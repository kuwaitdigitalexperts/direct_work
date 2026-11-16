@extends('layouts.employer')

@section('title', 'Company Profile | Direct Work Kuwait')

@section('content')
<div class="max-w-4xl mx-auto space-y-8">
    
    <!-- Top Header -->
    <div>
        <div class="flex items-center gap-2">
            <div class="w-8 h-8 rounded-xl bg-blue-100 text-blue-700 flex items-center justify-center text-sm shadow-xs">
                <i class="fa-solid fa-building"></i>
            </div>
            <h1 class="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight">
                Company Profile
            </h1>
        </div>
        <p class="text-xs sm:text-sm font-semibold text-slate-500 mt-1">
            Manage corporate identity, address coordinates, and verification credentials inside Kuwait.
        </p>
    </div>

    <!-- Company Identity Card (Matching Screenshot 7) -->
    <div class="bg-white rounded-3xl p-6 sm:p-10 border border-slate-200/90 shadow-card space-y-8">
        
        @php
            $companyName = $authUser['company_name'] ?? $authUser['full_name'] ?? 'Company';
            $initials = strtoupper(substr($companyName, 0, 2));
        @endphp

        <!-- Profile Top Banner Box -->
        <div class="flex items-center gap-4 pb-6 border-b border-slate-100">
            <div class="w-16 h-16 rounded-3xl bg-gradient-to-br from-blue-700 via-blue-600 to-indigo-800 text-white font-black text-xl flex items-center justify-center shadow-md shadow-blue-500/25 shrink-0">
                {{ $initials }}
            </div>
            <div class="space-y-1">
                <h2 class="text-xl font-black text-slate-900 leading-tight">
                    {{ $companyName }}
                </h2>
                <div>
                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-xs font-black border border-blue-200">
                        <i class="fa-solid fa-certificate text-[10px]"></i>
                        <span>Verified Corporate Recruiter</span>
                    </span>
                </div>
            </div>
        </div>

        <form action="{{ route('employer.profile.update') }}" method="POST" class="space-y-6">
            @csrf

            <!-- Row 1: Company Registered Name & Display Name -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                <div>
                    <label class="block text-[11px] font-black uppercase tracking-wider text-slate-700 mb-2">
                        COMPANY REGISTERED NAME <span class="text-blue-600">*</span>
                    </label>
                    <input type="text" name="company_name" value="{{ old('company_name', $authUser['company_name'] ?? '') }}" required
                           class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/50 py-3.5 px-4 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 transition">
                </div>

                <div>
                    <label class="block text-[11px] font-black uppercase tracking-wider text-slate-700 mb-2">
                        DISPLAY NAME
                    </label>
                    <input type="text" name="display_name" value="{{ old('display_name', $authUser['display_name'] ?? $companyName) }}"
                           class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/50 py-3.5 px-4 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 transition">
                </div>
            </div>

            <!-- Row 2: Country / Market & Headquarters Address -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                <div>
                    <label class="block text-[11px] font-black uppercase tracking-wider text-slate-700 mb-2">
                        COMPANY COUNTRY / MARKET <span class="text-blue-600">*</span>
                    </label>
                    <select name="country" 
                            class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/50 py-3.5 px-4 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 transition">
                        <option value="kw" selected>🇰🇼 Kuwait (KW)</option>
                        <option value="sa">🇸🇦 Saudi Arabia (KSA)</option>
                        <option value="ae">🇦🇪 United Arab Emirates (UAE)</option>
                    </select>
                </div>

                <div>
                    <label class="block text-[11px] font-black uppercase tracking-wider text-slate-700 mb-2">
                        CORPORATE HEADQUARTERS / ADDRESS
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                            <i class="fa-solid fa-location-dot text-blue-600 text-xs"></i>
                        </div>
                        <input type="text" name="address" value="{{ old('address', $authUser['address'] ?? $authUser['governorate'] ?? '') }}"
                               placeholder="e.g. Sharq, Kuwait City"
                               class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/50 py-3.5 pl-9 pr-4 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 transition">
                    </div>
                </div>
            </div>

            <!-- Row 3: Corporate Phone & Recruiter Email -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                <div>
                    <label class="block text-[11px] font-black uppercase tracking-wider text-slate-700 mb-2">
                        CORPORATE PHONE
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                            <i class="fa-solid fa-phone text-blue-600 text-xs"></i>
                        </div>
                        <input type="text" name="phone" value="{{ old('phone', $authUser['phone'] ?? '') }}"
                               placeholder="e.g. +965 2244 5566"
                               class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/50 py-3.5 pl-9 pr-4 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 transition">
                    </div>
                </div>

                <div>
                    <label class="block text-[11px] font-black uppercase tracking-wider text-slate-700 mb-2">
                        VERIFIED RECRUITER EMAIL
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                            <i class="fa-regular fa-envelope text-blue-600 text-xs"></i>
                        </div>
                        <input type="email" name="email" value="{{ old('email', $authUser['email'] ?? '') }}" readonly
                               class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-100 py-3.5 pl-9 pr-4 text-slate-500 cursor-not-allowed">
                    </div>
                </div>
            </div>

            <!-- Row 4: Corporate Website -->
            <div>
                <label class="block text-[11px] font-black uppercase tracking-wider text-slate-700 mb-2">
                    CORPORATE WEBSITE
                </label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                        <i class="fa-solid fa-globe text-blue-600 text-xs"></i>
                    </div>
                    <input type="url" name="website" value="{{ old('website', $authUser['website'] ?? '') }}"
                           placeholder="https://company.kw"
                           class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/50 py-3.5 pl-9 pr-4 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 transition">
                </div>
            </div>

            <!-- Row 5: Industry Sector & Corporate Bio -->
            <div>
                <label class="block text-[11px] font-black uppercase tracking-wider text-slate-700 mb-2">
                    INDUSTRY SECTOR & CORPORATE BIO
                </label>
                <textarea name="bio" rows="4" 
                          placeholder="Describe your corporate recruitment focus, verified industries, operations load, etc..."
                          class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/50 p-4 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 transition">{{ old('bio', $authUser['bio'] ?? '') }}</textarea>
            </div>

            <!-- Save Changes Button (Royal Blue Theme) -->
            <div class="pt-4 border-t border-slate-100 flex items-center justify-end">
                <button type="submit" 
                        class="px-8 py-3.5 rounded-2xl bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-black text-xs shadow-md shadow-blue-500/25 transition flex items-center gap-2">
                    <i class="fa-solid fa-floppy-disk text-xs"></i>
                    <span>Save Changes</span>
                </button>
            </div>

        </form>

    </div>

</div>
@endsection
