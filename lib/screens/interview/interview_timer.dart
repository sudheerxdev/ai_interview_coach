import 'package:flutter/material.dart';

class InterviewTimer extends StatelessWidget {
	const InterviewTimer({super.key, required this.duration});

	final Duration duration;

	@override
	Widget build(BuildContext context) {
		final minutes = duration.inMinutes.toString().padLeft(2, '0');
		final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

		return Chip(
			avatar: const Icon(Icons.timer_outlined, size: 18),
			label: Text('$minutes:$seconds'),
		);
	}
}
