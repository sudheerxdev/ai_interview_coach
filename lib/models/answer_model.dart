class AnswerModel {
	const AnswerModel({
		required this.questionId,
		required this.text,
		required this.duration,
	});

	final String questionId;
	final String text;
	final Duration duration;
}
