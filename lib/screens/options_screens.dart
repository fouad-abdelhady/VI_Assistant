import 'package:flutter/material.dart';
import 'package:jarvis000/models/text_speech.dart';
import 'package:jarvis000/screens/result_screen.dart';
import 'package:jarvis000/screens/speech_text_screen.dart';
import 'package:jarvis000/widgets/app_scaffold.dart';
import 'package:jarvis000/widgets/dialog.dart';
import 'package:jarvis000/widgets/option_item.dart';
import 'package:provider/provider.dart';
import '../models/language.dart';
import '../providers/languages.dart';
import 'image_scan_screen.dart';

class OptionsScreen extends StatelessWidget {
  static const OPTIONS_SCREEN_ROUTE = '/optionsScreen';
  static const TEXT_TO_SPEECH_LABEL = "Speech To Text";
  static const SCAN_TEXT = "Scan Text";
  static const COLOR_1 = Color.fromARGB(255, 187, 153, 1);
  static const COLOR_2 = Color.fromARGB(255, 173, 129, 6);

  late TextSpeech _textSpeech;
  @override
  Widget build(BuildContext context) {
    _setSpeechSettings();
    _describePage(text: DESCRIPTION);
    return GestureDetector(
      onLongPress: () {
        _describePage(text: DESCRIPTION);
      },
      child: AppScaffold(
        appBarTitle: "Options",
        screenBody: _getScreenBody(context: context),
      ),
    );
  }

  Widget _getScreenBody({required BuildContext context}) => Column(
        children: [
          OptionItem(
              color1: COLOR_1,
              color2: COLOR_2,
              label: TEXT_TO_SPEECH_LABEL,
              icon: Icons.speaker_notes_outlined,
              onPressed: moveToTextToSpeechScreen),
          OptionItem(
              color1: COLOR_2,
              color2: COLOR_1,
              label: SCAN_TEXT,
              icon: Icons.document_scanner_outlined,
              onPressed: moveToImageScanScreen),
        ],
      );
  moveToImageScanScreen({required BuildContext context}) async {
    _stopSpeaking();
    Language language = await showDialog(
        context: context,
        builder: (context) => LanguageDialog(textSpeech: _textSpeech),
        barrierDismissible: false) as Language;

    Provider.of<Languages>(context, listen: false)
        .setCurrentLanguage(language.languageAprv, language.languageSpeechAprv);

    Navigator.of(context)
        .pushNamed(ImageScan.IMAGE_SCAN_SCREEN_ROUTE, arguments: language);
  }

  moveToTextToSpeechScreen({required BuildContext context}) {
    _stopSpeaking();
    Navigator.of(context)
        .pushNamed(SpeechToTextScreen.SPEECH_TEXT_SCREEN_ROUTE);
  }

  void _describePage({required String text}) {
    _stopSpeaking();
    _textSpeech.speak(text: DESCRIPTION);
  }

  void _setSpeechSettings() {
    // just for setting the speech object
    _textSpeech = TextSpeech.getInstance(
        setPageState: () {}, language: Languages.ENGLISH_APRV2);
    _textSpeech.initTts();
  }

  void _stopSpeaking() {
    if (_textSpeech.state == SpeechState.playing) {
      _textSpeech.stop();
    }
  }

  static const String DESCRIPTION =
      "You are now in options screen. For speech to text tap on the top section of the screen. To scan text from image tap on the lower section. Long press to display this message again.";
}
