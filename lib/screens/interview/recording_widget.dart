import 'package:flutter/material.dart';

import '../../providers/recording_provider.dart';

class RecordingWidget extends StatelessWidget {
	const RecordingWidget({
		super.key,
		required this.controller,
		required this.recordingProvider,
	});

	final TextEditingController controller;
	final RecordingProvider recordingProvider;

	@override
	Widget build(BuildContext context) {
		return AnimatedBuilder(
			animation: recordingProvider,
			builder: (context, child) {
				if (controller.text != recordingProvider.transcript &&
					recordingProvider.transcript.isNotEmpty) {
					controller.value = controller.value.copyWith(
						text: recordingProvider.transcript,
						selection: TextSelection.collapsed(
							offset: recordingProvider.transcript.length,
						),
					);
				}

				return Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						TextField(
							controller: controller,
							minLines: 5,
							maxLines: 8,
							textInputAction: TextInputAction.newline,
							decoration: const InputDecoration(
								alignLabelWithHint: true,
								labelText: 'Your answer',
								hintText: 'Type or dictate your answer...',
								prefixIcon: Padding(
									padding: EdgeInsets.only(bottom: 96),
									child: Icon(Icons.edit_note_rounded),
								),
							),
						),
						const SizedBox(height: 12),
						Row(
							children: [
								Expanded(
									child: FilledButton.icon(
										onPressed: recordingProvider.isListening
											? recordingProvider.stopRecording
											: recordingProvider.startRecording,
										icon: Icon(
											recordingProvider.isListening
												? Icons.stop_rounded
												: Icons.mic_rounded,
										),
										label: Text(
											recordingProvider.isListening
												? 'Stop Recording'
												: 'Start Recording',
										),
									),
								),
								if (recordingProvider.transcript.isNotEmpty) ...[
									const SizedBox(width: 8),
									IconButton(
										onPressed: recordingProvider.retryRecording,
										tooltip: 'Retry recording',
										icon: const Icon(Icons.refresh_rounded),
									),
								],
							],
						),
							if (recordingProvider.isListening)
								Padding(
									padding: const EdgeInsets.only(top: 8),
									child: Align(
										alignment: Alignment.centerLeft,
										child: Chip(
											avatar: const Icon(Icons.mic_rounded, size: 16),
											label: Text(
												'Recording ${_formatDuration(recordingProvider.recordingDuration)}',
											),
										),
									),
								),
						if (recordingProvider.isListening)
							const Padding(
								padding: EdgeInsets.only(top: 8),
								child: Text('Listening... speak clearly into the microphone.'),
							),
						if (recordingProvider.errorMessage != null)
							Padding(
								padding: const EdgeInsets.only(top: 8),
								child: Text(
									recordingProvider.errorMessage!,
									style: TextStyle(
										color: Theme.of(context).colorScheme.error,
									),
								),
							),
					],
				);
			},
		);
	}

	String _formatDuration(Duration duration) {
		final minutes = duration.inMinutes.toString().padLeft(2, '0');
		final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
		return '$minutes:$seconds';
	}
}
