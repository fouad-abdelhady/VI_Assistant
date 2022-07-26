import 'package:flutter_tts/flutter_tts.dart';
import 'package:jarvis000/providers/languages.dart';

enum SpeechState { ready, playing, stopped }

class TextSpeech {
  static const _ERROR =
      "Error occured, I believe there something wrong in the result.";
  static const _PITCH = 0.7;
  static const _SPEED = 0.5;
  static TextSpeech? _textSpeech;

  late FlutterTts _flutterTts;
  late SpeechState state;

  String _language;
  Function _setPageState;
  Function? _onSpeakingDone;

  TextSpeech._intetnal(
      {required Function setPageState,
      required String language,
      Function? onSpeakingDone})
      : _setPageState = setPageState,
        _language = language,
        _onSpeakingDone = onSpeakingDone;

  static getInstance(
      {required Function setPageState,
      required String language,
      Function? onSpeakingDone}) {
    _textSpeech ??= TextSpeech._intetnal(
        setPageState: setPageState,
        language: language,
        onSpeakingDone: onSpeakingDone);
    return _textSpeech;
  }

  void initTts() async {
    _flutterTts = FlutterTts();
    state = SpeechState.ready;

    _flutterTts.setStartHandler(() {
      state = SpeechState.playing;
      _setPageState();
    });

    _flutterTts.setCompletionHandler(() {
      state = SpeechState.stopped;
      print("I am here _flutterTts.setCompletionHandler");
      _onSpeakingDone!();
    });

    _flutterTts.setErrorHandler((message) {
      state = SpeechState.stopped;
    });
  }

  set language(String language) {
    _language = language;
  }

  String get language => _language;

  void speak({required String text}) async {
    try {
      await _flutterTts.setLanguage(_language);
      await _flutterTts.setPitch(_PITCH);
      await _flutterTts.setSpeechRate(_SPEED);
      await _flutterTts.speak(text);
    } catch (e) {
      await _flutterTts.setLanguage(Languages.ENGLISH_APRV2);
      await _flutterTts.setPitch(_PITCH);
      await _flutterTts.setSpeechRate(_SPEED);
      await _flutterTts.speak(text);
    }
  }

  void stop() async {
    await _flutterTts.stop();
  }
}
