import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:direct_job_kuwait/core/localization/app_localizations.dart';
import 'package:direct_job_kuwait/models/applicant_model.dart';
import 'package:direct_job_kuwait/features/home/applicant_detail_screen.dart';
import 'package:direct_job_kuwait/features/home/cv_preview_modal.dart';
import 'package:direct_job_kuwait/features/home/fullscreen_image_preview.dart';

void main() {
  const testCandidate = ApplicantModel(
    id: 'app_kw_c1',
    name: 'Mohamed Abass Kamara',
    profession: 'Construction Worker',
    sector: 'construction',
    subSector: 'Concrete & Structure',
    nationality: 'Sierra Leone',
    governorate: 'Hawalli',
    experience: '8 yrs exp.',
    experienceYears: 8,
    age: 29,
    email: 'mabasskamara@gmail.com',
    locationType: 'outside',
    photoUrl: 'assets/images/candidate_kamara_hero.jpg',
    heroImage: 'assets/images/candidate_kamara_hero.jpg',
    views: 13,
    phone: '96560356945',
    whatsapp: '96560356945',
    bio: 'Hard working and quick to adapt',
    attachmentImages: [
      'assets/images/candidate_kamara_hero.jpg',
    ],
    resumeFileName: 'Mohamed_Abass_Kamara_CV.pdf',
    resumePreviewImage: 'assets/images/candidate_cv_preview.jpg',
  );

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

  testWidgets('ApplicantDetailScreen renders all sections cleanly without overflow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      createTestWidget(
        child: const ApplicantDetailScreen(
          applicantId: 'app_kw_c1',
          initialApplicant: testCandidate,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify candidate header
    expect(find.text('Mohamed Abass Kamara'), findsWidgets);
    expect(find.text('Construction Worker'), findsWidgets);

    // Verify Personal info fields
    expect(find.text('96560356945'), findsOneWidget);
    expect(find.text('mabasskamara@gmail.com'), findsOneWidget);
    expect(find.text('29'), findsOneWidget);
    expect(find.text('Sierra Leone'), findsOneWidget);
    expect(find.text('8'), findsOneWidget);

    // Verify Bio
    expect(find.text('Hard working and quick to adapt'), findsOneWidget);

    // Verify Certificates / Attachments section
    expect(find.text('Certificates / Attachments'), findsOneWidget);
    expect(find.text('476 KB'), findsOneWidget);
    expect(find.byIcon(Icons.workspace_premium), findsOneWidget);

    // Verify Resume CV section & Preview button
    expect(find.text('Mohamed_Abass_Kamara_CV.pdf'), findsOneWidget);
    expect(find.text('Preview'), findsWidgets);

    // Verify action buttons exist
    expect(find.byIcon(Icons.phone), findsOneWidget);
    expect(find.byIcon(Icons.chat_bubble), findsOneWidget);
    expect(find.byIcon(Icons.forum_outlined), findsOneWidget);
  });

  testWidgets('FullscreenImagePreview renders image and interactive controls', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      createTestWidget(
        child: const FullscreenImagePreview(
          imagePath: 'assets/images/candidate_kamara_hero.jpg',
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Preview'), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.byType(InteractiveViewer), findsOneWidget);
  });

  testWidgets('CvPreviewModal renders interactive viewer and controls', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      createTestWidget(
        child: const Scaffold(
          body: CvPreviewModal(applicant: testCandidate),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Preview'), findsOneWidget);
    expect(find.text('Page 1 / 2'), findsOneWidget);
    expect(find.byType(InteractiveViewer), findsOneWidget);
    expect(find.byIcon(Icons.zoom_in), findsOneWidget);
    expect(find.byIcon(Icons.zoom_out), findsOneWidget);
  });
}
