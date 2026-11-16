@extends('layouts.app')

@section('title', ($isArabic ?? false) ? 'محادثة مع ' . ($candidate['name'] ?? 'المرشح') . ' | دايركت وورك' : 'Chat with ' . ($candidate['name'] ?? 'Candidate') . ' | Direct Work')

@section('content')
<div class="max-w-4xl mx-auto px-4 py-6">

    <!-- Chat Card -->
    <div class="bg-white rounded-3xl border border-slate-200 shadow-card overflow-hidden flex flex-col h-[75vh]">
        
        <!-- Header -->
        <div class="p-4 border-b border-slate-100 bg-white flex items-center justify-between gap-4 shrink-0">
            <div class="flex items-center gap-3 min-w-0">
                <a href="{{ route('chats.index') }}" class="p-2 rounded-xl hover:bg-slate-100 text-slate-500 hover:text-slate-800 transition">
                    <i class="fa-solid fa-arrow-left {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
                </a>
                <div class="relative">
                    <img src="{{ $candidate['photo_url'] ?? asset('images/default_avatar.png') }}" 
                         alt="{{ $candidate['name'] ?? '' }}"
                         class="w-11 h-11 rounded-2xl object-cover border border-slate-200">
                    <span class="absolute -bottom-0.5 -right-0.5 w-3 h-3 bg-emerald-500 border-2 border-white rounded-full"></span>
                </div>
                <div class="min-w-0">
                    <h2 class="text-sm font-black text-slate-900 truncate">
                        {{ $candidate['name'] ?? 'Candidate' }}
                    </h2>
                    <p class="text-xs text-blue-600 font-semibold truncate">
                        {{ ($isArabic ?? false) ? ($candidate['profession_ar'] ?? $candidate['profession']) : ($candidate['profession_en'] ?? $candidate['profession']) }}
                    </p>
                </div>
            </div>

            <!-- Direct Contact Actions -->
            <div class="flex items-center gap-2 shrink-0">
                <a href="tel:{{ $candidate['phone'] ?? '+96500000000' }}"
                   class="inline-flex items-center gap-1.5 px-3 py-2 rounded-xl bg-orange-50 hover:bg-orange-100 text-orange-600 text-xs font-bold transition">
                    <i class="fa-solid fa-phone"></i>
                    <span class="hidden sm:inline">{{ ($isArabic ?? false) ? 'اتصال' : 'Call' }}</span>
                </a>
                <a href="https://wa.me/{{ preg_replace('/[^0-9]/', '', $candidate['phone'] ?? '96500000000') }}" target="_blank" rel="noopener noreferrer"
                   class="inline-flex items-center gap-1.5 px-3 py-2 rounded-xl bg-emerald-50 hover:bg-emerald-100 text-emerald-600 text-xs font-bold transition">
                    <i class="fa-brands fa-whatsapp"></i>
                    <span class="hidden sm:inline">WhatsApp</span>
                </a>
                <a href="{{ route('applicants.show', $candidate['id']) }}"
                   class="inline-flex items-center gap-1.5 px-3 py-2 rounded-xl bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-bold transition">
                    <i class="fa-solid fa-id-card"></i>
                    <span class="hidden sm:inline">{{ ($isArabic ?? false) ? 'الملف' : 'Profile' }}</span>
                </a>
            </div>
        </div>

        <!-- Messages Area -->
        <div class="flex-1 overflow-y-auto p-4 space-y-4 bg-slate-50/70" id="chatArea">
            <div class="text-center my-2">
                <span class="inline-block px-3 py-1 rounded-full bg-slate-200 text-[10px] text-slate-600 font-bold">
                    {{ ($isArabic ?? false) ? 'المحادثة مشفرة وآمنة عبر دايركت وورك' : 'Direct Work Encrypted Conversation' }}
                </span>
            </div>

            @foreach($messages ?? [] as $msg)
                @if(($msg['sender'] ?? '') === 'candidate')
                    <!-- Candidate Message (Left / Start) -->
                    <div class="flex items-start gap-2.5 max-w-[80%]">
                        <img src="{{ $candidate['photo_url'] ?? asset('images/default_avatar.png') }}" 
                             alt="{{ $candidate['name'] ?? '' }}"
                             class="w-7 h-7 rounded-xl object-cover shrink-0 mt-1">
                        <div>
                            <div class="bg-white p-3.5 rounded-2xl rounded-tl-sm border border-slate-200 text-xs text-slate-800 shadow-sm leading-relaxed">
                                {{ ($isArabic ?? false) ? ($msg['text'] ?? '') : ($msg['text_en'] ?? $msg['text'] ?? '') }}
                            </div>
                            <span class="text-[10px] text-slate-400 mt-1 inline-block px-1">
                                {{ $msg['time'] ?? '10:00 AM' }}
                            </span>
                        </div>
                    </div>
                @else
                    <!-- My / User Message (Right / End) -->
                    <div class="flex items-start justify-end gap-2.5 max-w-[80%] mr-0 ml-auto">
                        <div class="text-right">
                            <div class="bg-blue-600 text-white p-3.5 rounded-2xl rounded-tr-sm text-xs shadow-sm leading-relaxed text-left">
                                {{ ($isArabic ?? false) ? ($msg['text'] ?? '') : ($msg['text_en'] ?? $msg['text'] ?? '') }}
                            </div>
                            <span class="text-[10px] text-slate-400 mt-1 inline-block px-1">
                                {{ $msg['time'] ?? '10:00 AM' }} <i class="fa-solid fa-check-double text-blue-500"></i>
                            </span>
                        </div>
                    </div>
                @endif
            @endforeach

            <!-- Custom session messages sent by user -->
            @foreach(session("chat_{$candidate['id']}", []) as $sessionMsg)
                <div class="flex items-start justify-end gap-2.5 max-w-[80%] mr-0 ml-auto">
                    <div class="text-right">
                        <div class="bg-blue-600 text-white p-3.5 rounded-2xl rounded-tr-sm text-xs shadow-sm leading-relaxed text-left">
                            {{ $sessionMsg['text'] ?? '' }}
                        </div>
                        <span class="text-[10px] text-slate-400 mt-1 inline-block px-1">
                            {{ $sessionMsg['time'] ?? date('h:i A') }} <i class="fa-solid fa-check-double text-blue-500"></i>
                        </span>
                    </div>
                </div>
            @endforeach
        </div>

        <!-- Send Message Box -->
        <form action="{{ route('chats.send', $candidate['id']) }}" method="POST" class="p-3 bg-white border-t border-slate-200 shrink-0 flex items-center gap-2">
            @csrf
            <input type="text" name="message" required autocomplete="off"
                   placeholder="{{ ($isArabic ?? false) ? 'اكتب رسالتك للمرشح هنا...' : 'Type your message to candidate here...' }}"
                   class="flex-1 text-xs rounded-2xl border-slate-300 focus:border-blue-500 focus:ring-blue-500 px-4 py-3">
            <button type="submit"
                    class="px-5 py-3 rounded-2xl bg-blue-600 hover:bg-blue-700 text-white text-xs font-black shadow-md transition shrink-0 flex items-center gap-2">
                <span>{{ ($isArabic ?? false) ? 'إرسال' : 'Send' }}</span>
                <i class="fa-solid fa-paper-plane {{ ($isArabic ?? false) ? 'rotate-180' : '' }}"></i>
            </button>
        </form>

    </div>

</div>

<script>
    // Auto-scroll to bottom of chat
    const chatArea = document.getElementById('chatArea');
    if (chatArea) {
        chatArea.scrollTop = chatArea.scrollHeight;
    }
</script>
@endsection
