import 'package:flutter/foundation.dart';

class Languages with ChangeNotifier {
  static const ARABIC = "Arabic";
  static const RUSSIAN = "Russian";
  static const GERMAN = "German";
  static const SPANISH = "Spanish";
  static const CHINESE = "Chinese";
  static const ENGLISH = "English";

  static const ARABIC_APRV = "ara";
  static const RUSSIAN_APRV = "rus";
  static const GERMAN_APRV = "due";
  static const SPANISH_APRV = "spa";
  static const CHINESE_APRV = "chi";
  static const ENGLISH_APRV = "eng";

  static const ARABIC_IMG = "assets/images/saudi-arabia.png";
  static const RUSSIAN_IMG = "assets/images/russia.png";
  static const GERMAN_IMG = "assets/images/germany.png";
  static const SPANISH_IMG = "assets/images/spain.png";
  static const CHINESE_IMG = "assets/images/china.png";
  static const ENGLISH_IMG = "assets/images/united-kingdom.png";

  static const ARABIC_APRV2 = "ar";
  static const RUSSIAN_APRV2 = "ru-RU";
  static const GERMAN_APRV2 = "de-DE";
  static const SPANISH_APRV2 = "es-ES";
  static const CHINESE_APRV2 = "zh-CN";
  static const ENGLISH_APRV2 = "en-US";

  var _currentLanguage;
  var _currrntLanguageAprv2;

  String get currentLanguage => _currentLanguage;
  String get currentLanguageAprv2 => _currrntLanguageAprv2;

  void setCurrentLanguage(
      String currentLanguage /*this for Scan text from image*/,
      String currrntLanguageAprv2 /*this for text to speech*/) {
    _currentLanguage = currentLanguage;
    _currrntLanguageAprv2 = currrntLanguageAprv2;
    print(
        "the current Language is ${_currentLanguage} and its other aprv = ${_currrntLanguageAprv2}");
    notifyListeners();
  }
}
