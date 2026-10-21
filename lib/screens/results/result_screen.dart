import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../models/answer_model.dart';
import '../../models/evaluation_model.dart';
import '../../models/interview_model.dart';
import '../../services/local_evaluation_service.dart';
import 'score_card.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.interview,
    required this.answers,
  });

  final InterviewModel interview;
  final List<AnswerModel> answers;

  @override
  Widget build(BuildContext context) {
    const service = LocalEvaluationService();
    final evaluations = service.evaluateInterview(interview, answers);
    final average = evaluations.isEmpty
        ? 0
        : (evaluations.map((item) => item.overallScore).reduce((a, b) => a + b) /
                evaluations.length)
            .round();
    final overall = EvaluationModel(
      overallScore: average,
      relevance: _average(evaluations, (item) => item.relevance),
      clarity: _average(evaluations, (item) => item.clarity),
      grammar: _average(evaluations, (item) => item.grammar),
      completeness: _average(evaluations, (item) => item.completeness),
      feedback: 'Review each answer to see where you can improve.',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Interview results')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Text(interview.role, style: Theme.of(context).textTheme.headlineSmall),
          Text('${interview.type} · ${interview.difficulty}'),
          const SizedBox(height: 20),
          ScoreCard(evaluation: overall),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: const Icon(Icons.auto_awesome_outlined),
              title: const Text('Feedback'),
              subtitle: const Text('Review your strengths and improvement areas.'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.feedback,
                arguments: evaluations,
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.analytics_outlined),
              title: const Text('Answer analysis'),
              subtitle: Text('${answers.length} answer(s) recorded locally.'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.answerAnalysis,
                arguments: {
                  'interview': interview,
                  'answers': answers,
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            ),
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }

  int _average(List<EvaluationModel> values, int Function(EvaluationModel) pick) {
    if (values.isEmpty) return 0;
    return (values.map(pick).reduce((a, b) => a + b) / values.length).round();
  }
}// Result screen.
