import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:direct_job_kuwait/core/localization/app_localizations.dart';
import 'package:direct_job_kuwait/features/jobs/company_search_screen.dart';

void main() {
  Widget createTestWidget({required Widget child, Locale locale = const Locale('en')}) {
    return ProviderScope(
      child: MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        home: child,
      ),
    );
  }

  testWidgets('CompanySearchScreen renders header, employers pill, sectors and professions', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      createTestWidget(
        child: const CompanySearchScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Title & Employers Pill
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Employers'), findsOneWidget);

    // Verify Search Input exists
    expect(find.byType(TextField), findsOneWidget);

    // Verify Sectors section exists
    expect(find.text('Sectors'), findsOneWidget);
    expect(find.text('Oil,Gas & Petrochemicals'), findsOneWidget);

    // Scroll down to Professions
    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();

    // Verify Professions section exists
    expect(find.text('Professions'), findsOneWidget);
    expect(find.text('Pharmacy Assistant'), findsOneWidget);
    expect(find.text('View applicants'), findsWidgets);
  });

  testWidgets('CompanySearchScreen filters by query "as" matching screenshot', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      createTestWidget(
        child: const CompanySearchScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Enter "as" into search bar
    await tester.enterText(find.byType(TextField), 'as');
    await tester.pumpAndSettle();

    // Verify Sector matches: Oil,Gas & Petrochemicals (contains "Gas")
    expect(find.text('Oil,Gas & Petrochemicals'), findsOneWidget);

    // Scroll down to see filtered professions
    final scrollableFinder = find.descendant(
      of: find.byType(ListView),
      matching: find.byType(Scrollable),
    );
    await tester.scrollUntilVisible(
      find.text('Pharmacy Assistant'),
      100,
      scrollable: scrollableFinder,
    );
    expect(find.text('Pharmacy Assistant'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Property Risk Assessor'),
      100,
      scrollable: scrollableFinder,
    );
    expect(find.text('Property Risk Assessor'), findsOneWidget);
  });
}
