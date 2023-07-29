class SupportedLanguage {
  static const List<String> languageNames = ['English', 'Türkçe', 'Arabic'];
  static const List<String> languageCodes = ['en', 'tr', 'ar',];
  static const List<String> countryCodes = ['US', 'TR', 'SA',];
  static int getLanguageIndex(String languageCode,) {
    return languageCodes.indexOf(languageCode,);
  }
}