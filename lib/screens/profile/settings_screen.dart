import 'package:flutter/material.dart';

import '../../app/routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          _Section(title: 'Account', children: [
            _Tile(icon: Icons.person_outline_rounded, title: 'My Profile', onTap: () => Navigator.pushNamed(context, AppRoutes.profile)),
            _Tile(icon: Icons.lock_reset_rounded, title: 'Change Password', onTap: () => Navigator.pushNamed(context, AppRoutes.forgotPassword)),
            _Tile(icon: Icons.palette_outlined, title: 'Appearance', onTap: () => Navigator.pushNamed(context, AppRoutes.appearance)),
            _Tile(icon: Icons.notifications_none_rounded, title: 'Notifications', onTap: () => Navigator.pushNamed(context, AppRoutes.notifications)),
            _Tile(icon: Icons.lock_outline_rounded, title: 'Privacy & Security', onTap: () => Navigator.pushNamed(context, AppRoutes.privacySecurity)),
            _Tile(icon: Icons.workspace_premium_outlined, title: 'Subscription', onTap: () => Navigator.pushNamed(context, AppRoutes.subscription)),
            _Tile(icon: Icons.bar_chart_rounded, title: 'Usage', onTap: () => Navigator.pushNamed(context, AppRoutes.usage)),
          ]),
          _Section(title: 'Interview', children: [
            _Tile(icon: Icons.tune_rounded, title: 'Interview Preferences', subtitle: 'Use the interview setup before each practice session.', onTap: () => Navigator.pushNamed(context, AppRoutes.jobRole)),
            _Tile(icon: Icons.history_rounded, title: 'Interview History', onTap: () => Navigator.pushNamed(context, AppRoutes.interviewHistory)),
          ]),
          _Section(title: 'Support', children: [
            _Tile(icon: Icons.help_outline_rounded, title: 'Help & Support', onTap: () => Navigator.pushNamed(context, AppRoutes.helpSupport)),
            _Tile(icon: Icons.info_outline_rounded, title: 'About InterviewAI', onTap: () => Navigator.pushNamed(context, AppRoutes.about)),
          ]),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.only(top: 16, bottom: 8), child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
          Card(child: Column(children: children)),
        ],
      );
}

class _Tile extends StatelessWidget {
  const _Tile({required this.icon, required this.title, required this.onTap, this.subtitle});
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle!),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      );
}
