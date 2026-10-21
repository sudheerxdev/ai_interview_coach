import '../models/answer_model.dart';
import '../models/evaluation_model.dart';
import '../models/question_model.dart';

/// Provider-agnostic contract for interview intelligence.
///
/// A future backend implementation can call a Supabase Edge Function, while
/// the rest of the Flutter application continues to depend on this API.
abstract interface class AiService {
	Future<QuestionModel> generateInterviewQuestion({
		required String role,
		required String interviewType,
		required String difficulty,
		List<String> previousQuestions,
		String resumeContext,
		String jobDescriptionContext,
	});

	Future<EvaluationModel> evaluateAnswer({
		required String question,
		required AnswerModel answer,
		required String role,
	});

	Future<String> generateFeedback({
		required List<EvaluationModel> evaluations,
	});

	Future<String> analyzeResume(String resumeText);

	Future<String> analyzeJobDescription(String jobDescription);
}

/// Offline implementation used until the backend phase is introduced.
class LocalMockAiService implements AiService {
	const LocalMockAiService();

	@override
	Future<QuestionModel> generateInterviewQuestion({
		required String role,
		required String interviewType,
		required String difficulty,
		List<String> previousQuestions = const [],
		String resumeContext = '',
		String jobDescriptionContext = '',
	}) async {
		const fallbackQuestions = [
			'What strengths would you bring to this role?',
			'How do you approach learning something new?',
			'What would you like to accomplish in your first 90 days?',
		];
		final personalizedQuestion = resumeContext.isNotEmpty
			? 'Which experience from your resume best prepares you for this role?'
			: jobDescriptionContext.isNotEmpty
				? 'Which requirement in this job description would you address first, and why?'
				: null;
		final nextQuestion = fallbackQuestions.firstWhere(
			(question) => !previousQuestions.contains(question),
			orElse: () => personalizedQuestion ?? fallbackQuestions.first,
		);

		return QuestionModel(
			id: 'local-${previousQuestions.length + 1}',
			text: nextQuestion,
		);
	}

	@override
	Future<EvaluationModel> evaluateAnswer({
		required String question,
		required AnswerModel answer,
		required String role,
	}) async {
		final hasContent = answer.text.trim().isNotEmpty;
		final score = hasContent ? 70 : 0;

		return EvaluationModel(
			overallScore: score,
			relevance: score,
			clarity: score,
			grammar: score,
			completeness: score,
			feedback: hasContent
					? 'Your answer has been saved for future AI evaluation.'
					: 'Add an answer so it can be evaluated.',
		);
	}

	@override
	Future<String> generateFeedback({
		required List<EvaluationModel> evaluations,
	}) async {
		return 'Detailed AI feedback will be available after the secure backend is connected.';
	}

	@override
	Future<String> analyzeResume(String resumeText) async {
		return 'Resume analysis is reserved for the backend integration phase.';
	}

	@override
	Future<String> analyzeJobDescription(String jobDescription) async {
		return 'Job-description analysis is reserved for the backend integration phase.';
	}
}
