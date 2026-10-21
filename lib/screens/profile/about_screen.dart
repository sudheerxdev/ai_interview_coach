import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About InterviewAI')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        children: [
          Icon(Icons.mic_none_rounded, size: 72, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          Text('InterviewAI', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text('Version 1.0.0', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 20),
          const Text('AI-powered interview preparation and coaching.', textAlign: TextAlign.center),
          const SizedBox(height: 28),
          const Card(child: ListTile(title: Text('Terms of Service'), subtitle: Text('Published terms are not connected yet.'))),
          const Card(child: ListTile(title: Text('Privacy Policy'), subtitle: Text('Published policy is not connected yet.'))),
          const Card(child: ListTile(title: Text('Open source licenses'), subtitle: Text('Available through the Flutter application build.'))),
        ],
      ),
    );
  }
}
