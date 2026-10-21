import 'answer_model.dart';
import 'evaluation_model.dart';

class InterviewHistoryModel {
  const InterviewHistoryModel({
    required this.id,
    required this.role,
    required this.type,
    required this.difficulty,
    required this.score,
    required this.createdAt,
    required this.questions,
  });

  final String id;
  final String role;
  final String type;
  final String difficulty;
  final int score;
  final DateTime createdAt;
  final List<InterviewHistoryQuestion> questions;
}

class InterviewHistoryQuestion {
  const InterviewHistoryQuestion({
    required this.question,
    required this.answer,
    required this.evaluation,
  });

  final String question;
  final AnswerModel? answer;
  final EvaluationModel? evaluation;
}