import 'package:flutter/material.dart';

import '../../app/routes.dart';

class ResumeScreen extends StatelessWidget {
	const ResumeScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Resume')), 
			body: ListView(
				padding: const EdgeInsets.all(20),
				children: [
					Text('Personalize your practice', style: Theme.of(context).textTheme.headlineSmall),
					const SizedBox(height: 8),
					const Text('Add your resume to extract skills and create more relevant interview questions.'),
					const SizedBox(height: 24),
					Card(
						child: ListTile(
							leading: const Icon(Icons.upload_file_outlined),
							title: const Text('Upload or enter resume'),
							subtitle: const Text('Paste text for now. File storage comes with the backend flow.'),
							trailing: const Icon(Icons.chevron_right_rounded),
							onTap: () => Navigator.pushNamed(context, AppRoutes.resumeUpload),
						),
					),
					const SizedBox(height: 16),
					const Card(
						child: ListTile(
							leading: Icon(Icons.lock_outline_rounded),
							title: Text('Your resume stays private'),
							subtitle: Text('Future uploads will use private Supabase Storage and user policies.'),
						),
					),
				],
			),
		);
	}
}
