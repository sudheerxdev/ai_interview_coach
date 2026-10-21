import 'package:flutter/material.dart';

abstract final class AppTheme {
	static const Color _background = Color(0xFF07110E);
	static const Color _surface = Color(0xFF101F1C);
	static const Color _surfaceElevated = Color(0xFF132621);
	static const Color _border = Color(0xFF234439);
	static const Color _primary = Color(0xFF73F0C4);
	static const Color _accent = Color(0xFF8D7BFF);
	static const Color _textPrimary = Color(0xFFE9F7F2);
	static const Color _textSecondary = Color(0xFFA6BDB6);
	static const Color _textMuted = Color(0xFF7A928C);
	static const Color _error = Color(0xFFFF6F7A);

	static ThemeData get dark {
		return ThemeData(
			useMaterial3: true,
			brightness: Brightness.dark,
			scaffoldBackgroundColor: _background,
			fontFamily: 'sans-serif',
			colorScheme: ColorScheme.fromSeed(
				seedColor: _accent,
				brightness: Brightness.dark,
				primary: _primary,
				onPrimary: const Color(0xFF02140F),
				secondary: _accent,
				surface: _surface,
				error: _error,
			),
			textTheme: const TextTheme(
				displayLarge: TextStyle(
					color: _textPrimary,
					fontWeight: FontWeight.w800,
					letterSpacing: -0.04,
				),
				displayMedium: TextStyle(
					color: _textPrimary,
					fontWeight: FontWeight.w700,
					letterSpacing: -0.03,
				),
				headlineLarge: TextStyle(
					color: _textPrimary,
					fontWeight: FontWeight.w800,
					letterSpacing: -0.03,
				),
				headlineMedium: TextStyle(
					color: _textPrimary,
					fontWeight: FontWeight.w700,
					letterSpacing: -0.02,
				),
				headlineSmall: TextStyle(
					color: _textPrimary,
					fontWeight: FontWeight.w700,
				),
				titleLarge: TextStyle(
					color: _textPrimary,
					fontWeight: FontWeight.w700,
				),
				titleMedium: TextStyle(
					color: _textPrimary,
					fontWeight: FontWeight.w600,
				),
				bodyLarge: TextStyle(color: _textSecondary, height: 1.5),
				bodyMedium: TextStyle(color: _textSecondary, height: 1.5),
				bodySmall: TextStyle(color: _textMuted, height: 1.4),
				labelLarge: TextStyle(color: _textPrimary, fontWeight: FontWeight.w600),
			),
			appBarTheme: const AppBarTheme(
				surfaceTintColor: Colors.transparent,
				backgroundColor: Colors.transparent,
				elevation: 0,
				foregroundColor: _textPrimary,
				centerTitle: false,
			),
			cardTheme: CardThemeData(
				color: _surface,
				shadowColor: Colors.black.withValues(alpha: 0.28),
				elevation: 0,
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(24),
					side: const BorderSide(color: _border, width: 1),
				),
			),
			inputDecorationTheme: InputDecorationTheme(
				filled: true,
				fillColor: _surfaceElevated,
				contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
				border: OutlineInputBorder(
					borderRadius: BorderRadius.circular(18),
					borderSide: const BorderSide(color: _border),
				),
				enabledBorder: OutlineInputBorder(
					borderRadius: BorderRadius.circular(18),
					borderSide: const BorderSide(color: _border),
				),
				focusedBorder: OutlineInputBorder(
					borderRadius: BorderRadius.circular(18),
					borderSide: const BorderSide(color: _primary, width: 1.5),
				),
				errorBorder: OutlineInputBorder(
					borderRadius: BorderRadius.circular(18),
					borderSide: const BorderSide(color: _error),
				),
				hintStyle: const TextStyle(color: _textMuted),
				labelStyle: const TextStyle(color: _textSecondary),
			),
			elevatedButtonTheme: ElevatedButtonThemeData(
				style: ElevatedButton.styleFrom(
					foregroundColor: _background,
					backgroundColor: _primary,
					elevation: 0,
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(18),
					),
					padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
					textStyle: const TextStyle(
						fontWeight: FontWeight.w700,
						fontSize: 16,
					),
				),
			),
			filledButtonTheme: FilledButtonThemeData(
				style: FilledButton.styleFrom(
					foregroundColor: _background,
					backgroundColor: _primary,
					elevation: 0,
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(18),
					),
					padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
					textStyle: const TextStyle(
						fontWeight: FontWeight.w700,
						fontSize: 16,
					),
				),
			),
			outlinedButtonTheme: OutlinedButtonThemeData(
				style: OutlinedButton.styleFrom(
					foregroundColor: _textPrimary,
					side: const BorderSide(color: _border, width: 1),
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(18),
					),
					padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
					textStyle: const TextStyle(
						fontWeight: FontWeight.w600,
					),
				),
			),
			textButtonTheme: TextButtonThemeData(
				style: TextButton.styleFrom(
					foregroundColor: _primary,
					textStyle: const TextStyle(
						fontWeight: FontWeight.w600,
					),
				),
			),
		);
	}

	static ThemeData get light => dark;
}
