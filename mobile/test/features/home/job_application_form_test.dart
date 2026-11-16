import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:direct_job_kuwait/core/localization/app_localizations.dart';
import 'package:direct_job_kuwait/features/home/job_application_form_screen.dart';
import 'package:direct_job_kuwait/models/job_application_model.dart';
import 'package:direct_job_kuwait/models/user_model.dart';
import 'package:direct_job_kuwait/providers/auth_provider.dart';
import 'package:direct_job_kuwait/services/auth_service.dart';

void main() {
  Widget buildTestableWidget(Widget child, {UserModel? user, Locale locale = const Locale('en')}) {
    final authNotifier = AuthNotifier(AuthService());
    if (user != null) {
      authNotifier.setUser(user);
    }
    return ProviderScope(
      overrides: [
        authProvider.overrideWith((ref) => authNotifier),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          splashFactory: InkRipple.splashFactory,
        ),
        locale: locale,
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
        ],
        home: child,
      ),
    );
  }

  group('JobApplicationFormScreen Comprehensive Validation & Scenarios', () {
    testWidgets('Renders all cards, 2-month validity, and 2 KWD price (No Free Trial)', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestableWidget(
          const JobApplicationFormScreen(
            sectorCode: 'medical',
            sectorTitle: 'Medical and Healthcare Sector',
            profession: 'General Practitioner',
            locationType: 'inside',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify Headers
      expect(find.text('General Practitioner'), findsWidgets);
      expect(find.text('Medical and Healthcare Sector'), findsOneWidget);
      expect(find.text('Inside Kuwait'), findsOneWidget);

      // Verify Personal Info card
      expect(find.text('Personal Information'), findsOneWidget);
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Governorate *'), findsOneWidget);
      expect(find.text('+965'), findsOneWidget);

      // Verify Experience & Bio card
      expect(find.text('Experience & bio'), findsOneWidget);
      expect(find.text('Years of experience *'), findsOneWidget);
      expect(find.text('Short bio (text) *'), findsOneWidget);

      // Verify 2-Month Expiration & Pricing Card
      expect(find.text('Job Application (2 Months Validity)'), findsOneWidget);
      expect(find.text('Active for 60 days, auto-removed after 2 months'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('KWD'), findsOneWidget);

      // Verify Payment Proceed Button
      expect(find.text('Proceed to Payment (2 KWD)'), findsOneWidget);
    });

    testWidgets('Scenario: Submitting empty form triggers validation errors', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestableWidget(
          const JobApplicationFormScreen(
            sectorCode: 'construction',
            sectorTitle: 'Construction Sector',
            profession: 'Civil Engineer',
            locationType: 'inside',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Proceed to Payment button
      final proceedBtn = find.text('Proceed to Payment (2 KWD)');
      await tester.ensureVisible(proceedBtn);
      await tester.tap(proceedBtn);
      await tester.pumpAndSettle();

      // Should show validation errors
      expect(find.text('Full name is required'), findsOneWidget);
      expect(find.text('Phone number is required'), findsOneWidget);
      expect(find.text('Email address is required'), findsOneWidget);
      expect(find.text('Age is required'), findsOneWidget);
      expect(find.text('Years of experience is required'), findsOneWidget);
      expect(find.text('Short bio is required'), findsOneWidget);
    });

    testWidgets('Scenario: Invalid name (digits or < 3 chars) shows error', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestableWidget(
          const JobApplicationFormScreen(
            sectorCode: 'construction',
            sectorTitle: 'Construction Sector',
            profession: 'Civil Engineer',
            locationType: 'inside',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter short or invalid name
      final nameField = find.widgetWithText(TextFormField, 'e.g. Asim Khalid');
      await tester.enterText(nameField, '12');

      final proceedBtn = find.text('Proceed to Payment (2 KWD)');
      await tester.ensureVisible(proceedBtn);
      await tester.tap(proceedBtn);
      await tester.pumpAndSettle();

      expect(find.text('Name must be at least 3 characters'), findsOneWidget);

      await tester.enterText(nameField, '12345');
      await tester.ensureVisible(proceedBtn);
      await tester.tap(proceedBtn);
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid name (letters only)'), findsOneWidget);
    });

    testWidgets('Scenario: Invalid Kuwait phone number shows error', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestableWidget(
          const JobApplicationFormScreen(
            sectorCode: 'construction',
            sectorTitle: 'Construction Sector',
            profession: 'Civil Engineer',
            locationType: 'inside',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter invalid phone (starts with 1 or not 8 digits)
      final phoneField = find.widgetWithText(TextFormField, '8 digits (e.g. 98765432)');
      await tester.enterText(phoneField, '12345678');

      final proceedBtn = find.text('Proceed to Payment (2 KWD)');
      await tester.ensureVisible(proceedBtn);
      await tester.tap(proceedBtn);
      await tester.pumpAndSettle();

      expect(find.text('Enter valid 8-digit Kuwait number starting with 5, 6, or 9'), findsOneWidget);
    });

    testWidgets('Scenario: Invalid email address shows error', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestableWidget(
          const JobApplicationFormScreen(
            sectorCode: 'construction',
            sectorTitle: 'Construction Sector',
            profession: 'Civil Engineer',
            locationType: 'inside',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final emailField = find.widgetWithText(TextFormField, 'e.g. user@gmail.com');
      await tester.enterText(emailField, 'notanemail');

      final proceedBtn = find.text('Proceed to Payment (2 KWD)');
      await tester.ensureVisible(proceedBtn);
      await tester.tap(proceedBtn);
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address (e.g. name@domain.com)'), findsOneWidget);
    });

    testWidgets('Scenario: Age and Experience bounds validation', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestableWidget(
          const JobApplicationFormScreen(
            sectorCode: 'construction',
            sectorTitle: 'Construction Sector',
            profession: 'Civil Engineer',
            locationType: 'inside',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final ageField = find.widgetWithText(TextFormField, '18 - 65');
      final expField = find.widgetWithText(TextFormField, 'e.g. 5');

      // Underage test (< 18)
      await tester.enterText(ageField, '16');
      // Excessive experience (> 45)
      await tester.enterText(expField, '50');

      final proceedBtn = find.text('Proceed to Payment (2 KWD)');
      await tester.ensureVisible(proceedBtn);
      await tester.tap(proceedBtn);
      await tester.pumpAndSettle();

      expect(find.text('Applicant must be at least 18 years old'), findsOneWidget);
      expect(find.text('Experience must be between 0 and 45 years'), findsOneWidget);
    });

    testWidgets('Scenario: Bio minimum 20 characters validation', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestableWidget(
          const JobApplicationFormScreen(
            sectorCode: 'construction',
            sectorTitle: 'Construction Sector',
            profession: 'Civil Engineer',
            locationType: 'inside',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final bioField = find.byType(TextFormField).at(5); // Bio field
      await tester.enterText(bioField, 'Too short bio');

      final proceedBtn = find.text('Proceed to Payment (2 KWD)');
      await tester.ensureVisible(proceedBtn);
      await tester.tap(proceedBtn);
      await tester.pumpAndSettle();

      expect(find.text('Bio must be at least 20 characters describing your skills'), findsOneWidget);
    });

    testWidgets('Scenario: Valid form opens Kuwait Payment Gateway checkout modal', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      const user = UserModel(
        id: 'u1',
        fullName: 'Fahad Al-Mutawa',
        email: 'fahad@example.com',
        phone: '+965 99887766',
        role: UserRole.applicant,
        governorate: 'Capital',
        nationality: 'Kuwaiti',
      );

      await tester.pumpWidget(
        buildTestableWidget(
          const JobApplicationFormScreen(
            sectorCode: 'construction',
            sectorTitle: 'Construction Sector',
            profession: 'Civil Engineer',
            locationType: 'inside',
          ),
          user: user,
        ),
      );
      await tester.pumpAndSettle();

      // Enter Age, Experience, and Bio
      final ageField = find.widgetWithText(TextFormField, '18 - 65');
      final expField = find.widgetWithText(TextFormField, 'e.g. 5');
      final bioField = find.byType(TextFormField).at(5);

      await tester.enterText(ageField, '29');
      await tester.enterText(expField, '6');
      await tester.enterText(bioField, 'Certified Civil Engineer with 6 years experience in Kuwait project sites.');
      await tester.pumpAndSettle();

      // Tap Proceed to Payment
      final proceedBtn = find.text('Proceed to Payment (2 KWD)');
      await tester.ensureVisible(proceedBtn);
      await tester.tap(proceedBtn);
      await tester.pumpAndSettle();

      // Payment Gateway Modal should now be displayed
      expect(find.text('Kuwait Payment Gateway'), findsOneWidget);
      expect(find.text('256-Bit SSL Secure Checkout'), findsOneWidget);
      expect(find.text('2 Months (60 Days)'), findsOneWidget);
      expect(find.text('After 60 Days'), findsOneWidget);
      expect(find.text('2.000 KWD'), findsOneWidget);

      // Verify payment methods
      expect(find.text('K-Net (Kuwait Debit Card)'), findsOneWidget);
      expect(find.text('Credit Card (Visa / Mastercard)'), findsOneWidget);
      expect(find.text('Apple Pay'), findsOneWidget);
      expect(find.text('Pay 2 KWD via K-Net'), findsOneWidget);
    });

    test('Two-month expiration date calculation and isExpired verification', () {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(days: 60)); // strictly 2 months / 60 days

      final activeApp = JobApplicationModel(
        id: 'app_1',
        jobId: 'job_1',
        jobTitle: 'Civil Engineer',
        companyName: 'Direct Work Kuwait',
        governorateName: 'Capital',
        whatsappNumber: '99887766',
        phoneNumber: '+965 99887766',
        applicantName: 'Fahad Al-Mutawa',
        applicantPhone: '+965 99887766',
        status: 'active',
        appliedAt: now,
        expiresAt: expiresAt,
        priceKwd: 2.0,
      );

      // Currently active
      expect(activeApp.isExpired, isFalse);
      expect(activeApp.priceKwd, equals(2.0));

      // Expired app (applied 65 days ago)
      final expiredDate = now.subtract(const Duration(days: 5));
      final expiredApp = JobApplicationModel(
        id: 'app_2',
        jobId: 'job_2',
        jobTitle: 'Carpenter',
        companyName: 'Direct Work Kuwait',
        governorateName: 'Hawalli',
        whatsappNumber: '99887766',
        phoneNumber: '+965 99887766',
        applicantName: 'Test Worker',
        applicantPhone: '+965 99887766',
        status: 'active',
        appliedAt: now.subtract(const Duration(days: 65)),
        expiresAt: expiredDate,
        priceKwd: 2.0,
      );

      // Should automatically be expired
      expect(expiredApp.isExpired, isTrue);
    });
  });
}
