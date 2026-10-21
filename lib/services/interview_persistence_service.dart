import '../config/supabase_config.dart';
import '../models/answer_model.dart';
import '../models/evaluation_model.dart';
import '../models/interview_model.dart';

class InterviewPersistenceService {
  const InterviewPersistenceService();

  Future<InterviewPersistenceSession?> startInterview(
    InterviewModel interview,
  ) async {
    if (!_isAvailable) return null;

    try {
      final client = SupabaseConfig.client;
      final user = client.auth.currentUser!;
      final interviewRow = await client
          .from('interviews')
          .insert({
            'user_id': user.id,
            'role': interview.role,
            'interview_type': interview.type,
            'difficulty': interview.difficulty,
            'status': 'in_progress',
          })
          .select('id')
          .single();

      final interviewId = interviewRow['id'] as String;
      final questionRows = await client
          .from('questions')
          .insert([
            for (var index = 0; index < interview.questions.length; index++)
              {
                'interview_id': interviewId,
                'question_order': index + 1,
                'question_text': interview.questions[index].text,
              },
          ])
          .select('id, question_order');

      final questionIds = <String, String>{};
      for (final row in questionRows) {
        final order = row['question_order'] as int;
        questionIds[interview.questions[order - 1].id] = row['id'] as String;
      }

      return InterviewPersistenceSession(
        interviewId: interviewId,
        questionIds: questionIds,
      );
    } catch (error) {
      _log('Could not create interview in Supabase: $error');
      return null;
    }
  }

  Future<String?> saveAnswer({
    required InterviewPersistenceSession session,
    required AnswerModel answer,
  }) async {
    final databaseQuestionId = session.questionIds[answer.questionId];
    if (!_isAvailable || databaseQuestionId == null) return null;

    try {
      final client = SupabaseConfig.client;
      final row = await client
          .from('answers')
          .insert({
            'question_id': databaseQuestionId,
            'user_id': client.auth.currentUser!.id,
            'answer_text': answer.text,
            'transcript': answer.text,
            'duration_seconds': answer.duration.inSeconds,
            'word_count': _wordCount(answer.text),
          })
          .select('id')
          .single();
      session.answerIds[answer.questionId] = row['id'] as String;
      return row['id'] as String;
    } catch (error) {
      _log('Could not save answer in Supabase: $error');
      return null;
    }
  }

  Future<void> completeInterview({
    required InterviewPersistenceSession session,
    required InterviewModel interview,
    required List<AnswerModel> answers,
    required List<EvaluationModel> evaluations,
  }) async {
    if (!_isAvailable) return;

    try {
      final client = SupabaseConfig.client;
      for (var index = 0; index < evaluations.length; index++) {
        final answer = answers.cast<AnswerModel?>().firstWhere(
              (item) => item?.questionId == interview.questions[index].id,
              orElse: () => null,
            );
        final answerId = answer == null
            ? null
            : session.answerIds[answer.questionId];
        if (answerId == null) continue;

        final evaluation = evaluations[index];
        await client.from('evaluations').insert({
          'answer_id': answerId,
          'user_id': client.auth.currentUser!.id,
          'overall_score': evaluation.overallScore,
          'relevance': evaluation.relevance,
          'clarity': evaluation.clarity,
          'grammar': evaluation.grammar,
          'completeness': evaluation.completeness,
          'feedback': evaluation.feedback,
        });
      }

      final score = evaluations.isEmpty
          ? 0
          : (evaluations
                        .map((evaluation) => evaluation.overallScore)
                        .reduce((first, second) => first + second) /
                    evaluations.length)
                .round();
      await client.from('interviews').update({
        'status': 'completed',
        'overall_score': score,
        'completed_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('id', session.interviewId);
    } catch (error) {
      _log('Could not complete interview in Supabase: $error');
    }
  }

  bool get _isAvailable =>
      SupabaseConfig.isConfigured &&
      SupabaseConfig.client.auth.currentUser != null;

  int _wordCount(String text) => text
      .trim()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .length;

  void _log(String message) {
    // Persistence is best effort so offline practice remains usable.
    // ignore: avoid_print
    print(message);
  }
}

class InterviewPersistenceSession {
  InterviewPersistenceSession({
    required this.interviewId,
    required this.questionIds,
  });

  final String interviewId;
  final Map<String, String> questionIds;
  final Map<String, String> answerIds = {};
}