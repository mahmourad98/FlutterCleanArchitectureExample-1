import 'package:flutter/material.dart';
import 'package:untitled05/config/supported_languages.dart';
import 'package:untitled05/extras/services/app-localization-service/app_localization_service.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizationService> {
  static const instance = AppLocalizationDelegate._();

  const AppLocalizationDelegate._();

  @override
  bool isSupported(Locale locale,) => SupportedLanguage.languageCodes.contains(locale.languageCode,);

  @override
  Future<AppLocalizationService> load(Locale locale,) async => serviceLocator<AppLocalizationService>();

  @override
  bool shouldReload(AppLocalizationDelegate old,) => false;
}
