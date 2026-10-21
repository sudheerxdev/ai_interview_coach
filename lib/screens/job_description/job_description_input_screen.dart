import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../services/document_analysis_service.dart';

class JobDescriptionInputScreen extends StatefulWidget {
  const JobDescriptionInputScreen({super.key});

  @override
  State<JobDescriptionInputScreen> createState() => _JobDescriptionInputScreenState();
}

class _JobDescriptionInputScreenState extends State<JobDescriptionInputScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Job Description')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Paste the job listing', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('Local extraction is available now. AI-powered analysis will use a secure backend later.'),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            minLines: 12,
            maxLines: 18,
            decoration: const InputDecoration(
              labelText: 'Job description',
              alignLabelWithHint: true,
              hintText: 'Paste responsibilities, requirements, and technologies here...',
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              final analysis = const DocumentAnalysisService().analyzeJobDescription(_controller.text);
              Navigator.pushNamed(context, AppRoutes.jobAnalysis, arguments: analysis);
            },
            icon: const Icon(Icons.analytics_outlined),
            label: const Text('Analyze Job Description'),
          ),
        ],
      ),
    );
  }
}