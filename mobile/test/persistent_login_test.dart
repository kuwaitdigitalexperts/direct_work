import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:direct_job_kuwait/core/utils/app_preferences.dart';
import 'package:direct_job_kuwait/models/user_model.dart';
import 'package:direct_job_kuwait/services/auth_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Persistent Login & Session Preservation Tests', () {
    late AuthService authService;

    setUp(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        const MethodChannel('plugins.it_nomads.com/flutter_secure_storage'),
        (MethodCall methodCall) async => null,
      );
      SharedPreferences.setMockInitialValues({});
      authService = AuthService();
    });

    test('User login caches session and keeps applicant logged in', () async {
      const user = UserModel(
        id: 'kw_user_1',
        fullName: 'أحمد الكندري',
        email: 'ahmed.kandari@gmail.com',
        phone: '+965 98765432',
        role: UserRole.applicant,
        governorate: 'محافظة حولي',
        nationality: 'الكويت',
      );
      await authService.cacheUser(user);

      expect(user.role, UserRole.applicant);
      expect(user.fullName, 'أحمد الكندري');

      // Verify that getCachedUser immediately returns the persisted user
      final cachedUser = await authService.getCachedUser();
      expect(cachedUser, isNotNull);
      expect(cachedUser!.email, 'ahmed.kandari@gmail.com');
      expect(cachedUser.role, UserRole.applicant);

      // Verify onboarding and login flags in preferences
      final isLoggedIn = await AppPreferences.getBool('is_logged_in');
      expect(isLoggedIn, true);
      final onboardingDone = await AppPreferences.getBool('onboarding_completed');
      expect(onboardingDone, true);
    });

    test('Company login caches session and keeps company logged in with company role', () async {
      const companyUser = UserModel(
        id: 'kw_company_1',
        fullName: 'kasim',
        companyName: 'na',
        commercialLicense: '234234234',
        email: 'k@gmail.com',
        phone: '+965 43245677890',
        role: UserRole.company,
      );
      await authService.cacheUser(companyUser);

      expect(companyUser.role, UserRole.company);
      expect(companyUser.companyName, 'na');
      expect(companyUser.commercialLicense, '234234234');

      // Verify that getCachedUser immediately returns the company session
      final cachedCompany = await authService.getCachedUser();
      expect(cachedCompany, isNotNull);
      expect(cachedCompany!.role, UserRole.company);
      expect(cachedCompany.companyName, 'na');
    });

    test('Company registration permanently caches company account', () async {
      const newCompany = UserModel(
        id: 'kw_comp_test',
        fullName: 'Fahad Al-Salem',
        companyName: 'Kuwait Global Towers',
        commercialLicense: '987654321',
        email: 'info@kuwaitglobal.kw',
        phone: '+965 99887766',
        role: UserRole.company,
      );
      await authService.cacheUser(newCompany);

      expect(newCompany.role, UserRole.company);
      expect(newCompany.companyName, 'Kuwait Global Towers');

      // Check cached
      final cached = await authService.getCachedUser();
      expect(cached, isNotNull);
      expect(cached!.role, UserRole.company);
      expect(cached.companyName, 'Kuwait Global Towers');
      expect(cached.commercialLicense, '987654321');
    });

    test('Logout properly terminates session and clears cached user', () async {
      await authService.logout();

      final cachedAfterLogout = await authService.getCachedUser();
      expect(cachedAfterLogout, isNull);

      final isLoggedIn = await AppPreferences.getBool('is_logged_in');
      expect(isLoggedIn, false);
    });
  });
}
