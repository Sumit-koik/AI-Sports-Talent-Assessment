import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sport_assess/app/app.dart';
import 'package:sport_assess/screens/main_navigation_screen.dart';
import 'package:sport_assess/routes/app_routes.dart';
import 'package:sport_assess/screens/auth/forgot_password_screen.dart';
import 'package:sport_assess/screens/profile/athlete_profile_screen.dart';
import 'package:sport_assess/screens/profile/profile_form_screen.dart';
import 'package:sport_assess/screens/sport/sport_preparation_screen.dart';
import 'package:sport_assess/screens/sport/sport_selection_screen.dart';
import 'package:sport_assess/screens/sport/simulated_camera_screen.dart';
import 'package:sport_assess/screens/sport/video_processing_screen.dart';
import 'package:sport_assess/screens/sport/video_submission_screen.dart';
import 'package:sport_assess/screens/sport/assessment_result_screen.dart';
import 'package:sport_assess/screens/sport/detailed_analysis_screen.dart';
import 'package:sport_assess/screens/sport/training_recommendations_screen.dart';
import 'package:sport_assess/screens/sport/assessment_history_screen.dart';

void main() {
  testWidgets('shows splash, opens onboarding, and reaches login', (WidgetTester tester) async {
    await tester.pumpWidget(const SportAssessApp());

    expect(find.text('SportAssess'), findsOneWidget);
    expect(find.text('Discover Your Athletic Potential'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 2300));
    await tester.pumpAndSettle();
    expect(find.text('Discover Your Potential'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Continue as guest'), findsOneWidget);

    await tester.tap(find.text('Continue as guest'));
    await tester.pumpAndSettle();
    expect(find.text('Good Morning, Athlete!'), findsOneWidget);
    expect(find.text('Ready to test your potential?'), findsOneWidget);
    expect(find.text('Choose Your Sport'), findsOneWidget);
    expect(find.text('Overall Score'), findsOneWidget);
    expect(find.text('Recent assessment'), findsOneWidget);
    expect(find.text('Quick actions'), findsOneWidget);
  });

  testWidgets('shows mock reset success feedback', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ForgotPasswordScreen()));

    await tester.enterText(find.byType(TextFormField), 'athlete@example.com');
    await tester.tap(find.text('Send reset link'));
    await tester.pump(const Duration(milliseconds: 750));

    expect(find.text('Check your inbox'), findsOneWidget);
    expect(find.textContaining('no real email was sent.'), findsOneWidget);
  });

  testWidgets('renders the mock athlete profile card', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: const AthleteProfileScreen(), onGenerateRoute: AppRoutes.onGenerateRoute));

    expect(find.text('Alex Morgan'), findsNWidgets(2));
    expect(find.text('Football  •  Intermediate'), findsOneWidget);
    expect(find.text('178 cm'), findsOneWidget);
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('My Assessments'), findsOneWidget);
    expect(find.text('Performance Statistics'), findsOneWidget);
    expect(find.text('Training Recommendations'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Help & Support'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);

    await tester.ensureVisible(find.text('Appearance'));
    await tester.tap(find.text('Appearance'));
    await tester.pumpAndSettle();
    expect(find.text('Dark theme'), findsOneWidget);
    await tester.tap(find.text('Dark theme'));
    await tester.pumpAndSettle();
    expect(themeModeNotifier.value, ThemeMode.dark);
    themeModeNotifier.value = ThemeMode.system;
  });

  testWidgets('profile setup validates required fields', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfileSetupScreen()));

    await tester.ensureVisible(find.text('Create profile'));
    await tester.tap(find.text('Create profile'));
    await tester.pump();

    expect(find.text('Enter your full name'), findsOneWidget);
    expect(find.text('Required'), findsNWidgets(2));
    expect(find.textContaining('Complete your date of birth'), findsOneWidget);
  });

  testWidgets('selects a sport before continuing to preparation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: const SportSelectionScreen(), onGenerateRoute: AppRoutes.onGenerateRoute));

    expect(find.text('Select Your Sport'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
    expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Continue')).onPressed, isNull);

    await tester.tap(find.text('Football'));
    await tester.pump();
    expect(find.text('Football selected'), findsOneWidget);
    expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Continue')).onPressed, isNotNull);

    await tester.ensureVisible(find.text('Continue'));
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.byType(SportPreparationScreen), findsOneWidget);
    expect(find.text('Football Assessment'), findsOneWidget);
  });

  testWidgets('shows preparation guidance and mock upload options', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: const SportPreparationScreen(sportName: 'Cricket'), onGenerateRoute: AppRoutes.onGenerateRoute));

    expect(find.text('Cricket Assessment'), findsOneWidget);
    expect(find.text('Instructions'), findsOneWidget);
    expect(find.text('Required equipment'), findsOneWidget);
    expect(find.text('Video recording guidelines'), findsOneWidget);
    expect(find.text('Recommended camera setup'), findsOneWidget);
    expect(find.text('Duration'), findsOneWidget);

    expect(find.text('Start Recording'), findsOneWidget);
    expect(find.text('Upload Video'), findsOneWidget);
  });

  testWidgets('opens simulated camera from preparation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: const VideoSubmissionScreen(sportName: 'Tennis'), onGenerateRoute: AppRoutes.onGenerateRoute));

    expect(find.text('Submit Your Performance'), findsOneWidget);
    await tester.tap(find.text('Record Video'));
    await tester.pumpAndSettle();
    expect(find.byType(SimulatedCameraScreen), findsOneWidget);
    expect(find.text('Tennis recording'), findsOneWidget);
  });

  testWidgets('uploads a mock video and submits for processing', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: const VideoSubmissionScreen(sportName: 'Cricket'), onGenerateRoute: AppRoutes.onGenerateRoute));

    await tester.tap(find.text('Upload Video'));
    await tester.pumpAndSettle();
    expect(find.text('Select a video'), findsOneWidget);
    await tester.tap(find.text('training_session.mp4'));
    await tester.pumpAndSettle();
    expect(find.text('training_session.mp4'), findsOneWidget);
    expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Submit for Assessment')).onPressed, isNotNull);

    await tester.pumpWidget(MaterialApp(home: const VideoProcessingScreen(sportName: 'Cricket'), onGenerateRoute: AppRoutes.onGenerateRoute));
    await tester.pump();
    expect(find.byType(VideoProcessingScreen), findsOneWidget);
    expect(find.text('Analyzing Your Performance'), findsOneWidget);
    expect(find.text('Video uploaded'), findsOneWidget);
    expect(find.text('Preparing frames'), findsOneWidget);
    expect(find.text('Detecting body movement'), findsOneWidget);
    expect(find.text('Extracting movement features'), findsOneWidget);
    expect(find.text('Calculating performance metrics'), findsOneWidget);
    expect(find.text('Generating assessment'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 4300));
    await tester.pumpAndSettle();
    expect(find.byType(AssessmentResultScreen), findsOneWidget);
    expect(find.text('Your Performance Result'), findsNWidgets(2));
    expect(find.text('Overall Performance'), findsOneWidget);
    expect(find.text('Strengths'), findsOneWidget);
    expect(find.text('Areas to Improve'), findsOneWidget);
    expect(find.text('AI-style Feedback'), findsOneWidget);
    expect(find.text('Recommended Training'), findsOneWidget);
    expect(find.text('87'), findsOneWidget);
  });

  testWidgets('renders detailed performance analysis', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DetailedAnalysisScreen(sportName: 'Football')));

    expect(find.text('Detailed Performance Analysis'), findsOneWidget);
    expect(find.text('Performance Overview'), findsOneWidget);
    expect(find.text('Physical Metrics'), findsOneWidget);
    expect(find.text('Movement Quality'), findsOneWidget);
    expect(find.text('Technique'), findsWidgets);
    expect(find.text('Consistency'), findsWidgets);
    expect(find.text('Your score'), findsOneWidget);
    expect(find.text('Benchmark'), findsOneWidget);
    expect(find.text('Speed'), findsWidgets);
    expect(find.text('89'), findsWidgets);
  });

  testWidgets('renders personalized training recommendations', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: const TrainingRecommendationsScreen(sportName: 'Football')));

    expect(find.text('Recommended Exercises'), findsOneWidget);
    expect(find.text('Sprint Training'), findsOneWidget);
    expect(find.text('Agility Ladder'), findsOneWidget);
    expect(find.text('Balance Training'), findsOneWidget);
    expect(find.text('Technique Drills'), findsOneWidget);
    expect(find.text('Improve acceleration'), findsOneWidget);
    expect(find.text('3 sets'), findsWidgets);
    expect(find.text('Start Training'), findsOneWidget);

    await tester.ensureVisible(find.text('Start Training'));
    await tester.tap(find.text('Start Training'));
    await tester.pump();
    expect(find.text('Training session started in mock mode'), findsOneWidget);
  });

  testWidgets('filters, sorts, and opens assessment history results', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: const AssessmentHistoryScreen(), onGenerateRoute: AppRoutes.onGenerateRoute));

    expect(find.text('Assessment History'), findsOneWidget);
    expect(find.text('08 Sep 2026'), findsOneWidget);
    expect(find.text('Football'), findsNWidgets(3));

    await tester.tap(find.text('Cricket').first);
    await tester.pumpAndSettle();
    expect(find.text('25 Aug 2026'), findsOneWidget);
    expect(find.text('03 Aug 2026'), findsOneWidget);
    expect(find.text('08 Sep 2026'), findsNothing);

    await tester.ensureVisible(find.text('03 Aug 2026'));
    await tester.tap(find.text('03 Aug 2026'));
    await tester.pumpAndSettle();
    expect(find.byType(AssessmentResultScreen), findsOneWidget);
    expect(find.text('Cricket assessment'), findsOneWidget);
  });

  testWidgets('switches across the main navigation destinations', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainNavigationScreen()));

    final navigationBar = find.byType(NavigationBar);
    expect(tester.widget<NavigationBar>(navigationBar).selectedIndex, 0);

    await tester.tap(find.text('Assess'));
    await tester.pump();
    expect(tester.widget<NavigationBar>(navigationBar).selectedIndex, 1);

    await tester.tap(find.text('Results'));
    await tester.pump();
    expect(tester.widget<NavigationBar>(navigationBar).selectedIndex, 2);

    await tester.tap(find.text('Training'));
    await tester.pump();
    expect(tester.widget<NavigationBar>(navigationBar).selectedIndex, 3);

    await tester.tap(find.text('Profile'));
    await tester.pump();
    expect(tester.widget<NavigationBar>(navigationBar).selectedIndex, 4);
  });
}