<!DOCTYPE html>
<html lang="{{ $currentLocale ?? 'en' }}" dir="{{ ($isArabic ?? false) ? 'rtl' : 'ltr' }}" class="h-full">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>@yield('title', 'Employer Portal | Direct Work Kuwait')</title>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;500;600;700;800;900&family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: {
                            50: '#eff6ff',
                            100: '#dbeafe',
                            200: '#bfdbfe',
                            600: '#2563eb',
                            700: '#1d4ed8',
                            800: '#1e40af',
                            900: '#1e3a8a',
                        }
                    },
                    fontFamily: {
                        sans: ['Plus Jakarta Sans', 'Cairo', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    <style>
        body {
            font-family: 'Plus Jakarta Sans', 'Cairo', sans-serif;
            background-color: #F8FAFC;
        }
    </style>
</head>
<body class="min-h-full flex text-slate-900 antialiased selection:bg-blue-600 selection:text-white">

    <!-- LEFT SIDEBAR -->
    <aside class="w-64 bg-white border-r border-slate-200/90 shrink-0 flex flex-col justify-between hidden md:flex sticky top-0 h-screen overflow-y-auto">
        <div class="p-6 space-y-6">
            
            <!-- Brand Logo -->
            <a href="{{ route('employer.dashboard') }}" class="flex items-center gap-3">
                <img src="{{ asset('images/logo.png') }}" alt="Direct Work" class="w-10 h-10 object-contain rounded-2xl shadow-xs">
                <div>
                    <span class="text-lg font-black text-slate-900 tracking-tight leading-none block">
                        DIRECT WORK
                    </span>
                    <span class="text-[9px] font-black text-blue-600 tracking-widest uppercase mt-0.5 block">
                        EMPLOYER PORTAL
                    </span>
                </div>
            </a>

            <!-- Main Navigation Links -->
            <div>
                <span class="text-[10px] font-black text-slate-400 uppercase tracking-wider block mb-3">
                    NAVIGATION
                </span>
                <nav class="space-y-1">
                    @php $route = request()->route()->getName(); @endphp

                    <!-- Dashboard -->
                    <a href="{{ route('employer.dashboard') }}" 
                       class="flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-xs font-bold transition {{ str_contains($route, 'dashboard') ? 'bg-gradient-to-r from-blue-600 to-blue-700 text-white shadow-md shadow-blue-500/25' : 'text-slate-600 hover:bg-slate-50 hover:text-blue-600' }}">
                        <i class="fa-solid fa-table-cells-large text-sm"></i>
                        <span>Dashboard</span>
                    </a>

                    <!-- Browse -->
                    <a href="{{ route('employer.browse') }}" 
                       class="flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-xs font-bold transition {{ str_contains($route, 'browse') ? 'bg-gradient-to-r from-blue-600 to-blue-700 text-white shadow-md shadow-blue-500/25' : 'text-slate-600 hover:bg-slate-50 hover:text-blue-600' }}">
                        <i class="fa-regular fa-compass text-sm"></i>
                        <span>Browse</span>
                    </a>

                    <!-- Chats -->
                    <a href="{{ route('chats.index') }}" 
                       class="flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-xs font-bold transition text-slate-600 hover:bg-slate-50 hover:text-blue-600">
                        <i class="fa-regular fa-comment-dots text-sm"></i>
                        <span>Chats</span>
                    </a>

                    <!-- Saved -->
                    <a href="{{ route('employer.browse') }}?saved=1" 
                       class="flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-xs font-bold transition text-slate-600 hover:bg-slate-50 hover:text-blue-600">
                        <i class="fa-regular fa-bookmark text-sm"></i>
                        <span>Saved</span>
                    </a>

                    <!-- Company Profile -->
                    <a href="{{ route('employer.profile') }}" 
                       class="flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-xs font-bold transition {{ str_contains($route, 'profile') ? 'bg-gradient-to-r from-blue-600 to-blue-700 text-white shadow-md shadow-blue-500/25' : 'text-slate-600 hover:bg-slate-50 hover:text-blue-600' }}">
                        <i class="fa-regular fa-id-badge text-sm"></i>
                        <span>Company Profile</span>
                    </a>

                    <!-- Settings -->
                    <a href="{{ route('employer.settings') }}" 
                       class="flex items-center gap-3 px-3.5 py-2.5 rounded-2xl text-xs font-bold transition {{ str_contains($route, 'settings') ? 'bg-gradient-to-r from-blue-600 to-blue-700 text-white shadow-md shadow-blue-500/25' : 'text-slate-600 hover:bg-slate-50 hover:text-blue-600' }}">
                        <i class="fa-solid fa-gear text-sm"></i>
                        <span>Settings</span>
                    </a>
                </nav>
            </div>

            <!-- Special Applications -->
            <div>
                <span class="text-[10px] font-black text-slate-400 uppercase tracking-wider block mb-3">
                    SPECIAL APPLICATIONS
                </span>
                <nav class="space-y-1">
                    <a href="{{ route('employer.browse') }}?specialCategory=gcc" 
                       class="flex items-center gap-2.5 px-3.5 py-2 rounded-2xl text-xs font-bold text-slate-600 hover:bg-slate-50 hover:text-emerald-600 transition">
                        <i class="fa-regular fa-circle-check text-emerald-500 text-xs"></i>
                        <span>GCC Citizens</span>
                    </a>
                    <a href="{{ route('employer.browse') }}?specialCategory=bedoun" 
                       class="flex items-center gap-2.5 px-3.5 py-2 rounded-2xl text-xs font-bold text-slate-600 hover:bg-slate-50 hover:text-pink-600 transition">
                        <i class="fa-regular fa-file-lines text-pink-500 text-xs"></i>
                        <span>Bedoun (Stateless)</span>
                    </a>
                </nav>
            </div>

        </div>

        <!-- Need Help Card at Bottom of Sidebar -->
        <div class="p-4 border-t border-slate-100">
            <div class="p-4 rounded-2xl bg-gradient-to-br from-blue-50 to-indigo-50/60 border border-blue-200/70 text-center space-y-2">
                <div class="w-8 h-8 rounded-full bg-white text-blue-600 flex items-center justify-center mx-auto shadow-xs text-xs font-bold">
                    <i class="fa-solid fa-headset"></i>
                </div>
                <div class="text-[11px] font-black text-slate-900">Need help?</div>
                <div class="text-[9.5px] text-slate-500 font-medium leading-relaxed">
                    Contact support for assistance with finding candidates.
                </div>
                <a href="https://wa.me/96566707126" target="_blank" 
                   class="inline-block w-full py-2 rounded-xl bg-gradient-to-r from-blue-600 to-blue-700 text-white font-black text-[10px] shadow-xs hover:from-blue-700 hover:to-blue-800 transition">
                    Contact Support ↗
                </a>
            </div>
        </div>
    </aside>

    <!-- MAIN APP WRAPPER -->
    <div class="flex-1 flex flex-col min-w-0">
        
        <!-- TOP APP BAR -->
        <header class="bg-white border-b border-slate-200/90 h-16 px-4 sm:px-8 flex items-center justify-between sticky top-0 z-30">
            
            <!-- Global Candidate Search Input -->
            <form action="{{ route('employer.browse') }}" method="GET" class="w-full max-w-md hidden sm:block">
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                        <i class="fa-solid fa-magnifying-glass text-xs"></i>
                    </div>
                    <input type="text" name="q" value="{{ request('q') }}"
                           placeholder="Search candidates by profession or skill..."
                           class="w-full text-xs font-medium rounded-full border border-slate-200 bg-slate-50/60 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 py-2 pl-9 pr-4 transition">
                </div>
            </form>

            <!-- Right Actions Bar -->
            <div class="flex items-center gap-3 ml-auto">
                
                <!-- Quick Add Vacancy Button -->
                <a href="{{ route('jobs.create') }}" 
                   class="w-8 h-8 rounded-full bg-blue-50 text-blue-700 hover:bg-blue-100 flex items-center justify-center text-xs font-black transition"
                   title="Post Job Vacancy">
                    <i class="fa-solid fa-plus"></i>
                </a>

                <!-- Notification Bell -->
                <button type="button" 
                        class="w-8 h-8 rounded-full bg-slate-50 text-slate-600 hover:bg-slate-100 flex items-center justify-center text-xs relative transition">
                    <i class="fa-regular fa-bell"></i>
                    <span class="absolute top-1.5 right-1.5 w-1.5 h-1.5 rounded-full bg-blue-600"></span>
                </button>

                <!-- Language Switcher -->
                <div class="px-2.5 py-1 rounded-full bg-slate-100 text-[10px] font-black text-slate-700">
                    <a href="{{ route('locale.set', ($isArabic ?? false) ? 'en' : 'ar') }}">
                        {{ ($isArabic ?? false) ? 'EN' : 'AR' }}
                    </a>
                </div>

                <!-- Kuwait Flag -->
                <div class="w-7 h-7 rounded-full bg-slate-100 flex items-center justify-center text-xs border border-slate-200">
                    🇰🇼
                </div>

                <!-- Logged In User Avatar Dropdown -->
                <div class="relative group">
                    @php
                        $user = session('auth_user') ?? ['company_name' => 'Employer Portal', 'full_name' => 'HR Recruiter'];
                        $name = $user['company_name'] ?? $user['full_name'] ?? 'Employer';
                        $initials = strtoupper(substr($name, 0, 2));
                    @endphp
                    <button class="flex items-center gap-2 pl-2 pr-3 py-1 rounded-full bg-slate-50 border border-slate-200 hover:bg-slate-100 transition">
                        <div class="w-7 h-7 rounded-full bg-gradient-to-r from-blue-600 to-blue-700 text-white font-black text-[10px] flex items-center justify-center shadow-xs">
                            {{ $initials }}
                        </div>
                        <div class="text-left hidden lg:block">
                            <span class="text-[11px] font-black text-slate-900 block leading-tight max-w-[100px] truncate">{{ $name }}</span>
                            <span class="text-[9px] font-semibold text-blue-600 block leading-tight">Employer Portal</span>
                        </div>
                        <i class="fa-solid fa-chevron-down text-[8px] text-slate-400"></i>
                    </button>

                    <!-- Dropdown Menu -->
                    <div class="absolute right-0 mt-2 w-48 bg-white rounded-2xl shadow-xl border border-slate-100 p-1.5 hidden group-hover:block transition z-50">
                        <a href="{{ route('employer.profile') }}" class="flex items-center gap-2 px-3 py-2 rounded-xl text-xs font-bold text-slate-700 hover:bg-slate-50 transition">
                            <i class="fa-regular fa-id-badge text-blue-600 text-xs"></i>
                            <span>Company Profile</span>
                        </a>
                        <a href="{{ route('employer.settings') }}" class="flex items-center gap-2 px-3 py-2 rounded-xl text-xs font-bold text-slate-700 hover:bg-slate-50 transition">
                            <i class="fa-solid fa-gear text-blue-600 text-xs"></i>
                            <span>Account Settings</span>
                        </a>
                        <div class="my-1 border-t border-slate-100"></div>
                        <form action="{{ route('logout') }}" method="POST">
                            @csrf
                            <button type="submit" class="w-full flex items-center gap-2 px-3 py-2 rounded-xl text-xs font-bold text-red-600 hover:bg-red-50 transition">
                                <i class="fa-solid fa-arrow-right-from-bracket text-xs"></i>
                                <span>Sign Out</span>
                            </button>
                        </form>
                    </div>
                </div>

            </div>
        </header>

        <!-- MAIN CONTENT -->
        <main class="flex-1 p-4 sm:p-8">
            @if(session('success'))
                <div class="mb-6 p-4 rounded-2xl bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs font-bold flex items-center justify-between">
                    <div class="flex items-center gap-2">
                        <i class="fa-solid fa-circle-check text-emerald-600 text-sm"></i>
                        <span>{{ session('success') }}</span>
                    </div>
                    <button type="button" onclick="this.parentElement.remove()" class="text-emerald-500 hover:text-emerald-800"><i class="fa-solid fa-xmark"></i></button>
                </div>
            @endif

            @yield('content')
        </main>

        <!-- FOOTER -->
        <footer class="py-6 px-8 text-center text-xs text-slate-400 font-semibold border-t border-slate-200/80 bg-white">
            © {{ date('Y') }} Direct Work Kuwait. All Rights Reserved.
        </footer>

    </div>

</body>
</html>
