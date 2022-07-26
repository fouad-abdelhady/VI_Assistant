import 'package:flutter/material.dart';
import 'package:jarvis000/models/text_speech.dart';
import 'package:jarvis000/screens/result_screen.dart';
import 'package:jarvis000/widgets/app_scaffold.dart';
import 'package:jarvis000/widgets/option_item.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/languages.dart';

class ImageScan extends StatelessWidget {
  static const IMAGE_SCAN_SCREEN_ROUTE = '/imageScan';
  static const CAMERA = "Camera";
  static const PICK = "Pick Image";
  static const COLOR_1 = Color.fromARGB(255, 187, 153, 1);
  static const COLOR_2 = Color.fromARGB(255, 173, 129, 6);

  late TextSpeech _textSpeech;
  @override
  Widget build(BuildContext context) {
    _setSpeechSettings();
    _describePage(text: DESCRIPTION);
    return GestureDetector(
      onLongPress: () {
        _stopSpeaking();
        _describePage(text: DESCRIPTION);
      },
      child: AppScaffold(
          appBarTitle: 'Image Scan', screenBody: getBody(context: context)),
    );
  }

  getBody({required BuildContext context}) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        _stopSpeaking();
        Navigator.of(context).pop();
      },
      child: Column(
        children: [
          OptionItem(
              color1: COLOR_1,
              color2: COLOR_2,
              label: CAMERA,
              icon: Icons.camera_alt_outlined,
              onPressed: onUseCameraPressed),
          OptionItem(
              color1: COLOR_2,
              color2: COLOR_1,
              label: PICK,
              icon: Icons.sd_storage_outlined,
              onPressed: onSelectFromStorgePressed)
        ],
      ),
    );
  }

  onUseCameraPressed({required BuildContext context}) async {
    _stopSpeaking();
    final capturedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (capturedImage != null) {
      Navigator.of(context)
          .pushNamed(Result.RESULT_SCREEN_ROUTE, arguments: capturedImage.path);
    }
  }

  onSelectFromStorgePressed({required BuildContext context}) async {
    _stopSpeaking();
    final capturedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (capturedImage != null) {
      Navigator.of(context)
          .pushNamed(Result.RESULT_SCREEN_ROUTE, arguments: capturedImage.path);
    }
  }

  void _describePage({required String text}) {
    _textSpeech.speak(text: DESCRIPTION);
  }

  void _setSpeechSettings() {
    _textSpeech = TextSpeech.getInstance(
      setPageState: () {},
      language: Languages.ENGLISH_APRV2,
    );
    _textSpeech.initTts();
  }

  void _stopSpeaking() {
    if (_textSpeech.state == SpeechState.playing) {
      _textSpeech.stop();
    }
  }

  static const String DESCRIPTION =
      "You are now in image scan screen. To capture image tap on the top section of the screen. To pick image tap on the lower section. To go back to the previous screen swip left or right. To display this message again long press on your screen.";
}
