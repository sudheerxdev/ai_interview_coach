import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
	const QuestionWidget({
		super.key,
		required this.questionNumber,
		required this.totalQuestions,
		required this.question,
	});

	final int questionNumber;
	final int totalQuestions;
	final String question;

	@override
	Widget build(BuildContext context) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Text(
					'Question $questionNumber of $totalQuestions',
					style: Theme.of(context).textTheme.labelLarge,
				),
				const SizedBox(height: 12),
				LinearProgressIndicator(value: questionNumber / totalQuestions),
				const SizedBox(height: 24),
				Text(
					question,
					style: Theme.of(context).textTheme.headlineSmall,
				),
			],
		);
	}
}
