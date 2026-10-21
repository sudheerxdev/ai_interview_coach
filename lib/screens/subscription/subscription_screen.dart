import 'package:flutter/material.dart';

import '../../providers/subscription_provider.dart';

class SubscriptionScreen extends StatefulWidget {
	const SubscriptionScreen({super.key});

	@override
	State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
	late final SubscriptionProvider _provider;

	@override
	void initState() {
		super.initState();
		_provider = SubscriptionProvider()..load();
	}

	@override
	void dispose() {
		_provider.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Subscription')),
			body: AnimatedBuilder(
				animation: _provider,
				builder: (context, child) {
					if (_provider.isLoading || _provider.subscription == null) {
						return const Center(child: CircularProgressIndicator());
					}
					final subscription = _provider.subscription!;
					return ListView(
						padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
						children: [
							Text('Your plan', style: Theme.of(context).textTheme.headlineSmall),
							const SizedBox(height: 16),
							Card(
								child: ListTile(
									leading: Icon(
										subscription.isPremium
												? Icons.workspace_premium_rounded
												: Icons.person_outline_rounded,
									),
									title: Text(subscription.isPremium ? 'Premium' : 'Free'),
									subtitle: Text(
										subscription.isPremium
												? 'Higher allowance and advanced preparation tools.'
												: '${subscription.remainingInterviews} of ${subscription.interviewLimit} interviews remaining this period.',
									),
								),
							),
							const SizedBox(height: 20),
							_PlanCard(
								title: 'Free',
								subtitle: 'For getting started',
								features: const ['5 interviews per month', 'Core interview practice'],
								selected: !subscription.isPremium,
								onPressed: () {},
							),
							_PlanCard(
								title: 'Premium',
								subtitle: 'For deeper preparation',
								features: const [
									'Higher interview allowance',
									'Resume-based interviews',
									'Job-description interviews',
									'Advanced analytics',
									'Personalized questions',
								],
								selected: subscription.isPremium,
								onPressed: () => _showBackendNotice(context),
							),
							const SizedBox(height: 12),
							const Text(
								'Subscription limits must be enforced by the backend. This client only displays the status returned by Supabase.',
								textAlign: TextAlign.center,
							),
						],
					);
				},
			),
		);
	}

	void _showBackendNotice(BuildContext context) {
		ScaffoldMessenger.of(context).showSnackBar(
			const SnackBar(content: Text('Secure billing integration will be added after backend usage controls.')),
		);
	}
}

class _PlanCard extends StatelessWidget {
	const _PlanCard({
		required this.title,
		required this.subtitle,
		required this.features,
		required this.selected,
		required this.onPressed,
	});

	final String title;
	final String subtitle;
	final List<String> features;
	final bool selected;
	final VoidCallback onPressed;

	@override
	Widget build(BuildContext context) {
		return Card(
			color: selected ? Theme.of(context).colorScheme.primaryContainer : null,
			margin: const EdgeInsets.only(bottom: 12),
			child: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(title, style: Theme.of(context).textTheme.titleLarge),
						Text(subtitle),
						const SizedBox(height: 12),
						...features.map((feature) => Padding(
									padding: const EdgeInsets.only(bottom: 6),
									child: Text('✓ $feature'),
								)),
						const SizedBox(height: 8),
						OutlinedButton(onPressed: onPressed, child: Text(selected ? 'Current plan' : 'Choose plan')),
					],
				),
			),
		);
	}
}
