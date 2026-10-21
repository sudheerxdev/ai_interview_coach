import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../models/profile_model.dart';
import '../../services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
	const ProfileScreen({super.key});

	@override
	State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
	late Future<ProfileModel?> _profileFuture;

	@override
	void initState() {
		super.initState();
		_profileFuture = const ProfileService().loadProfile();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('My Profile')),
			body: FutureBuilder<ProfileModel?>(
				future: _profileFuture,
				builder: (context, snapshot) {
					if (snapshot.connectionState == ConnectionState.waiting) {
						return const Center(child: CircularProgressIndicator());
					}
					if (snapshot.hasError || snapshot.data == null) {
						return const Center(child: Text('Profile information is unavailable.'));
					}
					final profile = snapshot.data!;
					return ListView(
						padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
						children: [
							_ProfileHeader(profile: profile),
							const SizedBox(height: 24),
							_InfoCard(label: 'Full name', value: profile.displayName),
							_InfoCard(label: 'Email', value: profile.email),
							const SizedBox(height: 12),
							FilledButton.icon(
								onPressed: () async {
									await Navigator.pushNamed(context, AppRoutes.editProfile);
									if (mounted) {
										setState(() => _profileFuture = const ProfileService().loadProfile());
									}
								},
								icon: const Icon(Icons.edit_outlined),
								label: const Text('Edit Profile'),
							),
						],
					);
				},
			),
		);
	}
}

class _ProfileHeader extends StatelessWidget {
	const _ProfileHeader({required this.profile});

	final ProfileModel profile;

	@override
	Widget build(BuildContext context) {
		return Column(
			children: [
				CircleAvatar(
					radius: 44,
					backgroundColor: Theme.of(context).colorScheme.primary,
					foregroundColor: Theme.of(context).scaffoldBackgroundColor,
					child: Text(profile.initials, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
				),
				const SizedBox(height: 14),
				Text(profile.displayName, style: Theme.of(context).textTheme.headlineSmall),
				const SizedBox(height: 4),
				Text(profile.email, style: Theme.of(context).textTheme.bodyMedium),
				const SizedBox(height: 8),
				Text('Authenticated account', style: Theme.of(context).textTheme.bodySmall),
			],
		);
	}
}

class _InfoCard extends StatelessWidget {
	const _InfoCard({required this.label, required this.value});

	final String label;
	final String value;

	@override
	Widget build(BuildContext context) {
		return Card(
			child: ListTile(
				title: Text(label, style: Theme.of(context).textTheme.bodySmall),
				subtitle: Padding(
					padding: const EdgeInsets.only(top: 4),
					child: Text(value, style: Theme.of(context).textTheme.titleMedium),
				),
			),
		);
	}
}
