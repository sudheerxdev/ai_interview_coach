import 'package:flutter/material.dart';

import '../../app/routes.dart';

class InterviewSetupScreen extends StatelessWidget {
	const InterviewSetupScreen({
		super.key,
		required this.selectedRole,
		required this.selectedType,
		required this.selectedDifficulty,
	});

	final String selectedRole;
	final String selectedType;
	final String selectedDifficulty;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Review interview')), 
			body: ListView(
				padding: const EdgeInsets.all(20),
				children: [
					Text(
						'You are all set.',
						style: Theme.of(context).textTheme.headlineSmall,
					),
					const SizedBox(height: 8),
					Text(
						'Review your choices before starting a mock session.',
						style: Theme.of(context).textTheme.bodyLarge,
					),
					const SizedBox(height: 24),
					_SummaryTile(label: 'Job role', value: selectedRole),
					_SummaryTile(label: 'Interview type', value: selectedType),
					_SummaryTile(label: 'Difficulty', value: selectedDifficulty),
					const SizedBox(height: 24),
					FilledButton.icon(
						onPressed: () => Navigator.pushNamed(
							context,
							AppRoutes.interview,
							arguments: {
								'role': selectedRole,
								'type': selectedType,
								'difficulty': selectedDifficulty,
							},
						),
						icon: const Icon(Icons.play_arrow_rounded),
						label: const Text('Begin mock interview'),
					),
					const SizedBox(height: 12),
					Text(
						'Questions are currently provided by local mock data.',
						textAlign: TextAlign.center,
						style: Theme.of(context).textTheme.bodySmall,
					),
				],
			),
		);
	}

}

class _SummaryTile extends StatelessWidget {
	const _SummaryTile({required this.label, required this.value});

	final String label;
	final String value;

	@override
	Widget build(BuildContext context) {
		return Card(
			child: ListTile(
				title: Text(label),
				subtitle: Text(value),
			),
		);
	}
}
