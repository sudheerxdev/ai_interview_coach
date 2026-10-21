import 'package:flutter/material.dart';

import '../../models/evaluation_model.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key, required this.evaluations});

  final List<EvaluationModel> evaluations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Keep building momentum.', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('These notes are calculated locally for now. AI feedback will be connected through the secure backend phase.'),
          const SizedBox(height: 20),
          ...evaluations.asMap().entries.map(
                (entry) => Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${entry.key + 1}')),
                    title: Text(entry.value.feedback),
                    subtitle: Text('Score: ${entry.value.overallScore}/100'),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}// Feedback screen.
