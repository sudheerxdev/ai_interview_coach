import 'package:flutter_test/flutter_test.dart';

import 'package:ai_interview_coach/models/answer_model.dart';
import 'package:ai_interview_coach/models/interview_model.dart';
import 'package:ai_interview_coach/models/question_model.dart';
import 'package:ai_interview_coach/services/local_evaluation_service.dart';

void main() {
  const service = LocalEvaluationService();
  const interview = InterviewModel(
    role: 'Software Developer',
    type: 'Technical Interview',
    difficulty: 'Medium',
    questions: [QuestionModel(id: 'q1', text: 'Tell me about yourself.')],
  );

  test('calculates local answer metrics', () {
    const answer = AnswerModel(
      questionId: 'q1',
      text: 'Um, I build reliable software and actually enjoy solving problems.',
      duration: Duration(seconds: 30),
    );

    expect(service.wordCount(answer.text), 10);
    expect(service.fillerWordCount(answer.text), 2);
    expect(service.speakingSpeed(answer), 20);
  });

  test('creates an evaluation for every interview question', () {
    final evaluations = service.evaluateInterview(interview, const []);

    expect(evaluations, hasLength(1));
    expect(evaluations.single.overallScore, 0);
  });
}
