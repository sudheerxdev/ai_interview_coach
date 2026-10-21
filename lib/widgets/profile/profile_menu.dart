import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../config/supabase_config.dart';
import '../../models/profile_model.dart';
import '../../services/auth_service.dart';
import '../../services/profile_service.dart';

Future<void> showProfileMenu(BuildContext context) async {
  final user = const AuthService().currentUser;
  if (user == null) return;

  final profile = await _loadProfileSafely();
  if (!context.mounted) return;

  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (sheetContext) => SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profile', style: Theme.of(sheetContext).textTheme.headlineSmall),
            const SizedBox(height: 16),
            _ProfileHeader(
              name: profile?.displayName ?? 'Interview candidate',
              email: profile?.email ?? user.email ?? 'Email unavailable',
              initials: profile?.initials ?? '?',
            ),
            const Divider(height: 32),
            _MenuItem(
              icon: Icons.person_outline_rounded,
              title: 'My Profile',
              onTap: () => _open(sheetContext, AppRoutes.profile),
            ),
            _MenuItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () => _open(sheetContext, AppRoutes.settings),
            ),
            _MenuItem(
              icon: Icons.palette_outlined,
              title: 'Appearance',
              onTap: () => _open(sheetContext, AppRoutes.appearance),
            ),
            _MenuItem(
              icon: Icons.notifications_none_rounded,
              title: 'Notifications',
              onTap: () => _open(sheetContext, AppRoutes.notifications),
            ),
            _MenuItem(
              icon: Icons.lock_outline_rounded,
              title: 'Privacy & Security',
              onTap: () => _open(sheetContext, AppRoutes.privacySecurity),
            ),
            _MenuItem(
              icon: Icons.workspace_premium_outlined,
              title: 'Subscription',
              onTap: () => _open(sheetContext, AppRoutes.subscription),
            ),
            _MenuItem(
              icon: Icons.bar_chart_rounded,
              title: 'Usage',
              onTap: () => _open(sheetContext, AppRoutes.usage),
            ),
            _MenuItem(
              icon: Icons.help_outline_rounded,
              title: 'Help & Support',
              onTap: () => _open(sheetContext, AppRoutes.helpSupport),
            ),
            _MenuItem(
              icon: Icons.info_outline_rounded,
              title: 'About InterviewAI',
              onTap: () => _open(sheetContext, AppRoutes.about),
            ),
            const Divider(height: 32),
            _MenuItem(
              icon: Icons.logout_rounded,
              title: 'Sign Out',
              destructive: true,
              onTap: () async {
                Navigator.pop(sheetContext);
                await confirmSignOut(context);
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Future<ProfileModel?> _loadProfileSafely() async {
  if (!SupabaseConfig.isConfigured) return null;
  try {
    return await const ProfileService().loadProfile();
  } catch (_) {
    return null;
  }
}

Future<void> confirmSignOut(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Sign out?'),
      content: const Text('You will need to sign in again to access your interviews.'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Sign Out'),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return;

  try {
    await const AuthService().signOut();
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authErrorMessage(error))),
      );
    }
    return;
  }
  if (context.mounted) {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
  }
}

void _open(BuildContext context, String route) {
  Navigator.pop(context);
  Navigator.pushNamed(context, route);
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.name, required this.email, required this.initials});

  final String name;
  final String email;
  final String initials;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: Text(initials, style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 3),
              Text(email, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({required this.icon, required this.title, required this.onTap, this.destructive = false});

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? Theme.of(context).colorScheme.error : null;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color),
      title: Text(title, style: color == null ? null : TextStyle(color: color)),
      onTap: onTap,
    );
  }
}
