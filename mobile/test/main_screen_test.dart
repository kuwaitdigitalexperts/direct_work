import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:direct_job_kuwait/core/localization/app_localizations.dart';
import 'package:direct_job_kuwait/core/theme/app_theme.dart';
import 'package:direct_job_kuwait/features/main/main_screen.dart';
import 'package:direct_job_kuwait/features/home/select_sector_companies_screen.dart';
import 'package:direct_job_kuwait/features/home/sector_applicants_screen.dart';
import 'package:direct_job_kuwait/models/job_model.dart';
import 'package:direct_job_kuwait/models/user_model.dart';
import 'package:direct_job_kuwait/providers/auth_provider.dart';
import 'package:direct_job_kuwait/providers/jobs_provider.dart';
import 'package:direct_job_kuwait/services/jobs_service.dart';

class FastFakeJobsService extends JobsService {
  @override
  Future<List<JobModel>> getJobs({
    String? search,
    String? sectorCode,
    String? governorateId,
    String? workType,
    String? candidateCategory,
  }) async {
    return JobsService.defaultJobs.where((job) {
      if (search != null && search.trim().isNotEmpty) {
        final q = search.trim().toLowerCase();
        if (!job.title.toLowerCase().contains(q) &&
            !job.companyName.toLowerCase().contains(q)) {
          return false;
        }
      }
      return true;
    }).toList();
  }
}

void main() {
  testWidgets('MainScreen renders Home Screen exactly as reference design', (WidgetTester tester) async {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
    };
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final fakeService = FastFakeJobsService();
    final container = ProviderContainer(
      overrides: [
        jobsServiceProvider.overrideWithValue(fakeService),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('en', 'US'),
          supportedLocales: const [
            Locale('ar', 'KW'),
            Locale('ar'),
            Locale('en', 'US'),
            Locale('en'),
          ],
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const MainScreen(initialIndex: 3), // Home Tab
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(tester.takeException(), isNull);

    // Verify Home Screen Header
    expect(find.text('Direct Work App'), findsOneWidget);
    expect(find.text('Direct Hiring Platform'), findsOneWidget);
    expect(find.text('Job Seekers'), findsOneWidget);

    // Verify Action Cards
    expect(find.text('Apply for jobs inside Kuwait'), findsOneWidget);
    expect(find.text('Apply Now'), findsOneWidget);
    expect(find.text('Jobs in Kuwait (Outside Applicants)'), findsOneWidget);
    expect(find.text('Apply Overseas'), findsOneWidget);

    // Verify Side-by-Side CV Cards
    expect(find.text('Upload your CV (GCC Citizens)'), findsOneWidget);
    expect(find.text('Upload your CV (Kuwait Citizens)'), findsOneWidget);

    // Verify Custom Navigation Bar items
    expect(find.text('Chats'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Add your ad'), findsOneWidget);
    expect(find.text('Commercial'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('MainScreen Search Tab renders jobs feed and empty state', (WidgetTester tester) async {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
    };
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    final fakeService = FastFakeJobsService();
    final container = ProviderContainer(
      overrides: [
        jobsServiceProvider.overrideWithValue(fakeService),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('en', 'US'),
          supportedLocales: const [
            Locale('ar', 'KW'),
            Locale('ar'),
            Locale('en', 'US'),
            Locale('en'),
          ],
          localizationsDelegates: const [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const MainScreen(initialIndex: 1), // Search / Jobs tab
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(tester.takeException(), isNull);

    // Verify Direct work header on Search tab
    expect(find.text('Direct work'), findsOneWidget);
    expect(find.text('Direct Employment in State of Kuwait 🇰🇼'), findsOneWidget);

    // Verify jobs are rendered
    final jobsState = container.read(jobsProvider);
    expect(jobsState.jobs.isNotEmpty, isTrue);

    // Simulate search query
    container.read(jobsProvider.notifier).setSearchQuery('NonExistentJobXYZ999');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    // Verify Empty State
    expect(find.text('No Job Vacancies Currently'), findsOneWidget);
    expect(find.text('Kuwait Job Market 🇰🇼'), findsOneWidget);
    expect(find.text('Show All Kuwait Jobs'), findsOneWidget);
    expect(find.text('Post a Vacancy for Your Business'), findsOneWidget);
  });

  testWidgets('SelectSectorCompaniesScreen renders sector graphic cards', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('en', 'US'),
          supportedLocales: [Locale('en', 'US')],
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: SelectSectorCompaniesScreen(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(tester.takeException(), isNull);

    // Verify Titles
    expect(find.text('Select Sector (Companies)'), findsOneWidget);
    expect(find.text('Choose a sector to view applicants inside Kuwait'), findsOneWidget);
    expect(find.text('Available Sectors'), findsOneWidget);
    expect(find.text('All'), findsOneWidget);
  });

  testWidgets('SectorApplicantsScreen renders inside Kuwait applicants and filters', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('en', 'US'),
          supportedLocales: [Locale('en', 'US')],
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: SectorApplicantsScreen(
            sector: 'construction',
            sectorTitle: 'Construction Sector',
            locationType: 'inside',
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.takeException(), isNull);

    // Verify Header & Filters
    expect(find.text('Applicants inside Kuwait'), findsOneWidget);
    expect(find.text('Construction Sector'), findsOneWidget);
    expect(find.text('Concrete & Structure'), findsOneWidget);
    expect(find.text('Rebar & Steel'), findsOneWidget);
    expect(find.text('All professions'), findsOneWidget);
    expect(find.text('All Governorates'), findsOneWidget);
  });

  testWidgets('SectorApplicantsScreen renders outside Kuwait medical applicants', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('en', 'US'),
          supportedLocales: [Locale('en', 'US')],
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: SectorApplicantsScreen(
            sector: 'medical',
            sectorTitle: 'Medical and Healthcare Sector',
            locationType: 'outside',
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(tester.takeException(), isNull);

    // Verify Header & Outside Filters
    expect(find.text('Applicants from outside Kuwait'), findsOneWidget);
    expect(find.text('Medical and Healthcare Sector'), findsOneWidget);
    expect(find.text('Doctors'), findsOneWidget);
    expect(find.text('Nursing'), findsOneWidget);
    expect(find.text('Labs & Imaging'), findsOneWidget);
    expect(find.text('All professions'), findsOneWidget);
    // Since outside, there should NOT be All Governorates
    expect(find.text('All Governorates'), findsNothing);
  });
}
