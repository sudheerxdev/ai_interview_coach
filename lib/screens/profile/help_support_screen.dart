import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          const Text('Support services are not connected yet. These entry points are ready for a future help backend or support email.'),
          const SizedBox(height: 16),
          _SupportTile(icon: Icons.menu_book_outlined, title: 'Help Center'),
          _SupportTile(icon: Icons.question_answer_outlined, title: 'Frequently asked questions'),
          _SupportTile(icon: Icons.mail_outline_rounded, title: 'Contact support'),
          _SupportTile(icon: Icons.bug_report_outlined, title: 'Report a problem'),
        ],
      ),
    );
  }
}

class _SupportTile extends StatelessWidget {
  const _SupportTile({required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) => Card(child: ListTile(leading: Icon(icon), title: Text(title), subtitle: const Text('Not available yet')));
}
