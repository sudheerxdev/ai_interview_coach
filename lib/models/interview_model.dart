import 'question_model.dart';

class InterviewModel {
	const InterviewModel({
		required this.role,
		required this.type,
		required this.difficulty,
		required this.questions,
	});

	final String role;
	final String type;
	final String difficulty;
	final List<QuestionModel> questions;
}
