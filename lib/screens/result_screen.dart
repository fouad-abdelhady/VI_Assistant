import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jarvis000/widgets/app_scaffold.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:jarvis000/widgets/glowing_button.dart';
import 'package:provider/provider.dart';
import '../models/text_speech.dart';
import '../providers/languages.dart';

class Result extends StatefulWidget {
  static const COLOR_1 = Color.fromARGB(162, 51, 51, 50);
  static const COLOR_2 = Color.fromARGB(199, 27, 27, 27);
  static const RESULT_SCREEN_ROUTE = "/result";

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late TextSpeech _textSpeech;
  late String currentLang;
  late String cuttentLangAprv;
  bool isProcessingDone = false;
  bool inAction = false;
  String result = "Error Occurred";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    currentLang = Provider.of<Languages>(context).currentLanguage;
    cuttentLangAprv = Provider.of<Languages>(context).currentLanguageAprv2;
    _scanText(imageUrl: ModalRoute.of(context)!.settings.arguments as String);
    _initTts();
    _describePage(text: DESCRIPTION);
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = ModalRoute.of(context)!.settings.arguments as String;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final actualScreenHeight =
        MediaQuery.of(context).size.height - statusBarHeight;
    final actualScreenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onLongPress: () {
        _describePage(text: DESCRIPTION);
      },
      child: AppScaffold(
          appBarTitle: "Result Screen",
          screenBody: Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                _stopSpeaking();
                Navigator.of(context).pop();
              },
              child: isProcessingDone // isProcessingDone? runbody : loading;
                  ? _getBody(
                      context: context,
                      height: actualScreenHeight,
                      width: actualScreenWidth,
                      imagePath: imagePath)
                  : _getLoadingIndicator())),
    );
  }

  _getBody(
          {required BuildContext context,
          required double height,
          required double width,
          required String imagePath}) =>
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: double.infinity,
              height: height,
              //   decoration: _getContainer1Decoration(),
              child: _getImageSection(imagePath: imagePath),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: _getContainer1Decoration(),
                width: width,
                height: height * 0.5,
                child: SingleChildScrollView(
                  child: Center(
                      child: Text(
                    result,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              )),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GlowingItem(
                onTap: () {
                  _stopSpeaking();
                  if (_textSpeech.language != currentLang) {
                    _textSpeech.language = currentLang;
                  }
                  if (!inAction) _textSpeech.speak(text: result);
                  setState(() {
                    inAction = !inAction;
                  });
                },
                screenWidth: width,
                icon: Icons.volume_down_outlined,
                tappedIcon: Icons.volume_down,
                effectColor: Colors.amber,
                inAction: inAction),
          ),
        ],
      );

  _getContainer1Decoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      gradient: LinearGradient(
          colors: [Result.COLOR_1, Result.COLOR_2], begin: Alignment.topLeft));

  _getImageSection({required String imagePath}) => FittedBox(
        fit: BoxFit.fitHeight,
        child: Image.file(File(imagePath)),
      );
  _scanText({required String imageUrl}) async {
    result =
        await FlutterTesseractOcr.extractText(imageUrl, language: currentLang);

    setState(() {
      isProcessingDone = true;
    });
  }

  _getLoadingIndicator() => Center(
        child: Container(
          padding: EdgeInsets.all(20),
          height: 100,
          color: Color.fromARGB(113, 0, 0, 0),
          child: Column(
            children: const [
              CircularProgressIndicator(color: Colors.amber),
              Text('Processing ...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'dosis',
                  ))
            ],
          ),
        ),
      );

  void _initTts() {
    _textSpeech = TextSpeech.getInstance(
        setPageState: () {
          setState(() {});
        },
        language: cuttentLangAprv);
    _textSpeech.initTts();
  }

  void _describePage({required String text}) {
    _stopSpeaking();
    if (_textSpeech.language != Languages.ENGLISH_APRV2) {
      _textSpeech.language = Languages.ENGLISH_APRV2;
    }
    _textSpeech.speak(text: DESCRIPTION);
  }

  void _stopSpeaking() {
    if (_textSpeech.state == SpeechState.playing) {
      _textSpeech.stop();
    }
  }

  static const String DESCRIPTION =
      "You are now in scan result screen. To listen to the result tap on the top section of the screen. To go back to the previous screen swip left or right. To display this message again long press on your screen.";
}
