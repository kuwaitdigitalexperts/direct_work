import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/splash/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/market_selection_screen.dart';
import '../features/auth/account_selection_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/auth/company_register_screen.dart';
import '../features/auth/verify_otp_screen.dart';
import '../features/main/main_screen.dart';
import '../features/jobs/job_detail_screen.dart';
import '../features/chat/chat_screen.dart';
import '../features/services/create_service_screen.dart';
import '../features/commercial/create_commercial_screen.dart';
import '../features/payment/pricing_plans_screen.dart';
import '../features/payment/myfatoorah_payment_screen.dart';
import '../features/profile/terms_screen.dart';
import '../features/profile/privacy_screen.dart';
import '../features/profile/my_applications_screen.dart';
import '../features/profile/my_ads_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/profile/edit_profile_screen.dart';
import '../features/profile/settings_screen.dart';
import '../features/profile/change_password_screen.dart';
import '../features/profile/delete_account_screen.dart';
import '../features/profile/my_commercial_ads_screen.dart';
import '../features/profile/notifications_screen.dart';
import '../features/jobs/post_job_screen.dart';
import '../features/home/select_sector_companies_screen.dart';
import '../features/home/sector_applicants_screen.dart';
import '../features/home/applicant_detail_screen.dart';
import '../features/home/select_sector_screen.dart';
import '../features/home/sector_professions_screen.dart';
import '../features/home/job_application_form_screen.dart';
import '../features/jobs/company_search_screen.dart';
import '../models/applicant_model.dart';
import '../core/constants/app_colors.dart';
import '../core/utils/app_preferences.dart';
import '../services/auth_service.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/market-selection',
      builder: (context, state) => const MarketSelectionScreen(),
    ),
    GoRoute(
      path: '/account-selection',
      builder: (context, state) => const AccountSelectionScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        final role = state.uri.queryParameters['role'] ?? 'applicant';
        return RegisterScreen(role: role);
      },
    ),
    GoRoute(
      path: '/company-register',
      builder: (context, state) => const CompanyRegisterScreen(),
    ),
    GoRoute(
      path: '/verify-otp',
      builder: (context, state) => const VerifyOtpScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/change-password',
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: '/delete-account',
      builder: (context, state) => const DeleteAccountScreen(),
    ),
    GoRoute(
      path: '/my-commercial-ads',
      builder: (context, state) => const MyCommercialAdsScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/jobs/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return JobDetailScreen(jobId: id);
      },
    ),
    GoRoute(
      path: '/chat/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        final name = state.uri.queryParameters['name'] ?? 'مستخدم';
        final role = state.uri.queryParameters['role'] ?? 'طرف تواصل';
        return ChatScreen(roomId: id, participantName: name, participantRole: role);
      },
    ),
    GoRoute(
      path: '/create-service',
      builder: (context, state) => const CreateServiceScreen(),
    ),
    GoRoute(
      path: '/create-commercial',
      builder: (context, state) => const CreateCommercialScreen(),
    ),
    GoRoute(
      path: '/pricing-plans',
      builder: (context, state) => const PricingPlansScreen(),
    ),
    GoRoute(
      path: '/myfatoorah-payment',
      builder: (context, state) {
        final amount = double.tryParse(state.uri.queryParameters['amount'] ?? '1.5') ?? 1.5;
        final title = state.uri.queryParameters['title'] ?? 'باقة إعلانية';
        return MyfatoorahPaymentScreen(amount: amount, title: title);
      },
    ),
    GoRoute(
      path: '/terms',
      builder: (context, state) => const TermsScreen(),
    ),
    GoRoute(
      path: '/privacy',
      builder: (context, state) => const PrivacyScreen(),
    ),
    GoRoute(
      path: '/my-applications',
      builder: (context, state) => const MyApplicationsScreen(),
    ),
    GoRoute(
      path: '/my-ads',
      builder: (context, state) => const MyAdsScreen(),
    ),
    GoRoute(
      path: '/post-job',
      builder: (context, state) => const PostJobScreen(),
    ),
    GoRoute(
      path: '/company-sectors',
      builder: (context, state) {
        final locType = state.uri.queryParameters['locationType'] ?? 'inside';
        return SelectSectorCompaniesScreen(locationType: locType);
      },
    ),
    GoRoute(
      path: '/sector-applicants',
      builder: (context, state) {
        final sector = state.uri.queryParameters['sector'] ?? 'construction';
        final sectorTitle = state.uri.queryParameters['sectorTitle'] ?? 'Construction Sector';
        final locationType = state.uri.queryParameters['locationType'] ?? 'inside';
        return SectorApplicantsScreen(
          sector: sector,
          sectorTitle: sectorTitle,
          locationType: locationType,
        );
      },
    ),
    GoRoute(
      path: '/applicant-detail/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        final applicant = state.extra as ApplicantModel?;
        return ApplicantDetailScreen(
          applicantId: id,
          initialApplicant: applicant,
        );
      },
    ),
    GoRoute(
      path: '/company-search',
      builder: (context, state) => const CompanySearchScreen(),
    ),
    GoRoute(
      path: '/select-sector',
      builder: (context, state) {
        final locType = state.uri.queryParameters['locationType'] ?? 'inside';
        return SelectSectorScreen(locationType: locType);
      },
    ),
    GoRoute(
      path: '/sector-professions',
      builder: (context, state) {
        final sectorCode = state.uri.queryParameters['sectorCode'] ?? 'construction';
        final sectorTitle = state.uri.queryParameters['sectorTitle'] ?? 'Construction Sector';
        final locType = state.uri.queryParameters['locationType'] ?? 'inside';
        return SectorProfessionsScreen(
          sectorCode: sectorCode,
          sectorTitle: sectorTitle,
          locationType: locType,
        );
      },
    ),
    GoRoute(
      path: '/job-application-form',
      builder: (context, state) {
        final sectorCode = state.uri.queryParameters['sectorCode'] ?? 'construction';
        final sectorTitle = state.uri.queryParameters['sectorTitle'] ?? 'Construction Sector';
        final profession = state.uri.queryParameters['profession'] ?? 'Formwork Carpenter (Columns & Slabs)';
        final locType = state.uri.queryParameters['locationType'] ?? 'inside';
        return JobApplicationFormScreen(
          sectorCode: sectorCode,
          sectorTitle: sectorTitle,
          profession: profession,
          locationType: locType,
        );
      },
    ),
  ],
);
