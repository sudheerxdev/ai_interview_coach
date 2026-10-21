import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme.dart';

class AIInterviewCoachApp extends StatelessWidget {
	const AIInterviewCoachApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'InterviewAI',
			debugShowCheckedModeBanner: false,
			theme: AppTheme.dark,
			initialRoute: AppRoutes.splash,
			routes: AppRoutes.routes,
		);
	}
}
