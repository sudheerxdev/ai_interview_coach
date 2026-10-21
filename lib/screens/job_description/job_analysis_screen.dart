import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../models/document_analysis_model.dart';

class JobAnalysisScreen extends StatelessWidget {
	const JobAnalysisScreen({super.key, required this.analysis});

	final DocumentAnalysisModel analysis;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Job Analysis')),
			body: ListView(
				padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
				children: [
					Text(analysis.title, style: Theme.of(context).textTheme.headlineSmall),
					const SizedBox(height: 20),
					_AnalysisSection(title: 'Skills', values: analysis.skills),
					_AnalysisSection(title: 'Responsibilities', values: analysis.responsibilities),
					_AnalysisSection(title: 'Keywords', values: analysis.keywords),
					_AnalysisSection(title: 'Technologies', values: analysis.technologies),
					_AnalysisSection(title: 'Requirements', values: analysis.requirements),
					const SizedBox(height: 12),
					FilledButton.icon(
						onPressed: () => Navigator.pushNamed(context, AppRoutes.jobRole),
						icon: const Icon(Icons.play_arrow_rounded),
						label: const Text('Use for Interview Practice'),
					),
					const SizedBox(height: 8),
					const Text(
						'The extracted context is ready for personalized question generation when the secure AI backend is connected.',
						textAlign: TextAlign.center,
					),
				],
			),
		);
	}
}

class _AnalysisSection extends StatelessWidget {
	const _AnalysisSection({required this.title, required this.values});

	final String title;
	final List<String> values;

	@override
	Widget build(BuildContext context) {
		return Card(
			margin: const EdgeInsets.only(bottom: 12),
			child: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(title, style: Theme.of(context).textTheme.titleMedium),
						const SizedBox(height: 8),
						if (values.isEmpty)
							const Text('No matching items found locally.')
						else
							...values.map((value) => Padding(
										padding: const EdgeInsets.only(bottom: 4),
										child: Text('• $value'),
									)),
					],
				),
			),
		);
	}
}
