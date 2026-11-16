import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiEndpoints {
  // Live Namecheap API Backend (HTTPS)
  static const String liveBaseUrl = 'https://directwork.site/api/v1';

  static String get baseUrl => liveBaseUrl;

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String registerCompany = '/auth/register-company';
  static const String registerAdvertiser = '/auth/register-advertiser';
  static const String verifyOtp = '/auth/verify-otp';
  static const String forgotPassword = '/auth/forgot-password';
  static const String changePassword = '/auth/change-password';
  static const String profile = '/auth/profile';
  static const String logout = '/auth/logout';
  static const String deleteAccount = '/auth/delete-account';

  // Jobs (Kuwait)
  static const String jobs = '/jobs';
  static const String jobDetails = '/jobs'; // append /{id}
  static const String applyJob = '/jobs'; // append /{id}/apply
  static const String sectors = '/sectors';
  static const String professions = '/professions';
  static const String governorates = '/governorates';

  // Services Marketplace (Kuwait)
  static const String services = '/services';
  static const String serviceCategories = '/services/categories';
  static const String createService = '/services';

  // Commercial Ads (Kuwait)
  static const String commercialAds = '/commercial-ads';
  static const String createCommercialAd = '/commercial-ads';

  // Chats & Messaging
  static const String chatRooms = '/chats';
  static const String chatMessages = '/chats'; // append /{id}/messages
  static const String sendMessage = '/chats'; // append /{id}/send

  // User Ads & Applications
  static const String myApplications = '/my-applications';
  static const String myAds = '/my-ads';
  static const String applications = '/applications';
  static const String applicationPricing = '/application-pricing';
  static const String applicants = '/applicants';

  // Payments (MyFatoorah Kuwait)
  static const String initiatePayment = '/payments/myfatoorah/initiate';
  static const String verifyPayment = '/payments/myfatoorah/verify';
}
