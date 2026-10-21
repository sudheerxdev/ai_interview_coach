import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../services/document_analysis_service.dart';

class ResumeUploadScreen extends StatefulWidget {
	const ResumeUploadScreen({super.key});

	@override
	State<ResumeUploadScreen> createState() => _ResumeUploadScreenState();
}

class _ResumeUploadScreenState extends State<ResumeUploadScreen> {
	final _controller = TextEditingController();

	@override
	void dispose() {
		_controller.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Add Resume')), 
			body: ListView(
				padding: const EdgeInsets.all(20),
				children: [
					Text('Paste your resume', style: Theme.of(context).textTheme.headlineSmall),
					const SizedBox(height: 8),
					const Text('Local analysis will identify skills, keywords, and technologies. Secure AI analysis comes later.'),
					const SizedBox(height: 20),
					TextField(
						controller: _controller,
						minLines: 12,
						maxLines: 18,
						decoration: const InputDecoration(
							labelText: 'Resume text',
							alignLabelWithHint: true,
							hintText: 'Paste your experience, skills, and achievements here...',
						),
					),
					const SizedBox(height: 16),
					FilledButton.icon(
						onPressed: _analyze,
						icon: const Icon(Icons.auto_awesome_rounded),
						label: const Text('Analyze Resume'),
					),
				],
			),
		);
	}

	void _analyze() {
		final analysis = const DocumentAnalysisService().analyzeResume(_controller.text);
		Navigator.pushNamed(context, AppRoutes.resumeAnalysis, arguments: analysis);
	}
}
