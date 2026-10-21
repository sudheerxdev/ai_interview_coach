class EvaluationModel {
	const EvaluationModel({
		required this.overallScore,
		required this.relevance,
		required this.clarity,
		required this.grammar,
		required this.completeness,
		required this.feedback,
	});

	final int overallScore;
	final int relevance;
	final int clarity;
	final int grammar;
	final int completeness;
	final String feedback;
}
