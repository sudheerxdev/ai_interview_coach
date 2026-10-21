import 'package:flutter_test/flutter_test.dart';

import 'package:ai_interview_coach/models/answer_model.dart';
import 'package:ai_interview_coach/services/ai_service.dart';

void main() {
  const service = LocalMockAiService();

  test('generates a local question without network access', () async {
    final question = await service.generateInterviewQuestion(
      role: 'Software Developer',
      interviewType: 'Technical Interview',
      difficulty: 'Medium',
    );

    expect(question.text, isNotEmpty);
    expect(question.id, startsWith('local-'));
  });

  test('evaluates an answer using local fallback data', () async {
    final evaluation = await service.evaluateAnswer(
      question: 'Tell me about yourself.',
      answer: const AnswerModel(
        questionId: 'question-1',
        text: 'I am a developer who enjoys solving problems.',
        duration: Duration(seconds: 12),
      ),
      role: 'Software Developer',
    );

    expect(evaluation.overallScore, 70);
    expect(evaluation.feedback, contains('saved'));
  });
}
