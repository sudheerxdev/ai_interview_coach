import '../core/services/audio_service.dart';

class SpeechService {
	SpeechService({AudioService? audioService})
		: _audioService = audioService ?? AudioService();

	final AudioService _audioService;

	bool get isListening => _audioService.isListening;

	Future<bool> initialize({
		required void Function(String status) onStatus,
		required void Function(String message, bool permanent) onError,
	}) {
		return _audioService.initialize(onStatus: onStatus, onError: onError);
	}

	Future<void> startListening({
		required void Function(String transcript) onResult,
	}) {
		return _audioService.startListening(onResult: onResult);
	}

	Future<void> stopListening() => _audioService.stopListening();

	Future<void> cancelListening() => _audioService.cancelListening();
}
