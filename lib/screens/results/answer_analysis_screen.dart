import 'package:flutter/material.dart';

import '../../models/answer_model.dart';
import '../../models/interview_model.dart';
import '../../services/local_evaluation_service.dart';

class AnswerAnalysisScreen extends StatelessWidget {
  const AnswerAnalysisScreen({
    super.key,
    required this.interview,
    required this.answers,
  });

  final InterviewModel interview;
  final List<AnswerModel> answers;

  @override
  Widget build(BuildContext context) {
    const service = LocalEvaluationService();
    return Scaffold(
      appBar: AppBar(title: const Text('Answer analysis')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: interview.questions.length,
        itemBuilder: (context, index) {
          final question = interview.questions[index];
          final answer = answers.where((item) => item.questionId == question.id).firstOrNull;
          final text = answer?.text.trim() ?? '';
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              title: Text('Question ${index + 1}'),
              subtitle: Text(question.text),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(text.isEmpty ? 'No answer recorded.' : text),
                      const SizedBox(height: 12),
                      Text('Words: ${service.wordCount(text)}'),
                      Text('Filler words: ${service.fillerWordCount(text)}'),
                      Text('Speaking speed: ${answer == null ? 0 : service.speakingSpeed(answer)} WPM'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}// Answer analysis screen.
