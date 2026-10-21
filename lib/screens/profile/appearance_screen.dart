import 'package:flutter/material.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appearance')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Card(
            child: Column(
              children: [
                RadioListTile<String>(value: 'system', groupValue: 'dark', onChanged: null, title: const Text('System default'), subtitle: const Text('Theme switching is not available yet.')),
                RadioListTile<String>(value: 'light', groupValue: 'dark', onChanged: null, title: const Text('Light')),
                RadioListTile<String>(value: 'dark', groupValue: 'dark', onChanged: null, title: const Text('Dark'), subtitle: const Text('Current appearance')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text('InterviewAI currently uses its dark theme on all devices.'),
        ],
      ),
    );
  }
}
