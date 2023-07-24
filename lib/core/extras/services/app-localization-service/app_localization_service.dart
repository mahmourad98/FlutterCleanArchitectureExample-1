import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled05/config/shared_prefs_keys.dart';
import 'package:untitled05/config/supported_languages.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class AppLocalizationService extends ChangeNotifier{
  Locale? _locale;
  Locale get currentLocale => _locale!;
  /////////////////////////////
  Map<String, String>? _localizedStrings;
  Map<String, String> get localizedStrings => _localizedStrings!;
  /////////////////////////////
  int get currentLangIndex => SupportedLanguage.getLanguageIndex(currentLocale.languageCode,);
  bool get isRTL => intl.Bidi.isRtlLanguage(currentLocale.languageCode,);

  ///DEFAULT CONSTRUCTOR
  AppLocalizationService() {
    _locale ??= Locale(SupportedLanguage.languageCodes.first, SupportedLanguage.countryCodes.first,);
    _localizedStrings ??= <String, String>{};
  }

  Future<void> initAppLocaleFromDB() async {
    ///GET CURRENT APP LOCAL FROM DB
    final langCode = await _getLanguageCode();
    ///GET THE STORED RESOURCE
    final newLocale = Locale(SupportedLanguage.languageCodes[langCode], SupportedLanguage.countryCodes[langCode],);
    _locale = newLocale; await _loadLocalizedText(newLocale,);
    return /*notifyListeners()*/;
  }

  Future<void> setAppLocale(int langCode,) async {
    if(langCode >= SupportedLanguage.languageCodes.length) throw Exception('Language code is not valid',);
    ///UPDATE LOCALE
    await _setLanguageCode(langCode,);
    ///SAVE LOCAL
    final newLocale = Locale(SupportedLanguage.languageCodes[langCode], SupportedLanguage.countryCodes[langCode],);
    _locale = newLocale; await _loadLocalizedText(newLocale,);
    return notifyListeners();
  }

  ///LOAD THE LANGUAGE JSON FILE FROM THE "lang" FOLDER IN ASSETS
  Future<bool> _loadLocalizedText(Locale locale,) async {
    try {
      _localizedStrings?.clear();
      String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}_${locale.countryCode?.toUpperCase()}.json',);
      Map<String, dynamic> jsonMap = json.decode(jsonString,);
      _localizedStrings?.addAll(jsonMap.map((String key, dynamic value,) => MapEntry(key, value.toString(),),),);
      return true;
    }
    catch(e) { return false; }
  }

  ///READ LOCALIZED TEXT VALUE
  String getLocalizedValue(String key,) {
    return _localizedStrings?[key] ?? key;
  }

  ///GET LANGUAGE CODE FROM DB
  Future<int> _getLanguageCode() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final langCode = sharedPrefs.getInt(SharedPrefsKeys.LANGUAGE_NUMBER,) ?? 0;
    return langCode;
  }

  ///SET LANGUAGE CODE AT DB
  Future<bool> _setLanguageCode(int langCode,) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return await sharedPrefs.setInt(SharedPrefsKeys.LANGUAGE_NUMBER, langCode,);
  }

  bool _isSupported(Locale locale,) {
    if (locale.languageCode.isNotEmpty) {
      return SupportedLanguage.languageCodes.contains(locale.languageCode,);
    }
    return false;
  }
}

///GLOBAL TRANSLATE FUNCTION
String translate(String key,) {
  return serviceLocator<AppLocalizationService>().getLocalizedValue(key,);
}

bool isRTL() {
  return serviceLocator<AppLocalizationService>().isRTL;
}