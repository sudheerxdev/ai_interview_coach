import 'package:flutter/material.dart';

import '../../app/routes.dart';

class DifficultyScreen extends StatelessWidget {
	const DifficultyScreen({
		super.key,
		required this.selectedRole,
		required this.selectedType,
	});

	final String selectedRole;
	final String selectedType;

	static const levels = ['Easy', 'Medium', 'Hard'];

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Interview setup')),
			body: ListView(
				padding: const EdgeInsets.all(20),
				children: [
					Text(
						'Set your difficulty',
						style: Theme.of(context).textTheme.headlineSmall,
					),
					const SizedBox(height: 8),
					Text(
						'$selectedRole · $selectedType',
						style: Theme.of(context).textTheme.bodyLarge,
					),
					const SizedBox(height: 20),
					...levels.map(
						(level) => Card(
							child: ListTile(
								onTap: () => Navigator.pushNamed(
									context,
									AppRoutes.interviewSetup,
									arguments: {
										'role': selectedRole,
										'type': selectedType,
										'difficulty': level,
									},
								),
								leading: Icon(_iconFor(level)),
								title: Text(level),
								subtitle: Text(_descriptionFor(level)),
								trailing: const Icon(Icons.chevron_right_rounded),
							),
						),
					),
				],
			),
		);
	}

	IconData _iconFor(String level) {
		return switch (level) {
			'Easy' => Icons.wb_sunny_outlined,
			'Medium' => Icons.trending_up_rounded,
			_ => Icons.local_fire_department_outlined,
		};
	}

	String _descriptionFor(String level) {
		return switch (level) {
			'Easy' => 'Build confidence with a gentle warm-up.',
			'Medium' => 'Balance familiar questions with a challenge.',
			_ => 'Push your preparation with advanced prompts.',
		};
	}
}
