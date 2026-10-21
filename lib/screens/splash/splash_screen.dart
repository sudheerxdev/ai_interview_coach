import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../config/supabase_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _routeTimer;

  @override
  void initState() {
    super.initState();
    _routeTimer = Timer(const Duration(milliseconds: 700), _routeUser);
  }

  @override
  void dispose() {
    _routeTimer?.cancel();
    super.dispose();
  }

  void _routeUser() {
    if (!mounted) return;
    final route = SupabaseConfig.isConfigured &&
            SupabaseConfig.client.auth.currentSession != null
        ? AppRoutes.home
        : AppRoutes.onboarding;
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF07110E),
              Color(0xFF0A1613),
              Color(0xFF0C1A18),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutCubic,
                tween: Tween<double>(begin: 0.84, end: 1),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 104,
                      height: 104,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF8F7BFF),
                            Color(0xFF6AE7C5),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFF7D6BFF).withValues(alpha: 0.32),
                            blurRadius: 28,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.mic_none_rounded,
                        size: 52,
                        color: Color(0xFF07110E),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'InterviewAI',
                      style: theme.textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'AI-powered practice for your next big interview.',
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 36),
                    FilledButton.icon(
                      onPressed: _routeUser,
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text('Get started'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
