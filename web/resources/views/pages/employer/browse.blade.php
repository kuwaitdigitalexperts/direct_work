@extends('layouts.employer')

@section('title', 'Browse Applicants by Sector | Direct Work Kuwait')

@section('content')
<div class="space-y-8 max-w-7xl mx-auto">
    
    <!-- Top Header -->
    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
        <div>
            <div class="flex items-center gap-3">
                <h1 class="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight">
                    Browse Applicants by Sector
                </h1>
                <span class="px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-xs font-black border border-blue-200">
                    {{ count($sectors) }} Sectors
                </span>
            </div>
            <p class="text-xs sm:text-sm font-semibold text-slate-500 mt-1">
                All opportunities
            </p>
        </div>

        <div>
            <span class="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-slate-100 border border-slate-200 text-slate-700 text-xs font-bold">
                <i class="fa-regular fa-compass text-blue-600"></i>
                <span>Kuwait Talent Explorer</span>
            </span>
        </div>
    </div>

    <!-- Hero Dark Banner (Matching Screenshot 4) -->
    <div class="relative rounded-3xl overflow-hidden bg-gradient-to-r from-slate-950 via-blue-950 to-slate-900 text-white p-8 sm:p-10 shadow-2xl border border-blue-900/50">
        <div class="absolute -right-6 -bottom-6 opacity-15 pointer-events-none">
            <i class="fa-solid fa-city text-9xl text-blue-400"></i>
        </div>

        <div class="relative z-10 space-y-4 max-w-2xl">
            <span class="text-[10px] font-black text-blue-400 uppercase tracking-widest block">
                TALENT, DISCOVERED
            </span>
            <h2 class="text-3xl sm:text-4xl font-black leading-tight tracking-tight text-white">
                Find the right talent.<br><span class="text-blue-400">Build the future.</span>
            </h2>
            <p class="text-xs sm:text-sm text-slate-300 font-medium leading-relaxed">
                Access 10,000+ active candidates across 27+ specialized sectors in Kuwait. Direct phone, WhatsApp, and verified CVs.
            </p>

            <!-- Metrics inside Banner -->
            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 pt-4 border-t border-white/10">
                <div class="flex items-center gap-3">
                    <div class="w-8 h-8 rounded-xl bg-blue-600/30 border border-blue-400/30 text-blue-300 flex items-center justify-center text-xs">
                        <i class="fa-solid fa-users"></i>
                    </div>
                    <div>
                        <div class="text-xs font-black text-white">10,000+</div>
                        <div class="text-[10px] text-slate-400 font-medium">Active Candidates</div>
                    </div>
                </div>
                <div class="flex items-center gap-3">
                    <div class="w-8 h-8 rounded-xl bg-blue-600/30 border border-blue-400/30 text-blue-300 flex items-center justify-center text-xs">
                        <i class="fa-solid fa-building"></i>
                    </div>
                    <div>
                        <div class="text-xs font-black text-white">27+</div>
                        <div class="text-[10px] text-slate-400 font-medium">Sectors</div>
                    </div>
                </div>
                <div class="flex items-center gap-3">
                    <div class="w-8 h-8 rounded-xl bg-blue-600/30 border border-blue-400/30 text-blue-300 flex items-center justify-center text-xs">
                        <i class="fa-regular fa-clock"></i>
                    </div>
                    <div>
                        <div class="text-xs font-black text-white">Real-time</div>
                        <div class="text-[10px] text-slate-400 font-medium">Updates Daily</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Search Box and Filters Bar -->
    <div class="bg-white rounded-3xl p-6 border border-slate-200/90 shadow-card space-y-4">
        <form action="{{ route('employer.browse') }}" method="GET" class="flex flex-col md:flex-row gap-3">
            <div class="relative flex-1">
                <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                    <i class="fa-solid fa-magnifying-glass text-xs text-blue-600"></i>
                </div>
                <input type="text" name="q" value="{{ request('q') }}"
                       placeholder="Search by profession, skill, or keyword..."
                       class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/60 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3 pl-10 pr-4 transition">
            </div>

            <div class="w-full md:w-56">
                <select name="availability" 
                        class="w-full text-xs font-medium rounded-2xl border border-slate-200 bg-slate-50/60 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-3 px-4 transition">
                    <option value="all">Select Availability...</option>
                    <option value="immediate" {{ request('availability') === 'immediate' ? 'selected' : '' }}>Immediate Join</option>
                    <option value="transferable" {{ request('availability') === 'transferable' ? 'selected' : '' }}>Transferable Visa (Article 18)</option>
                    <option value="overseas" {{ request('availability') === 'overseas' ? 'selected' : '' }}>Overseas Hiring</option>
                </select>
            </div>

            <div class="flex items-center gap-2">
                <button type="submit" 
                        class="px-6 py-3 rounded-2xl bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-black text-xs shadow-md shadow-blue-500/25 transition flex items-center gap-2">
                    <span>Search</span>
                    <i class="fa-solid fa-arrow-right text-[10px]"></i>
                </button>
                <a href="{{ route('employer.browse') }}" 
                   class="p-3 rounded-2xl border border-slate-200 text-slate-400 hover:text-slate-700 hover:bg-slate-50 transition" 
                   title="Reset Search">
                    <i class="fa-solid fa-rotate-right text-xs"></i>
                </a>
            </div>
        </form>

        <!-- Popular Searches Tags -->
        <div class="flex flex-wrap items-center gap-2 pt-2 border-t border-slate-100 text-xs">
            <span class="text-[11px] font-black text-blue-600 uppercase tracking-wider">POPULAR:</span>
            @foreach(['Civil Engineer', 'Driver', 'Electrician', 'Chef', 'Nurse', 'Accountant', 'Sales'] as $pop)
                <a href="{{ route('employer.browse') }}?q={{ urlencode($pop) }}" 
                   class="px-2.5 py-1 rounded-xl bg-slate-100 hover:bg-blue-50 hover:text-blue-700 text-slate-600 text-[11px] font-semibold transition">
                    {{ $pop }}
                </a>
            @endforeach
        </div>
    </div>

    <!-- Explore by Sector Grid -->
    <div class="space-y-4">
        <div class="flex items-center justify-between">
            <div class="flex items-center gap-2">
                <i class="fa-solid fa-border-all text-blue-600 text-sm"></i>
                <h2 class="text-lg font-black text-slate-900 tracking-tight">
                    Explore by Sector
                </h2>
                <span class="px-2.5 py-0.5 rounded-full bg-blue-50 text-blue-700 text-[10px] font-black border border-blue-200">
                    {{ count($sectors) }} found
                </span>
            </div>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            @foreach($sectors as $sec)
                <a href="{{ route('employer.browse.sector', $sec['code']) }}" 
                   class="group bg-white rounded-3xl border border-slate-200/90 shadow-card hover:shadow-xl hover:border-blue-300 transition overflow-hidden flex flex-col justify-between">
                    
                    <div class="p-6 space-y-3">
                        <div class="flex items-center justify-between">
                            <span class="text-[10px] font-black text-blue-600 uppercase tracking-wider">
                                {{ count($sec['professions'] ?? []) }} Professions
                            </span>
                            <span class="w-8 h-8 rounded-full bg-blue-50 text-blue-600 flex items-center justify-center text-xs group-hover:bg-blue-600 group-hover:text-white transition">
                                <i class="fa-solid fa-arrow-right text-[10px]"></i>
                            </span>
                        </div>

                        <h3 class="text-base font-black text-slate-900 group-hover:text-blue-600 transition leading-snug">
                            {{ ($isArabic ?? false) ? ($sec['name_ar'] ?? $sec['name_en']) : $sec['name_en'] }}
                        </h3>

                        <!-- Sector Thumbnail Graphic -->
                        <div class="h-32 rounded-2xl bg-gradient-to-br from-blue-900 via-blue-800 to-indigo-950 p-4 relative overflow-hidden flex items-end">
                            <div class="absolute inset-0 opacity-20 bg-cover bg-center" style="background-image: url('{{ asset($sec['image'] ?? 'images/sectors/sector_construction.jpg') }}')"></div>
                            <div class="relative z-10 text-white space-y-1">
                                <div class="text-[11px] font-black tracking-tight">Verified Talents</div>
                                <div class="text-[9px] text-blue-200">Immediate Phone & WhatsApp</div>
                            </div>
                        </div>
                    </div>

                    <div class="px-6 py-3 bg-slate-50 border-t border-slate-100 flex items-center justify-between text-xs text-slate-500 font-semibold">
                        <span>Browse sub-sectors</span>
                        <i class="fa-solid fa-chevron-right text-[10px] text-slate-400 group-hover:text-blue-600 transition"></i>
                    </div>

                </a>
            @endforeach
        </div>
    </div>

</div>
@endsection
