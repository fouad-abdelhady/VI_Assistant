import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechText {
  static SpeechText? _speechText;

  late SpeechToText _speechToText;
  late void Function(SpeechRecognitionResult) onResult;

  SpeechText._internal({required this.onResult}) {
    _speechToText = SpeechToText();
  }

  static getInstance(
      {required void Function(SpeechRecognitionResult) onResult}) {
    _speechText ??= SpeechText._internal(onResult: onResult);
    return _speechText;
  }

  Future<bool> initializeSpeech() async {
    bool state = false;
    try {
      state = await _speechToText.initialize();
    } catch (e) {
      return state;
    }
    return state;
  }

  void listen({required isActive}) {
    if (isActive) {
      _stopListening();
    } else {
      _startListening();
    }
  }

  void _startListening() async {
    await _speechToText.listen(onResult: onResult);
  }

  void _stopListening() async {
    await _speechToText.stop();
  }
}
