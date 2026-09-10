import 'package:flutter/material.dart';

import '../screens/main_navigation_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/registration_screen.dart';
import '../screens/profile/athlete_profile_screen.dart';
import '../screens/profile/profile_form_screen.dart';
import '../screens/sport/sport_preparation_screen.dart';
import '../screens/sport/sport_selection_screen.dart';
import '../screens/sport/simulated_camera_screen.dart';
import '../screens/sport/video_processing_screen.dart';
import '../screens/sport/assessment_result_screen.dart';
import '../screens/sport/assessment_history_screen.dart';
import '../screens/sport/detailed_analysis_screen.dart';
import '../screens/sport/training_recommendations_screen.dart';
import '../screens/sport/video_submission_screen.dart';
import '../screens/splash/splash_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const registration = '/registration';
  static const forgotPassword = '/forgot-password';
  static const home = '/';
  static const assessments = '/assessments';
  static const profile = '/profile';
  static const profileSetup = '/profile-setup';
  static const profileEdit = '/profile-edit';
  static const sportSelection = '/sport-selection';
  static const sportPreparation = '/sport-preparation';
  static const simulatedCamera = '/simulated-camera';
  static const videoSubmission = '/video-submission';
  static const videoProcessing = '/video-processing';
  static const assessmentResult = '/assessment-result';
  static const detailedAnalysis = '/detailed-analysis';
  static const trainingRecommendations = '/training-recommendations';

  static PageRoute<dynamic> _fadeRoute(WidgetBuilder builder) => PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => builder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic), child: child),
        transitionDuration: const Duration(milliseconds: 260),
      );

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _fadeRoute((_) => const SplashScreen());
      case onboarding:
        return _fadeRoute((_) => const OnboardingScreen());
      case login:
        return _fadeRoute((_) => const LoginScreen());
      case registration:
        return _fadeRoute((_) => const RegistrationScreen());
      case forgotPassword:
        return _fadeRoute((_) => const ForgotPasswordScreen());
      case home:
        return _fadeRoute((_) => const MainNavigationScreen());
      case assessments:
        return _fadeRoute((_) => const AssessmentHistoryScreen());
      case profile:
        return _fadeRoute((_) => const AthleteProfileScreen());
      case profileSetup:
        return _fadeRoute((_) => const ProfileSetupScreen());
      case profileEdit:
        return _fadeRoute((_) => const EditProfileScreen());
      case sportSelection:
        return _fadeRoute((_) => const SportSelectionScreen());
      case sportPreparation:
        final sportName = settings.arguments as String? ?? 'Football';
        return _fadeRoute((_) => SportPreparationScreen(sportName: sportName));
      case simulatedCamera:
        final sportName = settings.arguments as String? ?? 'Football';
        return _fadeRoute((_) => SimulatedCameraScreen(sportName: sportName));
      case videoSubmission:
        final arguments = settings.arguments;
        final values = arguments is Map<String, Object?> ? arguments : const <String, Object?>{};
        return _fadeRoute((_) => VideoSubmissionScreen(sportName: values['sportName'] is String ? values['sportName']! as String : 'Football', hasRecordedVideo: values['hasRecordedVideo'] is bool ? values['hasRecordedVideo']! as bool : false));
      case videoProcessing:
        final sportName = settings.arguments as String? ?? 'Football';
        return _fadeRoute((_) => VideoProcessingScreen(sportName: sportName));
      case assessmentResult:
        final sportName = settings.arguments as String? ?? 'Football';
        return _fadeRoute((_) => AssessmentResultScreen(sportName: sportName));
      case detailedAnalysis:
        final sportName = settings.arguments as String? ?? 'Football';
        return _fadeRoute((_) => DetailedAnalysisScreen(sportName: sportName));
      case trainingRecommendations:
        final sportName = settings.arguments as String? ?? 'Football';
        return _fadeRoute((_) => TrainingRecommendationsScreen(sportName: sportName));
      default:
        return _fadeRoute((_) => const MainNavigationScreen());
    }
  }
}