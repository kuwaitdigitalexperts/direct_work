import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:direct_job_kuwait/core/localization/app_localizations.dart';
import 'package:direct_job_kuwait/features/auth/register_screen.dart';

void main() {
  testWidgets('RegisterScreen renders all fields matching reference screenshots', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    tester.view.physicalSize = const Size(1080, 3600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: [
            AppLocalizationsDelegate(),
          ],
          home: RegisterScreen(),
        ),
      ),
    );

    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 500));

    // Verify Title & Subtitle
    expect(find.text('Create Your Account'), findsOneWidget);
    expect(find.text('Enter all required information'), findsOneWidget);

    // Verify Form Fields
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Enter full name'), findsOneWidget);

    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('+965'), findsOneWidget);
    expect(find.text('Phone number'), findsOneWidget);

    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('name@example.com'), findsOneWidget);

    expect(find.text('Nationality'), findsOneWidget);
    expect(find.text('Select Nationality'), findsOneWidget);

    expect(find.text('Country of Residence'), findsOneWidget);
    expect(find.text('Select Country'), findsOneWidget);

    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);

    // Verify Terms and Button
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.text('Create Account'), findsOneWidget);
  });
}
