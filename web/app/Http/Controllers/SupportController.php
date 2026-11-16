<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Constants\MarketData;

class SupportController extends Controller
{
    public function index(Request $request)
    {
        $countryCode = session('selected_country', 'kw');
        $activeCountry = MarketData::getCountry($countryCode);

        return view('pages.support.index', compact('activeCountry'));
    }

    public function sendTicket(Request $request)
    {
        $validated = $request->validate([
            'user_type' => 'required|string',
            'full_name' => 'required|string|max:150',
            'email' => 'required|email|max:150',
            'phone' => 'required|string|max:40',
            'category' => 'required|string',
            'subject' => 'required|string|max:200',
            'message' => 'required|string|max:3000',
        ]);

        return back()->with('success', 'Your support ticket has been received. Our team will contact you shortly.');
    }
}
