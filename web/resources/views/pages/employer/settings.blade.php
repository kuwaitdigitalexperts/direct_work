@extends('layouts.employer')

@section('title', 'Account Settings | Direct Work Kuwait')

@section('content')
<div class="max-w-3xl mx-auto space-y-8">
    
    <!-- Top Header -->
    <div>
        <div class="flex items-center gap-2">
            <div class="w-8 h-8 rounded-xl bg-blue-100 text-blue-700 flex items-center justify-center text-sm shadow-xs">
                <i class="fa-solid fa-gear"></i>
            </div>
            <h1 class="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight">
                Account Settings
            </h1>
        </div>
        <p class="text-xs sm:text-sm font-semibold text-slate-500 mt-1">
            Manage your profile, security, and preferences.
        </p>
    </div>

    <!-- Box 1: Change Password (Matching Screenshot 8) -->
    <div class="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200/90 shadow-card space-y-6">
        
        <div class="space-y-1">
            <div class="flex items-center gap-2 text-slate-900">
                <i class="fa-solid fa-lock text-blue-600 text-sm"></i>
                <h2 class="text-base font-black tracking-tight">Change Password</h2>
            </div>
            <p class="text-xs text-slate-500 font-semibold">
                Update your account password securely.
            </p>
        </div>

        <form action="{{ route('employer.settings.password') }}" method="POST" class="space-y-4">
            @csrf

            <div class="relative">
                <input type="password" name="password" id="newPassword" required minlength="6"
                       placeholder="Enter new password..."
                       class="w-full text-xs font-semibold rounded-2xl border border-slate-200 bg-slate-50/50 py-3.5 pl-4 pr-11 focus:bg-white focus:border-blue-600 focus:ring-4 focus:ring-blue-100 transition">
                <button type="button" onclick="togglePass()" class="absolute right-4 top-3.5 text-slate-400 hover:text-slate-600">
                    <i class="fa-regular fa-eye text-sm" id="eyeIcon"></i>
                </button>
            </div>

            <!-- Update Password Button (Royal Blue Theme) -->
            <button type="submit" 
                    class="w-full py-3.5 rounded-2xl bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800 text-white font-black text-xs shadow-md shadow-blue-500/25 transition">
                Update Password
            </button>
        </form>

    </div>

    <!-- Box 2: Danger Zone (Matching Screenshot 8) -->
    <div class="bg-white rounded-3xl p-6 sm:p-8 border border-red-200/80 shadow-card space-y-4">
        
        <div class="space-y-1">
            <div class="flex items-center gap-2 text-red-600">
                <i class="fa-solid fa-triangle-exclamation text-sm"></i>
                <h2 class="text-base font-black tracking-tight">Danger Zone</h2>
            </div>
            <p class="text-xs text-slate-500 font-semibold">
                Securely end your current session and return to the login screen.
            </p>
        </div>

        <div>
            <form action="{{ route('logout') }}" method="POST">
                @csrf
                <button type="submit" 
                        class="px-6 py-2.5 rounded-2xl border border-slate-200 hover:border-red-300 hover:bg-red-50 text-slate-700 hover:text-red-700 font-bold text-xs transition flex items-center gap-2">
                    <i class="fa-solid fa-arrow-right-from-bracket text-xs"></i>
                    <span>Sign Out</span>
                </button>
            </form>
        </div>

    </div>

</div>

<script>
function togglePass() {
    const input = document.getElementById('newPassword');
    const eye = document.getElementById('eyeIcon');
    if (input.type === 'password') {
        input.type = 'text';
        eye.classList.remove('fa-eye');
        eye.classList.add('fa-eye-slash');
    } else {
        input.type = 'password';
        eye.classList.remove('fa-eye-slash');
        eye.classList.add('fa-eye');
    }
}
</script>
@endsection
