import 'package:flutter/material.dart';

import '../../models/interview_history_model.dart';

class InterviewDetailScreen extends StatelessWidget {
  const InterviewDetailScreen({super.key, required this.interview});

  final InterviewHistoryModel interview;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interview Detail')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Text(interview.role, style: Theme.of(context).textTheme.headlineSmall),
          Text('${interview.type} · ${interview.difficulty}'),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.emoji_events_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Overall Score'),
              trailing: Text(
                '${interview.score}/100',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Questions and answers', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...interview.questions.asMap().entries.map(
                (entry) => _QuestionCard(index: entry.key + 1, item: entry.value),
              ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({required this.index, required this.item});

  final int index;
  final InterviewHistoryQuestion item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text('Question $index'),
        subtitle: Text(item.question),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Answer', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(item.answer?.text.isNotEmpty == true ? item.answer!.text : 'No answer recorded.'),
                if (item.evaluation != null) ...[
                  const SizedBox(height: 16),
                  const Text('Evaluation', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text('Score: ${item.evaluation!.overallScore}/100'),
                  Text(item.evaluation!.feedback),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}// Interview detail screen.
