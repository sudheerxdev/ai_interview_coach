import 'dart:async';

import 'package:flutter/foundation.dart';

import '../services/speech_service.dart';

enum RecordingState { idle, listening, stopped, error }

class RecordingProvider extends ChangeNotifier {
	RecordingProvider({SpeechService? speechService})
		: _speechService = speechService ?? SpeechService();

	final SpeechService _speechService;

	RecordingState state = RecordingState.idle;
	String transcript = '';
	String? errorMessage;
	bool isAvailable = false;
	Duration recordingDuration = Duration.zero;
	Timer? _recordingTimer;

	bool get isListening => state == RecordingState.listening;

	Future<void> initialize() async {
		isAvailable = await _speechService.initialize(
			onStatus: _handleStatus,
			onError: _handleError,
		);
		if (!isAvailable) {
			state = RecordingState.error;
			errorMessage = 'Speech recognition is unavailable on this device.';
			notifyListeners();
		}
	}

	Future<void> startRecording() async {
		if (!isAvailable) {
			state = RecordingState.error;
			errorMessage = 'Microphone permission was denied or unavailable.';
			notifyListeners();
			return;
		}

		transcript = '';
		errorMessage = null;
		recordingDuration = Duration.zero;
		state = RecordingState.listening;
		notifyListeners();

		_recordingTimer?.cancel();
		_recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
			recordingDuration += const Duration(seconds: 1);
			notifyListeners();
		});

		await _speechService.startListening(onResult: _handleResult);
	}

	Future<void> stopRecording() async {
		await _speechService.stopListening();
		_recordingTimer?.cancel();
		_recordingTimer = null;
		if (state == RecordingState.listening) {
			state = transcript.trim().isEmpty
					? RecordingState.error
					: RecordingState.stopped;
			errorMessage = transcript.trim().isEmpty
					? 'No speech was detected. Try recording again.'
					: null;
			notifyListeners();
		}
	}

	Future<void> retryRecording() async {
		await _speechService.cancelListening();
		_recordingTimer?.cancel();
		_recordingTimer = null;
		transcript = '';
		errorMessage = null;
		state = RecordingState.idle;
		notifyListeners();
	}

	@override
	void dispose() {
		_recordingTimer?.cancel();
		_speechService.cancelListening();
		super.dispose();
	}

	void _handleResult(String value) {
		transcript = value;
		notifyListeners();
	}

	void _handleStatus(String status) {
		if (status == 'done' && state == RecordingState.listening) {
			state = transcript.trim().isEmpty
					? RecordingState.error
					: RecordingState.stopped;
			errorMessage = transcript.trim().isEmpty
					? 'No speech was detected. Try recording again.'
					: null;
			notifyListeners();
		}
	}

	void _handleError(String message, bool permanent) {
		state = RecordingState.error;
		errorMessage = permanent
				? 'Microphone or speech permission was denied.'
				: message;
		notifyListeners();
	}
}
