@extends('layouts.employer')

@section('title', ($sector['name_en'] ?? 'Sector') . ' - Professions | Direct Work Kuwait')

@section('content')
<div class="space-y-6 max-w-7xl mx-auto">
    
    <!-- Breadcrumb -->
    <div class="flex items-center gap-2 text-xs font-semibold text-slate-500">
        <a href="{{ route('employer.browse') }}" class="hover:text-blue-600">Browse</a>
        <span>/</span>
        <span class="text-blue-600 font-bold">{{ $sector['name_en'] ?? 'Sector' }}</span>
    </div>

    <!-- Main Two-Column Layout (Matching Screenshot 5) -->
    <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
        
        <!-- Left Sub-Sectors Navigation Column (lg:col-span-3) -->
        <div class="lg:col-span-3 bg-white rounded-3xl p-5 border border-slate-200/90 shadow-card space-y-4 sticky top-20">
            <div>
                <a href="{{ route('employer.browse') }}" class="inline-flex items-center gap-2 text-xs font-bold text-slate-500 hover:text-blue-600 transition mb-3">
                    <i class="fa-solid fa-arrow-left text-[10px]"></i>
                    <span>Back to Sectors</span>
                </a>
                <h2 class="text-base font-black text-slate-900 leading-tight">
                    {{ $sector['name_en'] ?? 'Sector' }}
                </h2>
            </div>

            <div class="space-y-1 pt-2 border-t border-slate-100">
                <!-- All Sub-sectors -->
                <a href="{{ route('employer.browse.sector', $sector['code']) }}" 
                   class="flex items-center justify-between px-3.5 py-2.5 rounded-2xl text-xs font-bold transition {{ ($activeSubSector ?? 'all') === 'all' ? 'bg-gradient-to-r from-blue-600 to-blue-700 text-white shadow-md shadow-blue-500/25' : 'text-slate-600 hover:bg-slate-50' }}">
                    <span>All Sub-Sectors</span>
                    <span class="text-[10px] opacity-80">{{ count($sector['professions'] ?? []) }}</span>
                </a>

                <!-- Individual Sub-sectors -->
                @foreach(($sector['subSectors'] ?? []) as $sub)
                    @php
                        $subCount = count(array_filter($sector['professions'] ?? [], fn($p) => ($p['subSector'] ?? '') === $sub));
                        $isActive = ($activeSubSector ?? '') === $sub;
                    @endphp
                    <a href="{{ route('employer.browse.sector', $sector['code']) }}?subSector={{ urlencode($sub) }}" 
                       class="flex items-center justify-between px-3.5 py-2.5 rounded-2xl text-xs font-bold transition {{ $isActive ? 'bg-gradient-to-r from-blue-600 to-blue-700 text-white shadow-md shadow-blue-500/25' : 'text-slate-600 hover:bg-slate-50' }}">
                        <span class="truncate pr-2">{{ $sub }}</span>
                        <span class="text-[10px] px-1.5 py-0.5 rounded-full {{ $isActive ? 'bg-white/20 text-white' : 'bg-slate-100 text-slate-500' }}">
                            {{ $subCount }}
                        </span>
                    </a>
                @endforeach
            </div>
        </div>

        <!-- Right Professions Column (lg:col-span-9) -->
        <div class="lg:col-span-9 space-y-6">
            
            <!-- Top Header & Search Bar -->
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <h1 class="text-2xl font-black text-slate-900 tracking-tight">
                    Professions
                </h1>

                <!-- Search Input inside Professions -->
                <div class="flex items-center gap-2">
                    <div class="relative w-64">
                        <input type="text" id="profSearch" onkeyup="filterProfessions()" 
                               placeholder="Search profession..." 
                               class="w-full text-xs font-medium rounded-full border border-slate-200 bg-white py-2 pl-4 pr-9 focus:border-blue-600 focus:ring-4 focus:ring-blue-100 transition">
                        <i class="fa-solid fa-magnifying-glass absolute right-3 top-2.5 text-xs text-slate-400"></i>
                    </div>
                </div>
            </div>

            <!-- Current Sub-Sector Group Title -->
            <div class="text-sm font-black text-blue-700 uppercase tracking-wider">
                {{ ($activeSubSector ?? 'all') === 'all' ? 'All Available Professions' : $activeSubSector }}
            </div>

            <!-- 4-Column Professions Grid (Matching Screenshot 5 in Royal Blue Theme) -->
            <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4" id="professionsGrid">
                @foreach($professions as $prof)
                    <a href="{{ route('employer.browse.profession', ['sector' => $sector['code'], 'profession' => $prof['id']]) }}" 
                       class="prof-card group bg-white rounded-3xl border border-slate-200/90 shadow-card hover:shadow-xl hover:border-blue-300 transition overflow-hidden flex flex-col justify-between">
                        
                        <!-- Top Half: Direct Work Royal Blue Branding Badge -->
                        <div class="h-32 bg-gradient-to-br from-blue-700 via-blue-600 to-indigo-800 p-4 flex flex-col items-center justify-center text-center text-white relative">
                            <img src="{{ asset('images/logo.png') }}" alt="DW" class="w-12 h-12 object-contain mb-1 drop-shadow">
                            <span class="text-[9px] font-black tracking-widest uppercase opacity-90">DIRECT WORK</span>
                        </div>

                        <!-- Bottom Half: Profession Info & Arrow -->
                        <div class="p-3.5 bg-white flex items-center justify-between gap-2 border-t border-slate-100">
                            <div class="flex items-center gap-2 min-w-0">
                                <i class="fa-solid fa-briefcase text-blue-600 text-xs shrink-0"></i>
                                <span class="prof-name text-[11px] font-black text-slate-900 group-hover:text-blue-600 transition truncate leading-tight">
                                    {{ $prof['name_en'] }}
                                </span>
                            </div>
                            <span class="w-6 h-6 rounded-full bg-blue-50 text-blue-600 flex items-center justify-center text-[10px] group-hover:bg-blue-600 group-hover:text-white transition shrink-0">
                                <i class="fa-solid fa-arrow-right text-[8px]"></i>
                            </span>
                        </div>

                    </a>
                @endforeach
            </div>

        </div>

    </div>

</div>

<script>
function filterProfessions() {
    const input = document.getElementById('profSearch').value.toLowerCase();
    const cards = document.querySelectorAll('.prof-card');
    cards.forEach(card => {
        const name = card.querySelector('.prof-name').innerText.toLowerCase();
        if (name.includes(input)) {
            card.style.display = '';
        } else {
            card.style.display = 'none';
        }
    });
}
</script>
@endsection
