// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:jarvis000/models/speech_text.dart';
import 'package:jarvis000/models/text_speech.dart';
import 'package:jarvis000/widgets/app_scaffold.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../providers/languages.dart';
import '../widgets/glowing_button.dart';

class SpeechToTextScreen extends StatefulWidget {
  static const SPEECH_TEXT_SCREEN_ROUTE = "/speechToTextScreen";
  static const ERROR_MESSAGE =
      "Unfortunatly, Your device may not support Voice Recognition.";

  SpeechToTextScreen({Key? key}) : super(key: key);

  @override
  State<SpeechToTextScreen> createState() => _SpeechToTextState();
}

class _SpeechToTextState extends State<SpeechToTextScreen> {
  late double screenHeight;
  // late SpeechText speechTextObj;

  late double screenWidth;
  late SpeechToText _speechToText;
  late SpeechText speechTextObj;
  late TextSpeech _textSpeech;
  var isListining = false;
  var isReading = false;
  var isSpeechReady = false;

  var recognizedText = "";

  @override
  void initState() {
    super.initState();
    setSpeechSettings();
    _setSpeechSettings();
    _describePage();
  }

  void setSpeechSettings() async {
    speechTextObj = SpeechText.getInstance(onResult: onResult);
    isSpeechReady = await speechTextObj.initializeSpeech();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top;
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: 'Speech to Text',
      screenBody: Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            _stopSpeaking();
            Navigator.of(context).pop();
          },
          child: screenBody(context: context)),
    );
  }

  screenBody({required BuildContext context}) => Stack(
        children: [
          isSpeechReady
              ? SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Text(
                        recognizedText,
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 25),
                        softWrap: true,
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text(
                  SpeechToTextScreen.ERROR_MESSAGE,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Color.fromARGB(255, 245, 186, 76)),
                )),
          isSpeechReady
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      if (!isListining)
                        Expanded(
                          child: GlowingItem(
                            onTap: () {
                              if (!isReading) {
                                _stopSpeaking();
                                if (recognizedText.isEmpty) {
                                  _textSpeech.speak(text: "No result  yet");
                                } else {
                                  _textSpeech.speak(text: recognizedText);
                                }
                              }
                              setState(() {
                                isReading = !isReading;
                              });
                            },
                            inAction: isReading,
                            screenWidth: screenWidth,
                            icon: Icons.volume_up_outlined,
                            tappedIcon: Icons.volume_up,
                            effectColor: Color.fromARGB(129, 213, 125, 228),
                          ),
                        ),
                      if (!isReading)
                        Expanded(
                          child: GlowingItem(
                            inAction: isListining,
                            screenWidth: screenWidth,
                            icon: Icons.mic_none,
                            tappedIcon: Icons.mic,
                            effectColor: Color.fromARGB(120, 255, 193, 7),
                            onTap: () {
                              if (!isListining) {
                                _stopSpeaking();
                                _textSpeech.speak(text: "talk now");
                              }
                              if (isSpeechReady) {
                                setState(() {
                                  speechTextObj.listen(isActive: isListining);
                                  isListining = !isListining;
                                });
                              } else {
                                setState(() {
                                  recognizedText =
                                      SpeechToTextScreen.ERROR_MESSAGE;
                                });
                              }
                            },
                          ),
                        ),
                    ])
              : SizedBox()
        ],
      );

  void onResult(SpeechRecognitionResult result) {
    setState(() {
      recognizedText = result.recognizedWords;
    });
  }

  void _describePage() {
    _stopSpeaking();
    if (isSpeechReady)
      _textSpeech.speak(text: DESCRIPTION);
    else
      _textSpeech.speak(text: SpeechToTextScreen.ERROR_MESSAGE);
  }

  void _setSpeechSettings() {
    _textSpeech = TextSpeech.getInstance(
        setPageState: () {},
        language: Languages.ENGLISH_APRV2,
        onSpeakingDone: _onReadingDone);
    _textSpeech.initTts();
  }

  void _stopSpeaking() {
    if (_textSpeech.state == SpeechState.playing) {
      _textSpeech.stop();
    }
  }

  _onReadingDone() {
    setState(() {
      print("I am here  _onReadingDone()");
      isReading = false;
    });
  }

  static const DESCRIPTION =
      "You are now in Speech to Text screen. Press on the bottom section and talk. When you done talking press anywere in the screen to stop recording. press on the top section of the screen to hear the recoginzed text. ";
}
