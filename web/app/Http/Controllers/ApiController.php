<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Constants\MarketData;
use App\Services\DatabaseService;

class ApiController extends Controller
{
    public function getJobs(Request $request)
    {
        $filters = [
            'country' => $request->query('country', 'kw'),
            'sector' => $request->query('sector', 'all'),
            'governorate' => $request->query('governorate', 'all'),
            'search' => $request->query('search', ''),
        ];

        $jobs = DatabaseService::getJobs($filters);
        return response()->json([
            'status' => 'success',
            'count' => count($jobs),
            'data' => $jobs,
        ]);
    }

    public function getSectors(Request $request)
    {
        $sectors = MarketData::getSectors();
        return response()->json([
            'status' => 'success',
            'count' => count($sectors),
            'data' => $sectors,
        ]);
    }

    public function getApplicants(Request $request)
    {
        $filters = [
            'sector' => $request->query('sector', 'all'),
            'governorate' => $request->query('governorate', 'all'),
            'search' => $request->query('search', ''),
        ];

        $applicants = DatabaseService::getApplicants($filters);
        return response()->json([
            'status' => 'success',
            'count' => count($applicants),
            'data' => $applicants,
        ]);
    }

    public function submitApplication(Request $request)
    {
        $data = $request->all();
        $saved = DatabaseService::saveApplication($data);

        return response()->json([
            'status' => 'success',
            'message' => 'Application submitted and activated successfully',
            'data' => $saved,
        ], 201);
    }

    public function getServices()
    {
        $services = DatabaseService::getServices();
        return response()->json([
            'status' => 'success',
            'data' => $services,
        ]);
    }

    public function getCommercialAds()
    {
        $ads = DatabaseService::getCommercialAds();
        return response()->json([
            'status' => 'success',
            'data' => $ads,
        ]);
    }
}
