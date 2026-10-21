import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../config/supabase_config.dart';
import '../../widgets/profile/profile_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (!SupabaseConfig.isConfigured ||
        SupabaseConfig.client.auth.currentSession == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted)
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.login, (_) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good evening',
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'InterviewAI',
                        style: theme.textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => showProfileMenu(context),
                  icon: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF8D7BFF),
                          Color(0xFF5AE4C4),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Color(0xFF07110E),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF121E1D),
                    Color(0xFF0A1715),
                    Color(0xFF0D1314),
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                    color: const Color(0xFF7C6BFF).withValues(alpha: 0.3),
                    width: 1),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8D7BFF).withValues(alpha: 0.18),
                    blurRadius: 32,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ready for your next interview?',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Practice with AI coaching and sharpen the answers that matter most.',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.jobRole),
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Start Interview'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const _SectionTitle(title: 'Overview'),
            const SizedBox(height: 12),
            const Row(
              children: [
                Expanded(child: _StatCard(value: '0', label: 'Interviews')),
                SizedBox(width: 12),
                Expanded(child: _StatCard(value: '--', label: 'Best score')),
              ],
            ),
            const SizedBox(height: 24),
            const _SectionTitle(title: 'Cover Letters'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF121D1C),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFF213F36), width: 1),
              ),
              child: Column(
                children: [
                  const Icon(Icons.description_outlined,
                      size: 28, color: Color(0xFF5AE4C4)),
                  const SizedBox(height: 12),
                  Text(
                    'No cover letters yet',
                    style: theme.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create a polished cover letter with InterviewAI.',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.resume),
                      child: const Text('Write Cover Letter'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const _SectionTitle(title: 'Quick access'),
            const SizedBox(height: 12),
            _ExploreTile(
              icon: Icons.history_rounded,
              title: 'Interview History',
              subtitle: 'Review previous sessions and scores.',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.interviewHistory),
            ),
            _ExploreTile(
              icon: Icons.workspace_premium_outlined,
              title: 'Premium practice',
              subtitle: 'Unlock deeper preparation tools.',
              onTap: () => Navigator.pushNamed(context, AppRoutes.premium),
            ),
            _ExploreTile(
              icon: Icons.description_outlined,
              title: 'Resume insights',
              subtitle: 'Extract key skills for focused practice.',
              onTap: () => Navigator.pushNamed(context, AppRoutes.resume),
            ),
            _ExploreTile(
              icon: Icons.work_outline_rounded,
              title: 'Job description',
              subtitle: 'Prepare for a specific opportunity.',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.jobDescription),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleLarge);
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF121D1C),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1E3D34), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _ExploreTile extends StatelessWidget {
  const _ExploreTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF101B1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF213F36), width: 1),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFF132A25),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: const Color(0xFF5AE4C4)),
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
