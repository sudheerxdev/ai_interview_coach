import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../models/answer_model.dart';
import '../../providers/interview_provider.dart';
import '../../providers/recording_provider.dart';
import '../../services/interview_persistence_service.dart';
import '../../services/local_evaluation_service.dart';
import 'interview_timer.dart';
import 'question_widget.dart';
import 'recording_widget.dart';

class InterviewScreen extends StatefulWidget {
	const InterviewScreen({
		super.key,
		required this.selectedRole,
		required this.selectedType,
		required this.selectedDifficulty,
	});

	final String selectedRole;
	final String selectedType;
	final String selectedDifficulty;

	@override
	State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
	late final InterviewProvider _provider;
	late final RecordingProvider _recordingProvider;
	late final TextEditingController _answerController;
	late final Stopwatch _questionStopwatch;
	Timer? _timer;
	Duration _elapsed = Duration.zero;
	late final Future<InterviewPersistenceSession?> _persistenceReady;
	bool _isSaving = false;

	@override
	void initState() {
		super.initState();
		_provider = InterviewProvider(
			role: widget.selectedRole,
			type: widget.selectedType,
			difficulty: widget.selectedDifficulty,
		);
		_persistenceReady = const InterviewPersistenceService()
			.startInterview(_provider.interview);
		_recordingProvider = RecordingProvider();
		_recordingProvider.initialize();
		_answerController = TextEditingController();
		_questionStopwatch = Stopwatch()..start();
		_timer = Timer.periodic(const Duration(seconds: 1), (_) {
			if (mounted) {
				setState(() => _elapsed = _provider.elapsed);
			}
		});
	}

	@override
	void dispose() {
		_timer?.cancel();
		_answerController.dispose();
		_provider.dispose();
		_recordingProvider.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		if (_provider.isComplete) {
			return _buildCompleteView(context);
		}

		return Scaffold(
			appBar: AppBar(
				title: const Text('Mock interview'),
				actions: [
					Padding(
						padding: const EdgeInsets.only(right: 12),
						child: InterviewTimer(duration: _elapsed),
					),
				],
			),
			body: ListView(
				padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
				children: [
					Text(
						'${widget.selectedRole} · ${widget.selectedDifficulty}',
						style: Theme.of(context).textTheme.bodyMedium,
					),
					const SizedBox(height: 20),
					QuestionWidget(
						questionNumber: _provider.currentIndex + 1,
						totalQuestions: _provider.interview.questions.length,
						question: _provider.currentQuestion.text,
					),
					const SizedBox(height: 28),
					RecordingWidget(
						controller: _answerController,
						recordingProvider: _recordingProvider,
					),
					const SizedBox(height: 16),
					FilledButton.icon(
						onPressed: _isSaving ? null : _submitAndContinue,
						icon: Icon(
							_provider.isLastQuestion
									? Icons.flag_rounded
									: Icons.arrow_forward_rounded,
						),
						label: Text(
							_provider.isLastQuestion ? 'Finish Interview' : 'Next Question',
						),
					),
					const SizedBox(height: 8),
					TextButton(
						onPressed: _isSaving ? null : _finishWithoutAdvancing,
						child: const Text('Finish now'),
					),
				],
			),
		);
	}

	Widget _buildCompleteView(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Interview complete')),
			body: Center(
				child: Padding(
					padding: const EdgeInsets.all(24),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Icon(
								Icons.check_circle_outline_rounded,
								size: 72,
								color: Theme.of(context).colorScheme.primary,
							),
							const SizedBox(height: 20),
							Text(
								'Nice work.',
								style: Theme.of(context).textTheme.headlineMedium,
							),
							const SizedBox(height: 8),
							Text(
								'${_provider.answers.length} of ${_provider.interview.questions.length} answers saved locally.',
								textAlign: TextAlign.center,
							),
							const SizedBox(height: 24),
							FilledButton(
								onPressed: () => _openResults(context),
								child: const Text('View Results'),
							),
						],
					),
				),
			),
		);
	}

	Future<void> _submitAndContinue() async {
		setState(() => _isSaving = true);
		_provider.submitAnswer(
			_answerController.text,
			_questionStopwatch.elapsed,
		);
		await _saveCurrentAnswer();
		_answerController.clear();
		_questionStopwatch
			..reset()
			..start();
		_provider.moveToNextQuestion();
		if (_provider.isComplete) await _completePersistence();
		if (!mounted) return;
		setState(() => _isSaving = false);
	}

	Future<void> _finishWithoutAdvancing() async {
		setState(() => _isSaving = true);
		if (_answerController.text.trim().isNotEmpty) {
			_provider.submitAnswer(
				_answerController.text,
				_questionStopwatch.elapsed,
			);
			await _saveCurrentAnswer();
		}
		_provider.finish();
		await _completePersistence();
		if (!mounted) return;
		setState(() => _isSaving = false);
	}

	Future<void> _saveCurrentAnswer() async {
		final session = await _persistenceReady;
		if (session == null || _provider.answers.isEmpty) return;
		await const InterviewPersistenceService().saveAnswer(
			session: session,
			answer: _provider.answers.last,
		);
	}

	Future<void> _completePersistence() async {
		final session = await _persistenceReady;
		if (session == null) return;
		final evaluations = const LocalEvaluationService().evaluateInterview(
			_provider.interview,
			_provider.answers,
		);
		await const InterviewPersistenceService().completeInterview(
			session: session,
			interview: _provider.interview,
			answers: _provider.answers,
			evaluations: evaluations,
		);
	}

	void _openResults(BuildContext context) {
		Navigator.pushReplacementNamed(
			context,
			AppRoutes.results,
			arguments: {
				'interview': _provider.interview,
				'answers': List<AnswerModel>.unmodifiable(_provider.answers),
			},
		);
	}
}
