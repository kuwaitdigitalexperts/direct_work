@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'المحادثات المباشرة | دايركت وورك' : 'Direct Messages | Direct Work')

@section('content')
<div class="max-w-5xl mx-auto px-4 py-8">

    <div class="mb-6">
        <h1 class="text-2xl font-black text-slate-900">
            {{ ($isArabic ?? false) ? 'المحادثات المباشرة' : 'Direct Messages' }}
        </h1>
        <p class="text-xs text-slate-500 mt-1">
            {{ ($isArabic ?? false) ? 'تواصل مباشرة وفوراً مع الكفاءات والكوادر المهنية' : 'Connect instantly with verified professionals and candidates' }}
        </p>
    </div>

    <div class="bg-white rounded-3xl border border-slate-200 shadow-card overflow-hidden">
        <div class="p-4 border-b border-slate-100 bg-slate-50 flex items-center justify-between">
            <span class="text-xs font-bold text-slate-700">
                <i class="fa-solid fa-comments text-blue-600 {{ ($isArabic ?? false) ? 'ml-1.5' : 'mr-1.5' }}"></i>
                {{ ($isArabic ?? false) ? 'المحادثات المتاحة مع الكوادر' : 'Available Candidate Conversations' }}
            </span>
            <span class="text-xs text-slate-400">
                {{ count($candidates ?? []) }} {{ ($isArabic ?? false) ? 'مرشح' : 'candidates' }}
            </span>
        </div>

        <div class="divide-y divide-slate-100">
            @forelse($candidates ?? [] as $cand)
                <a href="{{ route('chats.show', $cand['id']) }}" class="flex items-center gap-4 p-4 hover:bg-slate-50 transition group">
                    <img src="{{ $cand['photo_url'] ?? asset('images/default_avatar.png') }}" 
                         alt="{{ $cand['name'] ?? '' }}"
                         class="w-13 h-13 rounded-2xl object-cover border border-slate-200 shrink-0">
                    
                    <div class="flex-1 min-w-0">
                        <div class="flex items-center justify-between gap-2">
                            <h3 class="text-sm font-black text-slate-900 group-hover:text-blue-600 transition truncate">
                                {{ $cand['name'] ?? 'Candidate' }}
                            </h3>
                            <span class="text-[10px] text-slate-400 shrink-0">
                                <i class="fa-regular fa-clock"></i> 2h
                            </span>
                        </div>
                        <p class="text-xs font-semibold text-blue-600 truncate mt-0.5">
                            {{ ($isArabic ?? false) ? ($cand['profession_ar'] ?? $cand['profession']) : ($cand['profession_en'] ?? $cand['profession']) }}
                        </p>
                        <p class="text-xs text-slate-500 truncate mt-1">
                            {{ ($isArabic ?? false) ? 'مرحباً، يسعدني التواصل معكم بشأن فرصة العمل المعروضة...' : 'Hello, I am glad to get in touch regarding this employment opportunity...' }}
                        </p>
                    </div>

                    <div class="shrink-0 flex items-center gap-2">
                        <span class="w-2.5 h-2.5 rounded-full bg-emerald-500"></span>
                        <i class="fa-solid fa-chevron-right text-xs text-slate-300 {{ ($isArabic ?? false) ? 'rotate-180' : '' }} group-hover:text-blue-600 transition"></i>
                    </div>
                </a>
            @empty
                <div class="p-12 text-center text-slate-400">
                    <i class="fa-regular fa-comment-dots text-4xl mb-2"></i>
                    <p class="text-xs">{{ ($isArabic ?? false) ? 'لا توجد محادثات نشطة حالياً' : 'No active chats found' }}</p>
                </div>
            @endforelse
        </div>
    </div>

</div>
@endsection
