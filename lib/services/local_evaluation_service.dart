import '../models/answer_model.dart';
import '../models/evaluation_model.dart';
import '../models/interview_model.dart';

class LocalEvaluationService {
  const LocalEvaluationService();

  List<EvaluationModel> evaluateInterview(
    InterviewModel interview,
    List<AnswerModel> answers,
  ) {
    return interview.questions.map((question) {
      final answer = answers.cast<AnswerModel?>().firstWhere(
        (item) => item?.questionId == question.id,
        orElse: () => null,
      );
      return evaluateAnswer(question.text, answer);
    }).toList();
  }

  EvaluationModel evaluateAnswer(String question, AnswerModel? answer) {
    final text = answer?.text.trim() ?? '';
    final wordCount = _wordCount(text);
    final hasAnswer = wordCount > 0;
    final relevance = hasAnswer ? 78 : 0;
    final clarity = hasAnswer ? (wordCount >= 12 ? 82 : 68) : 0;
    final grammar = hasAnswer ? 80 : 0;
    final completeness = hasAnswer ? (wordCount >= 25 ? 84 : 70) : 0;
    final overall = hasAnswer
        ? ((relevance + clarity + grammar + completeness) / 4).round()
        : 0;

    return EvaluationModel(
      overallScore: overall,
      relevance: relevance,
      clarity: clarity,
      grammar: grammar,
      completeness: completeness,
      feedback: hasAnswer
          ? 'Your answer was relevant. Add a specific example and outcome to make it stronger.'
          : 'No answer was recorded for this question.',
    );
  }

  int wordCount(String text) => _wordCount(text);

  int fillerWordCount(String text) {
    final words = _words(text);
    return words.where((word) => const {'um', 'uh', 'actually', 'like'}
        .contains(word)).length;
  }

  int speakingSpeed(AnswerModel answer) {
    final seconds = answer.duration.inSeconds;
    if (seconds == 0) return 0;
    return ((_wordCount(answer.text) / seconds) * 60).round();
  }

  int _wordCount(String text) => _words(text).length;

  List<String> _words(String text) => text
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .toList();
}