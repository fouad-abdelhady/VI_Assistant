import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jarvis000/models/text_speech.dart';
import 'package:jarvis000/screens/options_screens.dart';
import 'package:jarvis000/widgets/app_scaffold.dart';

import '../providers/languages.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late double screenHeight;
  late double screenWidth;
  late TextSpeech _textSpeech;
  @override
  void initState() {
    super.initState();
    _textSpeech = TextSpeech.getInstance(
        setPageState: () {}, language: Languages.ENGLISH_APRV2);
    _textSpeech.initTts();
    _navigateToOptionsScreen();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _displayWelcomeMessage();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return AppScaffold(
        appBarTitle: 'Splash',
        screenBody: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.5,
                  child: Column(children: [
                    Container(
                      // image section
                      child: Image.asset("assets/images/horus.png"),
                    ),
                    Expanded(
                      // this is loadion text section
                      child: Container(
                        child: Text(
                          "Loading ...",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontSize: 30),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  color: Colors.transparent,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("By Eng:",
                          style: TextStyle(
                              fontFamily: "dosis",
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Text(" Salha",
                          style: TextStyle(
                              fontFamily: "dosis",
                              fontSize: 20,
                              color: Color.fromARGB(255, 234, 255, 7),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _navigateToOptionsScreen() async {
    await Future.delayed(Duration(seconds: 7), () {});
    Navigator.of(context)
        .pushReplacementNamed(OptionsScreen.OPTIONS_SCREEN_ROUTE);
  }

  void _displayWelcomeMessage() async {
    await Future.delayed(Duration(seconds:3 ), () {});
    _textSpeech.speak(text: "Wellcome in Iron man Jarvis");
  }
}
