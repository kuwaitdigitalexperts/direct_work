import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:direct_job_kuwait/core/localization/app_localizations.dart';
import 'package:direct_job_kuwait/features/home/select_sector_screen.dart';
import 'package:direct_job_kuwait/features/home/sector_professions_screen.dart';
import 'package:direct_job_kuwait/features/home/job_application_form_screen.dart';
import 'package:direct_job_kuwait/models/user_model.dart';
import 'package:direct_job_kuwait/providers/auth_provider.dart';
import 'package:direct_job_kuwait/services/auth_service.dart';

void main() {
  Widget buildTestableWidget(Widget child, {Locale locale = const Locale('en')}) {
    return ProviderScope(
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
        ],
        home: child,
      ),
    );
  }

  group('Job Seeker Application Flow Tests', () {
    testWidgets('SelectSectorScreen renders sectors and categories for inside Kuwait', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestableWidget(const SelectSectorScreen(locationType: 'inside')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Select a sector'), findsOneWidget);
      expect(find.text('Inside Kuwait'), findsOneWidget);
      expect(find.text('Available sectors'), findsOneWidget);
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Construction Sector'), findsWidgets);
      expect(find.text('Transport, Delivery and Drivers Sector'), findsWidgets);
      expect(find.text('Medical and Healthcare Sector'), findsWidgets);
    });

    testWidgets('SelectSectorScreen renders subtitle for outside Kuwait', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestableWidget(const SelectSectorScreen(locationType: 'outside')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Select a sector'), findsOneWidget);
      expect(find.text('Outside Kuwait (to work in Kuwait)'), findsOneWidget);
    });

    testWidgets('SectorProfessionsScreen displays professions and subsectors', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        buildTestableWidget(
          const SectorProfessionsScreen(
            sectorCode: 'construction',
            sectorTitle: 'Construction Sector',
            locationType: 'inside',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Construction Sector'), findsWidgets);
      expect(find.text('Choose the right profession to view jobs / apply'), findsOneWidget);
      expect(find.text('Search for a profession...'), findsOneWidget);
      expect(find.text('Concrete & Structure'), findsWidgets);
      expect(find.text('Available Professions'), findsOneWidget);
      expect(find.text('Formwork Carpenter (Columns & Slabs)'), findsOneWidget);
      expect(find.text('Concrete Pourer'), findsOneWidget);
    });

    testWidgets('JobApplicationFormScreen renders all cards for Inside Kuwait with Free tier', (tester) async {
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
            profession: 'Formwork Carpenter (Columns & Slabs)',
            locationType: 'inside',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Title & subtitles
      expect(find.text('Formwork Carpenter (Columns & Slabs)'), findsWidgets);
      expect(find.text('Inside Kuwait'), findsOneWidget);

      // Card 1: Personal info
      expect(find.text('Personal Information'), findsOneWidget);
      expect(find.text('Governorate *'), findsOneWidget);
      expect(find.text('+965'), findsOneWidget);

      // Card 2: Experience & Bio with countdown
      expect(find.text('Experience & bio'), findsOneWidget);
      expect(find.text('200 characters remaining'), findsOneWidget);

      // Card 3: Attachments
      expect(find.text('Attachments'), findsOneWidget);
      expect(find.text('Choose photo'), findsOneWidget);
      expect(find.text('Attach CV'), findsOneWidget);
      expect(find.text('Add certificates'), findsOneWidget);

      // Card 4: 2 KWD for 2 months (No free trial)
      expect(find.text('Job Application (2 Months Validity)'), findsOneWidget);
      expect(find.text('Active for 60 days, auto-removed after 2 months'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('KWD'), findsOneWidget);

      // Button
      expect(find.text('Proceed to Payment (2 KWD)'), findsOneWidget);
    });

    testWidgets('JobApplicationFormScreen renders Outside Kuwait with 2 KWD tier and NO Governorate', (tester) async {
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
            profession: 'Formwork Carpenter (Columns & Slabs)',
            locationType: 'outside',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Title & subtitles
      expect(find.text('Formwork Carpenter (Columns & Slabs)'), findsOneWidget);
      expect(find.text('Fill your details and attach documents to complete the request'), findsOneWidget);

      // Governorate should NOT be present for outside Kuwait
      expect(find.text('Governorate *'), findsNothing);

      // Card 4: Paid tier (2 KWD for 2 months)
      expect(find.text('Job Application (2 Months Validity)'), findsOneWidget);
      expect(find.text('Active for 60 days, auto-removed after 2 months'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('KWD'), findsOneWidget);

      // Button
      expect(find.text('Proceed to Payment (2 KWD)'), findsOneWidget);
    });

    testWidgets('JobApplicationFormScreen renders without crash when user has Arabic governorate and nationality', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      const userWithArabicGov = UserModel(
        id: 'u1',
        fullName: 'أحمد الكندري',
        email: 'ahmed@example.com',
        phone: '+965 98765432',
        role: UserRole.applicant,
        governorate: 'محافظة العاصمة',
        nationality: 'Pakistan',
      );

      final authNotifier = AuthNotifier(AuthService())..setUser(userWithArabicGov);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) => authNotifier),
          ],
          child: const MaterialApp(
            locale: Locale('ar'),
            localizationsDelegates: [
              AppLocalizationsDelegate(),
            ],
            home: JobApplicationFormScreen(
              sectorCode: 'construction',
              sectorTitle: 'Construction Sector',
              profession: 'Formwork Carpenter (Columns & Slabs)',
              locationType: 'inside',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(JobApplicationFormScreen), findsOneWidget);
      expect(find.text('أحمد الكندري'), findsOneWidget);
    });
  });
}
