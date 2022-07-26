import 'package:flutter/material.dart';
import 'package:jarvis000/screens/options_screens.dart';
import 'package:jarvis000/screens/speech_text_screen.dart';
import '../screens/image_scan_screen.dart';
import '../screens/result_screen.dart';

class Routes {
  static MaterialPageRoute ON_GENERATE_ROUTE(
      {required RouteSettings settings}) {
    switch (settings.name) {
      case OptionsScreen.OPTIONS_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (_) => OptionsScreen(), settings: settings);
      case Result.RESULT_SCREEN_ROUTE:
        return MaterialPageRoute(builder: (_) => Result(), settings: settings);
      case ImageScan.IMAGE_SCAN_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (_) => ImageScan(), settings: settings);
      case SpeechToTextScreen.SPEECH_TEXT_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (_) => SpeechToTextScreen(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => OptionsScreen(), settings: settings);
    }
  }
}
