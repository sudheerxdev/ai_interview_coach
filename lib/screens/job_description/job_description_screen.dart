import 'package:flutter/material.dart';

import '../../app/routes.dart';

class JobDescriptionScreen extends StatelessWidget {
	const JobDescriptionScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Job Description')), 
			body: ListView(
				padding: const EdgeInsets.all(20),
				children: [
					Text('Target a real opportunity', style: Theme.of(context).textTheme.headlineSmall),
					const SizedBox(height: 8),
					const Text('Analyze a job description to prepare for its skills, responsibilities, and requirements.'),
					const SizedBox(height: 24),
					Card(
						child: ListTile(
							leading: const Icon(Icons.work_outline_rounded),
							title: const Text('Enter job description'),
							subtitle: const Text('Paste the listing text for local analysis.'),
							trailing: const Icon(Icons.chevron_right_rounded),
							onTap: () => Navigator.pushNamed(context, AppRoutes.jobDescriptionInput),
						),
					),
				],
			),
		);
	}
}
