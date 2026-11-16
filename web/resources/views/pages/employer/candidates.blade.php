@extends('layouts.employer')

@section('title', $profName . ' - Applicants | Direct Work Kuwait')

@section('content')
<div class="space-y-6 max-w-7xl mx-auto">
    
    <!-- Top Breadcrumb -->
    <div class="flex items-center gap-2 text-xs font-semibold text-slate-500">
        <a href="{{ route('employer.browse') }}" class="hover:text-blue-600">Browse</a>
        <span>/</span>
        <a href="{{ route('employer.browse.sector', $sector['code'] ?? 'construction') }}" class="hover:text-blue-600">
            {{ $sector['name_en'] ?? 'Sector' }}
        </a>
        <span>/</span>
        <span class="text-blue-600 font-bold">{{ $profName }}</span>
    </div>

    <!-- Main Two-Column Layout (Matching Screenshot 6) -->
    <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
        
        <!-- Left Filters Column (lg:col-span-3) -->
        <div class="lg:col-span-3 bg-white rounded-3xl p-5 border border-slate-200/90 shadow-card space-y-4 sticky top-20">
            
            <div class="flex items-center justify-between pb-3 border-b border-slate-100">
                <div class="flex items-center gap-2 font-black text-xs text-slate-900 uppercase tracking-wider">
                    <i class="fa-solid fa-sliders text-blue-600"></i>
                    <span>Filters</span>
                </div>
                <a href="{{ url()->current() }}" class="text-slate-400 hover:text-slate-700 text-xs" title="Reset Filters">
                    <i class="fa-solid fa-rotate-right"></i>
                </a>
            </div>

            <form action="{{ url()->current() }}" method="GET" class="space-y-4 text-xs font-bold text-slate-700">
                
                <!-- Case Type -->
                <div>
                    <label class="block text-[10px] font-black uppercase text-slate-400 mb-1.5">
                        CASE TYPE
                    </label>
                    <select name="caseType" onchange="this.form.submit()"
                            class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/60 py-2.5 px-3 focus:border-blue-600 focus:bg-white transition">
                        <option value="all" {{ ($caseType ?? 'all') === 'all' ? 'selected' : '' }}>All</option>
                        <option value="inside" {{ ($caseType ?? '') === 'inside' ? 'selected' : '' }}>Inside Kuwait</option>
                        <option value="outside" {{ ($caseType ?? '') === 'outside' ? 'selected' : '' }}>Outside Kuwait</option>
                        <option value="part_time" {{ ($caseType ?? '') === 'part_time' ? 'selected' : '' }}>Part-time</option>
                    </select>
                </div>

                <!-- Special Category -->
                <div>
                    <label class="block text-[10px] font-black uppercase text-slate-400 mb-1.5">
                        SPECIAL CATEGORY
                    </label>
                    <select name="specialCategory" onchange="this.form.submit()"
                            class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/60 py-2.5 px-3 focus:border-blue-600 focus:bg-white transition">
                        <option value="all" {{ request('specialCategory') === 'all' ? 'selected' : '' }}>All Applicants</option>
                        <option value="gcc" {{ request('specialCategory') === 'gcc' ? 'selected' : '' }}>GCC Citizens</option>
                        <option value="bedoun" {{ request('specialCategory') === 'bedoun' ? 'selected' : '' }}>Stateless (Bedoun)</option>
                    </select>
                </div>

                <!-- Sort -->
                <div>
                    <label class="block text-[10px] font-black uppercase text-slate-400 mb-1.5">
                        SORT
                    </label>
                    <select name="sort" onchange="this.form.submit()"
                            class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/60 py-2.5 px-3 focus:border-blue-600 focus:bg-white transition">
                        <option value="newest">Newest</option>
                        <option value="experience">Most Experienced</option>
                        <option value="views">Most Viewed</option>
                    </select>
                </div>

                <!-- Search by Name -->
                <div>
                    <label class="block text-[10px] font-black uppercase text-slate-400 mb-1.5">
                        SEARCH BY NAME
                    </label>
                    <input type="text" name="name" value="{{ request('name') }}" 
                           placeholder="Type a name..."
                           class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/60 py-2.5 px-3 focus:border-blue-600 focus:bg-white transition">
                </div>

                <!-- Experience -->
                <div>
                    <label class="block text-[10px] font-black uppercase text-slate-400 mb-1.5">
                        EXPERIENCE
                    </label>
                    <select name="exp" onchange="this.form.submit()"
                            class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/60 py-2.5 px-3 focus:border-blue-600 focus:bg-white transition">
                        <option value="any">Any</option>
                        <option value="1-3">1 - 3 Years</option>
                        <option value="4-7">4 - 7 Years</option>
                        <option value="8+">8+ Years</option>
                    </select>
                </div>

                <!-- Nationality -->
                <div>
                    <label class="block text-[10px] font-black uppercase text-slate-400 mb-1.5">
                        NATIONALITY
                    </label>
                    <select name="nationality" onchange="this.form.submit()"
                            class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/60 py-2.5 px-3 focus:border-blue-600 focus:bg-white transition">
                        <option value="any">Any</option>
                        <option value="kw">Kuwait</option>
                        <option value="in">India</option>
                        <option value="eg">Egypt</option>
                        <option value="ph">Philippines</option>
                        <option value="sl">Sierra Leone</option>
                    </select>
                </div>

                <button type="submit" 
                        class="w-full py-2.5 rounded-2xl bg-gradient-to-r from-blue-600 to-blue-700 text-white font-black text-xs shadow-xs hover:from-blue-700 hover:to-blue-800 transition">
                    Apply Filters
                </button>
            </form>

        </div>

        <!-- Right Candidates List Column (lg:col-span-9) -->
        <div class="lg:col-span-9 space-y-6">
            
            <!-- Header -->
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-2xl font-black text-slate-900 tracking-tight">
                        Applicants
                    </h1>
                    <div class="text-xs text-slate-500 font-semibold mt-0.5">
                        Sector: <span class="font-bold text-slate-800">{{ $sector['name_en'] ?? 'Construction' }}</span> · Profession: <span class="font-bold text-blue-600">{{ $profName }}</span>
                    </div>
                </div>

                <span class="px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-xs font-black border border-blue-200">
                    {{ count($applicants) }} Candidates Found
                </span>
            </div>

            <!-- 3-Column Candidate Cards Grid (Matching Screenshot 6) -->
            <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-5">
                @forelse($applicants as $app)
                    @php
                        $avatar = $app['photo_url'] ?? 'images/candidate_worker1.jpg';
                        $phone = $app['phone'] ?? '+965 6670 7126';
                        $cleanPhone = preg_replace('/[^0-9]/', '', $phone);
                        $whatsapp = $app['whatsapp'] ?? $phone;
                        $cleanWa = preg_replace('/[^0-9]/', '', $whatsapp);
                    @endphp
                    <div class="bg-white rounded-3xl p-5 border border-slate-200/90 shadow-card hover:shadow-xl hover:border-blue-300 transition flex flex-col justify-between space-y-4">
                        
                        <!-- Top Row: Avatar, Profession, Bookmark -->
                        <div class="space-y-3">
                            <div class="flex items-start justify-between gap-3">
                                <div class="flex items-center gap-3 min-w-0">
                                    <div class="w-12 h-12 rounded-2xl overflow-hidden bg-slate-100 shrink-0 border border-slate-200">
                                        <img src="{{ asset($avatar) }}" 
                                             alt="{{ $app['name'] ?? 'Candidate' }}" 
                                             class="w-full h-full object-cover">
                                    </div>
                                    <div class="min-w-0">
                                        <span class="text-[10px] font-black text-blue-600 block truncate">
                                            {{ $app['profession'] ?? $profName }}
                                        </span>
                                        <h3 class="text-sm font-black text-slate-900 truncate">
                                            {{ $app['name'] ?? 'Verified Candidate' }}
                                        </h3>
                                    </div>
                                </div>

                                <button type="button" onclick="toggleBookmark(this)" class="text-slate-300 hover:text-blue-600 transition text-sm">
                                    <i class="fa-regular fa-bookmark"></i>
                                </button>
                            </div>

                            <!-- Badges Row: Flag / Country & Experience -->
                            <div class="flex items-center gap-2 text-xs">
                                <span class="px-2 py-0.5 rounded-lg bg-slate-100 text-slate-700 font-bold text-[10px] flex items-center gap-1">
                                    <span>📍</span>
                                    <span>{{ $app['nationality'] ?? 'Kuwait' }}</span>
                                </span>
                                <span class="px-2 py-0.5 rounded-lg bg-slate-100 text-slate-700 font-bold text-[10px] flex items-center gap-1">
                                    <i class="fa-solid fa-briefcase text-[9px] text-blue-600"></i>
                                    <span>{{ $app['experience'] ?? '5 yrs exp' }}</span>
                                </span>
                            </div>

                            <!-- Inside Kuwait Status Tag -->
                            <div>
                                <span class="inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full bg-blue-50 text-blue-700 font-black text-[10px] border border-blue-200">
                                    <span class="w-1.5 h-1.5 rounded-full bg-blue-600"></span>
                                    <span>Inside Kuwait</span>
                                </span>
                            </div>

                            <!-- Attached CVs and Certificates (Matching Screenshot 6) -->
                            <div class="space-y-1.5 pt-1">
                                <div class="p-2 rounded-xl bg-slate-50 border border-slate-200/80 text-[10px] font-semibold text-slate-600 flex items-center justify-between">
                                    <span class="flex items-center gap-1.5 truncate">
                                        <i class="fa-solid fa-paperclip text-blue-600 text-[11px]"></i>
                                        <span class="truncate">{{ $app['resume_file_name'] ?? 'Resume_CV_Document.pdf' }}</span>
                                    </span>
                                    <span class="text-[9px] font-bold text-blue-600 shrink-0">CV</span>
                                </div>
                                @if(!empty($app['attachment_images']))
                                    <div class="p-2 rounded-xl bg-slate-50 border border-slate-200/80 text-[10px] font-semibold text-slate-600 flex items-center justify-between">
                                        <span class="flex items-center gap-1.5 truncate">
                                            <i class="fa-solid fa-file-image text-emerald-600 text-[11px]"></i>
                                            <span class="truncate">Experience_Certificate.jpg</span>
                                        </span>
                                        <span class="text-[9px] font-bold text-emerald-600 shrink-0">CERT</span>
                                    </div>
                                @endif
                            </div>
                        </div>

                        <!-- Action Buttons Row (Matching Screenshot 6 in Royal Blue Theme) -->
                        <div class="space-y-2 pt-2 border-t border-slate-100">
                            
                            <!-- Phone Number Button -->
                            <button type="button" onclick="revealPhone(this, '{{ $phone }}')" 
                                    class="w-full py-2 px-3 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-800 font-bold text-xs flex items-center justify-center gap-2 transition">
                                <i class="fa-solid fa-phone text-blue-600 text-xs"></i>
                                <span>Phone Number</span>
                            </button>

                            <!-- WhatsApp Button (Green) -->
                            <a href="https://wa.me/{{ $cleanWa }}" target="_blank" rel="noopener noreferrer" 
                               class="w-full py-2 px-3 rounded-xl bg-emerald-50 hover:bg-emerald-100 text-emerald-700 font-bold text-xs flex items-center justify-center gap-2 transition border border-emerald-200">
                                <i class="fa-brands fa-whatsapp text-sm"></i>
                                <span>WhatsApp</span>
                            </a>

                            <!-- Instant Chat Button (Royal Blue Theme) -->
                            <a href="{{ route('chats.show', $app['id']) }}" 
                               class="w-full py-2 px-3 rounded-xl bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-black text-xs flex items-center justify-center gap-2 shadow-xs transition">
                                <i class="fa-regular fa-comment-dots text-xs"></i>
                                <span>Chat</span>
                            </a>

                            <!-- Views Counter -->
                            <div class="text-[10px] text-slate-400 font-semibold text-center pt-1">
                                👁 {{ $app['views'] ?? rand(5, 45) }} views
                            </div>

                        </div>

                    </div>
                @empty
                    <div class="col-span-3 text-center py-16 bg-white rounded-3xl border border-slate-200 shadow-xs space-y-3">
                        <div class="w-12 h-12 rounded-full bg-blue-50 text-blue-600 flex items-center justify-center mx-auto text-xl">
                            <i class="fa-solid fa-user-slash"></i>
                        </div>
                        <h3 class="text-base font-black text-slate-900">No candidates found</h3>
                        <p class="text-xs text-slate-500 font-semibold">Try adjusting your filters or search keywords.</p>
                    </div>
                @endforelse
            </div>

        </div>

    </div>

</div>

<script>
function revealPhone(button, phone) {
    button.innerHTML = '<i class="fa-solid fa-phone text-blue-600 text-xs"></i> <a href="tel:' + phone + '" class="text-blue-700 font-black">' + phone + '</a>';
}

function toggleBookmark(button) {
    const icon = button.querySelector('i');
    if (icon.classList.contains('fa-regular')) {
        icon.classList.remove('fa-regular');
        icon.classList.add('fa-solid');
        icon.classList.add('text-blue-600');
    } else {
        icon.classList.remove('fa-solid');
        icon.classList.remove('text-blue-600');
        icon.classList.add('fa-regular');
    }
}
</script>
@endsection
