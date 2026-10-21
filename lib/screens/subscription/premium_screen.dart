import 'package:flutter/material.dart';

import '../../app/routes.dart';

class PremiumScreen extends StatelessWidget {
	const PremiumScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Premium Practice')),
			body: ListView(
				padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
				children: [
					Icon(Icons.workspace_premium_rounded, size: 64, color: Theme.of(context).colorScheme.primary),
					const SizedBox(height: 16),
					Text('Prepare with more context.', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
					const SizedBox(height: 8),
					const Text('Premium features are designed for focused, personalized interview preparation.', textAlign: TextAlign.center),
					const SizedBox(height: 24),
					const _FeatureTile(icon: Icons.description_outlined, title: 'Resume-based interviews'),
					const _FeatureTile(icon: Icons.work_outline_rounded, title: 'Job-description practice'),
					const _FeatureTile(icon: Icons.analytics_outlined, title: 'Advanced analytics'),
					const _FeatureTile(icon: Icons.auto_awesome_outlined, title: 'Personalized questions'),
					const SizedBox(height: 16),
					FilledButton(
						onPressed: () => Navigator.pushNamed(context, AppRoutes.subscription),
						child: const Text('View plans'),
					),
				],
			),
		);
	}
}

class _FeatureTile extends StatelessWidget {
	const _FeatureTile({required this.icon, required this.title});

	final IconData icon;
	final String title;

	@override
	Widget build(BuildContext context) {
		return Card(
			child: ListTile(leading: Icon(icon), title: Text(title)),
		);
	}
}
