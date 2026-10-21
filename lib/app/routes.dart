import 'package:flutter/material.dart';

import '../models/answer_model.dart';
import '../models/evaluation_model.dart';
import '../models/interview_model.dart';
import '../models/document_analysis_model.dart';
import '../models/interview_history_model.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/job_description/job_analysis_screen.dart';
import '../screens/job_description/job_description_input_screen.dart';
import '../screens/job_description/job_description_screen.dart';
import '../screens/history/interview_detail_screen.dart';
import '../screens/history/interview_history_screen.dart';
import '../screens/interview/interview_screen.dart';
import '../screens/interview_setup/difficulty_screen.dart';
import '../screens/interview_setup/interview_setup_screen.dart';
import '../screens/interview_setup/interview_type_screen.dart';
import '../screens/interview_setup/job_role_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/profile/about_screen.dart';
import '../screens/profile/appearance_screen.dart';
import '../screens/profile/edit_profile_screen.dart';
import '../screens/profile/help_support_screen.dart';
import '../screens/profile/notification_settings_screen.dart';
import '../screens/profile/privacy_security_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/settings_screen.dart';
import '../screens/profile/usage_screen.dart';
import '../screens/results/answer_analysis_screen.dart';
import '../screens/results/feedback_screen.dart';
import '../screens/results/result_screen.dart';
import '../screens/resume/resume_screen.dart';
import '../screens/resume/resume_upload_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/subscription/premium_screen.dart';
import '../screens/subscription/subscription_screen.dart';

abstract final class AppRoutes {
	static const splash = '/';
	static const onboarding = '/onboarding';
	static const login = '/login';
	static const signup = '/signup';
	static const forgotPassword = '/forgot-password';
	static const home = '/home';
	static const jobRole = '/interview-setup/job-role';
	static const interviewType = '/interview-setup/type';
	static const difficulty = '/interview-setup/difficulty';
	static const interviewSetup = '/interview-setup';
	static const interview = '/interview';
	static const results = '/results';
	static const feedback = '/results/feedback';
	static const answerAnalysis = '/results/answer-analysis';
	static const interviewHistory = '/history';
	static const interviewDetail = '/history/detail';
	static const resume = '/resume';
	static const resumeUpload = '/resume/upload';
	static const resumeAnalysis = '/resume/analysis';
	static const jobDescription = '/job-description';
	static const jobDescriptionInput = '/job-description/input';
	static const jobAnalysis = '/job-description/analysis';
	static const premium = '/premium';
	static const subscription = '/subscription';
	static const profile = '/profile';
	static const editProfile = '/profile/edit';
	static const settings = '/settings';
	static const appearance = '/settings/appearance';
	static const notifications = '/settings/notifications';
	static const privacySecurity = '/settings/privacy-security';
	static const usage = '/settings/usage';
	static const helpSupport = '/settings/help-support';
	static const about = '/settings/about';

	static final routes = <String, WidgetBuilder>{
		splash: (context) => const SplashScreen(),
		onboarding: (context) => const OnboardingScreen(),
		login: (context) => const LoginScreen(),
		signup: (context) => const SignupScreen(),
		forgotPassword: (context) => const ForgotPasswordScreen(),
		home: (context) => const HomeScreen(),
		interviewHistory: (context) => const InterviewHistoryScreen(),
		interviewDetail: (context) => InterviewDetailScreen(
			interview: ModalRoute.of(context)?.settings.arguments
				as InterviewHistoryModel,
		),
		resume: (context) => const ResumeScreen(),
		resumeUpload: (context) => const ResumeUploadScreen(),
		resumeAnalysis: (context) => JobAnalysisScreen(
			analysis: ModalRoute.of(context)?.settings.arguments
				as DocumentAnalysisModel,
		),
		jobDescription: (context) => const JobDescriptionScreen(),
		jobDescriptionInput: (context) => const JobDescriptionInputScreen(),
		jobAnalysis: (context) => JobAnalysisScreen(
			analysis: ModalRoute.of(context)?.settings.arguments
				as DocumentAnalysisModel,
		),
		premium: (context) => const PremiumScreen(),
		subscription: (context) => const SubscriptionScreen(),
		profile: (context) => const ProfileScreen(),
		editProfile: (context) => const EditProfileScreen(),
		settings: (context) => const SettingsScreen(),
		appearance: (context) => const AppearanceScreen(),
		notifications: (context) => const NotificationSettingsScreen(),
		privacySecurity: (context) => const PrivacySecurityScreen(),
		usage: (context) => const UsageScreen(),
		helpSupport: (context) => const HelpSupportScreen(),
		about: (context) => const AboutScreen(),
		jobRole: (context) => const JobRoleScreen(),
		interviewType: (context) => InterviewTypeScreen(
			selectedRole: _stringArgument(context),
		),
		difficulty: (context) {
			final arguments = _mapArgument(context);
			return DifficultyScreen(
				selectedRole: arguments['role'] as String? ?? '',
				selectedType: arguments['type'] as String? ?? '',
			);
		},
		interviewSetup: (context) {
			final arguments = _mapArgument(context);
			return InterviewSetupScreen(
				selectedRole: arguments['role'] as String? ?? '',
				selectedType: arguments['type'] as String? ?? '',
				selectedDifficulty: arguments['difficulty'] as String? ?? '',
			);
		},
		interview: (context) {
			final arguments = _mapArgument(context);
			return InterviewScreen(
				selectedRole: arguments['role'] as String? ?? 'General',
				selectedType: arguments['type'] as String? ?? 'Mixed Interview',
				selectedDifficulty: arguments['difficulty'] as String? ?? 'Medium',
			);
		},
		results: (context) {
			final arguments = _mapArgument(context);
			return ResultScreen(
				interview: arguments['interview'] as InterviewModel,
				answers: arguments['answers'] as List<AnswerModel>,
			);
		},
		feedback: (context) => FeedbackScreen(
			evaluations: (ModalRoute.of(context)?.settings.arguments
					as List<EvaluationModel>?) ??
				[],
		),
		answerAnalysis: (context) {
			final arguments = _mapArgument(context);
			return AnswerAnalysisScreen(
				interview: arguments['interview'] as InterviewModel,
				answers: arguments['answers'] as List<AnswerModel>,
			);
		},
	};

	static String? _stringArgument(BuildContext context) {
		final arguments = ModalRoute.of(context)?.settings.arguments;
		return arguments is String ? arguments : null;
	}

	static Map<Object?, Object?> _mapArgument(BuildContext context) {
		final arguments = ModalRoute.of(context)?.settings.arguments;
		return arguments is Map<Object?, Object?> ? arguments : {};
	}
}
