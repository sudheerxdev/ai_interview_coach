import '../config/supabase_config.dart';
import '../models/answer_model.dart';
import '../models/evaluation_model.dart';
import '../models/interview_history_model.dart';

class InterviewHistoryService {
  const InterviewHistoryService();

  Future<List<InterviewHistoryModel>> loadHistory() async {
    if (SupabaseConfig.isConfigured && SupabaseConfig.client.auth.currentUser != null) {
      try {
        final response = await SupabaseConfig.client
            .from('interviews')
            .select('id, role, interview_type, difficulty, overall_score, created_at, questions(id, question_order, question_text, answers(id, answer_text, duration_seconds, evaluations(overall_score, relevance, clarity, grammar, completeness, feedback)))')
            .order('created_at', ascending: false);
        return _mapRows(response);
      } catch (_) {
        return _mockHistory;
      }
    }

    return _mockHistory;
  }

  Future<InterviewHistoryModel?> loadInterview(String id) async {
    final history = await loadHistory();
    for (final interview in history) {
      if (interview.id == id) return interview;
    }
    return null;
  }

  List<InterviewHistoryModel> _mapRows(List<dynamic> rows) {
    return rows.map((row) {
      final data = Map<String, dynamic>.from(row as Map);
      final questions = (data['questions'] as List<dynamic>? ?? [])
          .map(_mapQuestion)
          .toList();
      return InterviewHistoryModel(
        id: data['id'] as String,
        role: data['role'] as String? ?? 'Interview',
        type: data['interview_type'] as String? ?? 'Mixed Interview',
        difficulty: data['difficulty'] as String? ?? 'Medium',
        score: data['overall_score'] as int? ?? 0,
        createdAt: DateTime.tryParse(data['created_at'] as String? ?? '') ?? DateTime.now(),
        questions: questions,
      );
    }).toList();
  }

  InterviewHistoryQuestion _mapQuestion(dynamic row) {
    final data = Map<String, dynamic>.from(row as Map);
    final answers = data['answers'] as List<dynamic>? ?? [];
    final answerData = answers.isEmpty
        ? null
        : Map<String, dynamic>.from(answers.first as Map);
    final evaluationRows = answerData?['evaluations'] as List<dynamic>? ?? [];
    final evaluationData = evaluationRows.isEmpty
        ? null
        : Map<String, dynamic>.from(evaluationRows.first as Map);

    return InterviewHistoryQuestion(
      question: data['question_text'] as String? ?? '',
      answer: answerData == null
          ? null
          : AnswerModel(
              questionId: data['id'] as String,
              text: answerData['answer_text'] as String? ?? '',
              duration: Duration(
                seconds: answerData['duration_seconds'] as int? ?? 0,
              ),
            ),
      evaluation: evaluationData == null
          ? null
          : EvaluationModel(
              overallScore: evaluationData['overall_score'] as int? ?? 0,
              relevance: evaluationData['relevance'] as int? ?? 0,
              clarity: evaluationData['clarity'] as int? ?? 0,
              grammar: evaluationData['grammar'] as int? ?? 0,
              completeness: evaluationData['completeness'] as int? ?? 0,
              feedback: evaluationData['feedback'] as String? ?? '',
            ),
    );
  }

  static final _mockHistory = [
    InterviewHistoryModel(
      id: 'mock-customer-support',
      role: 'Customer Support',
      type: 'HR Interview',
      difficulty: 'Medium',
      score: 82,
      createdAt: DateTime(2026, 9, 17),
      questions: _mockQuestions,
    ),
    InterviewHistoryModel(
      id: 'mock-technical-support',
      role: 'Technical Support',
      type: 'Technical Interview',
      difficulty: 'Hard',
      score: 76,
      createdAt: DateTime(2026, 9, 12),
      questions: _mockQuestions,
    ),
    InterviewHistoryModel(
      id: 'mock-banking',
      role: 'Banking',
      type: 'Behavioral Interview',
      difficulty: 'Easy',
      score: 88,
      createdAt: DateTime(2026, 9, 5),
      questions: _mockQuestions,
    ),
  ];

  static const _mockQuestions = [
    InterviewHistoryQuestion(
      question: 'Tell me about yourself.',
      answer: AnswerModel(
        questionId: 'mock-question-1',
        text: 'I am a motivated professional who enjoys helping people solve problems.',
        duration: Duration(seconds: 28),
      ),
      evaluation: EvaluationModel(
        overallScore: 82,
        relevance: 88,
        clarity: 81,
        grammar: 79,
        completeness: 80,
        feedback: 'Clear and relevant. Add one measurable result for more impact.',
      ),
    ),
    InterviewHistoryQuestion(
      question: 'Why should we hire you?',
      answer: AnswerModel(
        questionId: 'mock-question-2',
        text: 'I bring patience, structured communication, and a strong focus on outcomes.',
        duration: Duration(seconds: 24),
      ),
      evaluation: EvaluationModel(
        overallScore: 82,
        relevance: 82,
        clarity: 83,
        grammar: 81,
        completeness: 79,
        feedback: 'Good strengths. Connect them to a specific example from your experience.',
      ),
    ),
  ];
}