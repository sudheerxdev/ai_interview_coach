import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../services/auth_service.dart';
import '../../widgets/profile/profile_menu.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = const AuthService().currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & Security')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Card(child: ListTile(leading: const Icon(Icons.verified_user_outlined), title: const Text('Active session'), subtitle: Text(user?.email ?? 'No authenticated session'))),
          Card(child: ListTile(leading: const Icon(Icons.lock_reset_rounded), title: const Text('Change password'), trailing: const Icon(Icons.chevron_right_rounded), onTap: () => Navigator.pushNamed(context, AppRoutes.forgotPassword))),
          Card(child: ListTile(leading: const Icon(Icons.logout_rounded), title: const Text('Sign out'), trailing: const Icon(Icons.chevron_right_rounded), onTap: () => confirmSignOut(context))),
          const SizedBox(height: 12),
          const Card(child: ListTile(leading: Icon(Icons.delete_outline_rounded), title: Text('Delete account'), subtitle: Text('Account deletion requires a secure backend workflow and is not enabled.'))),
          const SizedBox(height: 12),
          const Text('Privacy policy and terms of service links will be added when their published documents are available.'),
        ],
      ),
    );
  }
}
