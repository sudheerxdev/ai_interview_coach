import 'package:flutter/material.dart';

import '../../app/routes.dart';

class JobRoleScreen extends StatelessWidget {
	const JobRoleScreen({super.key});

	static const roles = [
		'Software Developer',
		'Technical Support',
		'Customer Support',
		'Data Analyst',
		'Business Analyst',
		'Sales',
		'Banking',
		'Finance',
		'QA Tester',
		'Project Manager',
	];

	@override
	Widget build(BuildContext context) {
		return _SetupListScreen(
			title: 'Choose a job role',
			subtitle: 'Tailor the practice session to the role you want.',
			options: roles,
			icon: Icons.work_outline_rounded,
			onSelected: (role) => Navigator.pushNamed(
				context,
				AppRoutes.interviewType,
				arguments: role,
			),
		);
	}
}

class _SetupListScreen extends StatelessWidget {
	const _SetupListScreen({
		required this.title,
		required this.subtitle,
		required this.options,
		required this.icon,
		required this.onSelected,
	});

	final String title;
	final String subtitle;
	final List<String> options;
	final IconData icon;
	final ValueChanged<String> onSelected;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Interview setup')),
			body: ListView(
				padding: const EdgeInsets.all(20),
				children: [
					Text(title, style: Theme.of(context).textTheme.headlineSmall),
					const SizedBox(height: 8),
					Text(subtitle, style: Theme.of(context).textTheme.bodyLarge),
					const SizedBox(height: 20),
					...options.map(
						(option) => Card(
							child: ListTile(
								onTap: () => onSelected(option),
								leading: Icon(icon),
								title: Text(option),
								trailing: const Icon(Icons.chevron_right_rounded),
							),
						),
					),
				],
			),
		);
	}
}
