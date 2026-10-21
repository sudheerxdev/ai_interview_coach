import 'package:speech_to_text/speech_to_text.dart' as stt;

class AudioService {
	AudioService({stt.SpeechToText? speech}) : _speech = speech ?? stt.SpeechToText();

	final stt.SpeechToText _speech;

	bool get isListening => _speech.isListening;

	Future<bool> initialize({
		required void Function(String status) onStatus,
		required void Function(String message, bool permanent) onError,
	}) {
		return _speech.initialize(
			onStatus: onStatus,
			onError: (error) => onError(error.errorMsg, error.permanent),
		);
	}

	Future<void> startListening({
		required void Function(String transcript) onResult,
	}) {
		return _speech.listen(
			onResult: (result) => onResult(result.recognizedWords),
			listenOptions: stt.SpeechListenOptions(
				partialResults: true,
				cancelOnError: true,
				listenMode: stt.ListenMode.dictation,
			),
		);
	}

	Future<void> stopListening() => _speech.stop();

	Future<void> cancelListening() => _speech.cancel();
}
