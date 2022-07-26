import 'package:flutter/material.dart';
import 'package:jarvis000/data/languages_list.dart';
import 'package:jarvis000/models/language.dart';
import 'package:jarvis000/models/text_speech.dart';
import 'package:jarvis000/widgets/language_item.dart';

class LanguageDialog extends StatefulWidget {
  static const DESCRIPTION = "Please, swipe left or right to choose language.";
  TextSpeech _textSpeech;
  LanguageDialog({required TextSpeech textSpeech}) : _textSpeech = textSpeech;
  @override
  State<LanguageDialog> createState() => LanguageDialogState();
}

class LanguageDialogState extends State<LanguageDialog> {
  int index = 0;
  late Widget currentLanguage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _describePage();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Dismissible(
          key: UniqueKey(),
          onDismissed: (dircetion) {
            _updateIndex(direction: dircetion);
            _stopSpeaking();
            widget._textSpeech.speak(text: LANGUAGES_LIST[index].name);
          },
          child: LanguageItem(
            onTap: _popThisDialog,
            language: LANGUAGES_LIST[index],
          )),
    );
  }

  _popThisDialog(Language languageAprv) {
    Navigator.of(context).pop(languageAprv);
  }

  _updateIndex({required DismissDirection direction}) {
    setState(() {
      if (direction == DismissDirection.startToEnd) {
        if (index < LANGUAGES_LIST.length - 1) {
          index++;
        } else {
          index = 0;
        }
      } else {
        if (index > 0) {
          index--;
        } else {
          index = LANGUAGES_LIST.length - 1;
        }
      }
      print("the Index is ${index}");
    });
  }

  void _describePage() {
    _stopSpeaking();
    widget._textSpeech.speak(text: LanguageDialog.DESCRIPTION);
  }

  void _stopSpeaking() {
    if (widget._textSpeech.state == SpeechState.playing) {
      widget._textSpeech.stop();
    }
  }
}
