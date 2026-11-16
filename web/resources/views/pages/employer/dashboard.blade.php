@extends('layouts.employer')

@section('title', 'Employer Dashboard | Direct Work Kuwait')

@section('content')
<div class="space-y-8 max-w-7xl mx-auto">
    
    <!-- Top Header -->
    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
            <h1 class="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight">
                Employer Dashboard
            </h1>
            <p class="text-xs sm:text-sm font-semibold text-slate-500 mt-1">
                Welcome back — here's your overview
            </p>
        </div>

        <div>
            <span class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-blue-50 border border-blue-200 text-blue-700 text-xs font-black uppercase tracking-wider">
                <span class="w-2 h-2 rounded-full bg-blue-600 animate-pulse"></span>
                <span>Portal Status: Active</span>
            </span>
        </div>
    </div>

    <!-- 1. Top 3 Stat Metric Cards (Royal Blue Theme) -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        
        <!-- Metric 1: Active Sectors -->
        <div class="bg-white rounded-3xl p-6 border border-slate-200/90 shadow-card flex items-center justify-between transition hover:border-blue-300">
            <div>
                <span class="text-[10px] font-black text-slate-400 uppercase tracking-widest block mb-2">
                    ACTIVE SECTORS
                </span>
                <div class="text-4xl font-black text-slate-900 tracking-tight">
                    {{ $activeSectorsCount ?? '27+' }}
                </div>
            </div>
            <div class="w-14 h-14 rounded-2xl bg-blue-50 border border-blue-100 text-blue-600 flex items-center justify-center text-xl shadow-xs">
                <i class="fa-solid fa-layer-group"></i>
            </div>
        </div>

        <!-- Metric 2: Active Companies -->
        <div class="bg-white rounded-3xl p-6 border border-slate-200/90 shadow-card flex items-center justify-between transition hover:border-blue-300">
            <div>
                <span class="text-[10px] font-black text-slate-400 uppercase tracking-widest block mb-2">
                    ACTIVE COMPANIES
                </span>
                <div class="text-4xl font-black text-slate-900 tracking-tight">
                    {{ $activeCompaniesCount ?? '300+' }}
                </div>
            </div>
            <div class="w-14 h-14 rounded-2xl bg-blue-50 border border-blue-100 text-blue-600 flex items-center justify-center text-xl shadow-xs">
                <i class="fa-solid fa-building"></i>
            </div>
        </div>

        <!-- Metric 3: Professions -->
        <div class="bg-white rounded-3xl p-6 border border-slate-200/90 shadow-card flex items-center justify-between transition hover:border-blue-300">
            <div>
                <span class="text-[10px] font-black text-slate-400 uppercase tracking-widest block mb-2">
                    PROFESSIONS
                </span>
                <div class="text-4xl font-black text-slate-900 tracking-tight">
                    {{ $professionsCount > 0 ? $professionsCount . '+' : '800+' }}
                </div>
            </div>
            <div class="w-14 h-14 rounded-2xl bg-blue-50 border border-blue-100 text-blue-600 flex items-center justify-center text-xl shadow-xs">
                <i class="fa-solid fa-users-gear"></i>
            </div>
        </div>

    </div>

    <!-- 2. Recruitment Cases by Location & Shift -->
    <div class="space-y-4">
        <div class="flex items-center gap-2 text-slate-900">
            <i class="fa-solid fa-chart-line text-blue-600 text-sm"></i>
            <h2 class="text-base font-black tracking-tight">
                Recruitment Cases by Location & Shift
            </h2>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            <!-- Inside Kuwait -->
            <div class="bg-white rounded-3xl p-6 border border-slate-200/90 shadow-card flex flex-col justify-between space-y-6 transition hover:shadow-lg">
                <div class="space-y-3">
                    <div class="w-6 h-6 rounded-full bg-blue-50 flex items-center justify-center">
                        <span class="w-2.5 h-2.5 rounded-full bg-blue-600"></span>
                    </div>
                    <div>
                        <h3 class="text-base font-black text-slate-900">Inside Kuwait</h3>
                        <p class="text-xs text-slate-500 font-semibold mt-1">Local applicants inside Kuwait.</p>
                    </div>
                </div>

                <div>
                    <a href="{{ route('employer.browse') }}?caseType=inside" 
                       class="inline-flex items-center gap-2 text-xs font-black text-blue-600 hover:text-blue-800 transition">
                        <span>→ BROWSE</span>
                    </a>
                </div>
            </div>

            <!-- Outside Kuwait -->
            <div class="bg-white rounded-3xl p-6 border border-slate-200/90 shadow-card flex flex-col justify-between space-y-6 transition hover:shadow-lg">
                <div class="space-y-3">
                    <div class="w-6 h-6 rounded-full bg-blue-50 flex items-center justify-center">
                        <span class="w-2.5 h-2.5 rounded-full bg-blue-600"></span>
                    </div>
                    <div>
                        <h3 class="text-base font-black text-slate-900">Outside Kuwait</h3>
                        <p class="text-xs text-slate-500 font-semibold mt-1">Applicants currently outside Kuwait.</p>
                    </div>
                </div>

                <div>
                    <a href="{{ route('employer.browse') }}?caseType=outside" 
                       class="inline-flex items-center gap-2 text-xs font-black text-blue-600 hover:text-blue-800 transition">
                        <span>→ BROWSE</span>
                    </a>
                </div>
            </div>

            <!-- Part-time -->
            <div class="bg-white rounded-3xl p-6 border border-slate-200/90 shadow-card flex flex-col justify-between space-y-6 transition hover:shadow-lg">
                <div class="space-y-3">
                    <div class="w-6 h-6 rounded-full bg-blue-50 flex items-center justify-center">
                        <span class="w-2.5 h-2.5 rounded-full bg-blue-600"></span>
                    </div>
                    <div>
                        <h3 class="text-base font-black text-slate-900">Part-time</h3>
                        <p class="text-xs text-slate-500 font-semibold mt-1">Extra and shift-based opportunities.</p>
                    </div>
                </div>

                <div>
                    <a href="{{ route('employer.browse') }}?caseType=part_time" 
                       class="inline-flex items-center gap-2 text-xs font-black text-blue-600 hover:text-blue-800 transition">
                        <span>→ BROWSE</span>
                    </a>
                </div>
            </div>

        </div>
    </div>

    <!-- 3. Specialized Browsing Portals -->
    <div class="space-y-4">
        <div class="flex items-center justify-between">
            <div class="flex items-center gap-2 text-slate-900">
                <i class="fa-regular fa-compass text-blue-600 text-sm"></i>
                <h2 class="text-base font-black tracking-tight">
                    Specialized Browsing Portals
                </h2>
            </div>
            <span class="text-xs font-bold text-slate-400">Live Applications</span>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            
            <!-- GCC Citizens Applications -->
            <div class="bg-white rounded-3xl p-6 sm:p-8 border border-emerald-100 shadow-card flex flex-col justify-between space-y-6 bg-gradient-to-br from-white via-white to-emerald-50/30">
                <div class="space-y-3">
                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-50 text-emerald-700 text-[11px] font-black border border-emerald-200">
                        <i class="fa-regular fa-circle-check text-xs"></i>
                        <span>GCC Citizens</span>
                    </span>
                    <div>
                        <h3 class="text-lg font-black text-slate-900">GCC Citizens Applications</h3>
                        <p class="text-xs text-slate-500 font-semibold mt-1 leading-relaxed">
                            Direct access to CV applications from citizens of Kuwait and GCC member states.
                        </p>
                    </div>
                </div>

                <div class="flex items-center justify-between pt-2">
                    <span class="text-[11px] font-bold text-slate-400">Kuwait & GCC Region</span>
                    <a href="{{ route('employer.browse') }}?specialCategory=gcc" 
                       class="px-5 py-2.5 rounded-2xl bg-emerald-600 hover:bg-emerald-700 text-white font-black text-xs shadow-md shadow-emerald-500/20 transition flex items-center gap-1.5">
                        <span>Browse Section</span>
                        <i class="fa-solid fa-arrow-right text-[10px]"></i>
                    </a>
                </div>
            </div>

            <!-- Stateless (Bedoun) Applications -->
            <div class="bg-white rounded-3xl p-6 sm:p-8 border border-pink-100 shadow-card flex flex-col justify-between space-y-6 bg-gradient-to-br from-white via-white to-pink-50/30">
                <div class="space-y-3">
                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-pink-50 text-pink-700 text-[11px] font-black border border-pink-200">
                        <i class="fa-regular fa-file-lines text-xs"></i>
                        <span>Stateless (Bedoun)</span>
                    </span>
                    <div>
                        <h3 class="text-lg font-black text-slate-900">No Nationality Applications</h3>
                        <p class="text-xs text-slate-500 font-semibold mt-1 leading-relaxed">
                            Explore skilled candidate applications and CVs from stateless residents in Kuwait.
                        </p>
                    </div>
                </div>

                <div class="flex items-center justify-between pt-2">
                    <span class="text-[11px] font-bold text-slate-400">Kuwait Residents</span>
                    <a href="{{ route('employer.browse') }}?specialCategory=bedoun" 
                       class="px-5 py-2.5 rounded-2xl bg-gradient-to-r from-pink-600 to-rose-600 hover:from-pink-700 hover:to-rose-700 text-white font-black text-xs shadow-md shadow-pink-500/20 transition flex items-center gap-1.5">
                        <span>Browse Section</span>
                        <i class="fa-solid fa-arrow-right text-[10px]"></i>
                    </a>
                </div>
            </div>

        </div>
    </div>

</div>
@endsection
