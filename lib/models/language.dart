import 'package:flutter/foundation.dart';

import '../providers/languages.dart';

class Language with ChangeNotifier {
  static String CURRENT_LANGUAGE = Languages.ENGLISH_APRV;

  String name;
  String languageImg;
  String languageAprv;
  String languageSpeechAprv;
  Language(
      {required this.name,
      required this.languageAprv,
      required this.languageImg,
      required this.languageSpeechAprv});
  currentLanguage(String language) {
    CURRENT_LANGUAGE = language;
    notifyListeners();
  }
}
