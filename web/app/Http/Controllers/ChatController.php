<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Constants\MarketData;
use App\Services\DatabaseService;

class ChatController extends Controller
{
    public function index(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        // Recent candidates to message
        $candidates = array_slice(DatabaseService::getApplicants(), 0, 10);
        $user = session('auth_user');

        return view('pages.chats.index', compact('activeCountry', 'candidates', 'user'));
    }

    public function show(string $id)
    {
        $candidate = DatabaseService::getApplicant($id);
        if (!$candidate) {
            abort(404, 'Candidate not found');
        }

        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);
        $user = session('auth_user');

        // Preload sample simulated messages
        $messages = [
            [
                'id' => 'm1',
                'sender' => 'candidate',
                'text' => 'مرحباً، يسعدني التواصل معكم بشأن فرصة العمل المعروضة.',
                'text_en' => 'Hello, I am glad to get in touch regarding this employment opportunity.',
                'time' => '10:15 AM',
            ],
            [
                'id' => 'm2',
                'sender' => 'user',
                'text' => 'أهلاً بك! اطلعنا على خبراتك الممتازة، هل أنت متاح لبدء العمل فوراً؟',
                'text_en' => 'Welcome! We reviewed your profile. Are you available for immediate start?',
                'time' => '10:18 AM',
            ],
        ];

        return view('pages.chats.show', compact('candidate', 'activeCountry', 'user', 'messages'));
    }

    public function send(Request $request, string $id)
    {
        $text = trim($request->input('message', ''));
        if (!empty($text)) {
            // Save or log message in session for interaction
            $chatHistory = session("chat_{$id}", []);
            $chatHistory[] = [
                'id' => 'm_' . time(),
                'sender' => 'user',
                'text' => $text,
                'time' => date('h:i A'),
            ];
            session(["chat_{$id}" => $chatHistory]);
        }

        return redirect()->route('chats.show', $id);
    }
}
