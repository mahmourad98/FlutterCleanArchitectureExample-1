import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled05/config/app_config.dart';
import 'package:untitled05/config/app_theme.dart';
import 'package:untitled05/config/supported_languages.dart';
import 'package:untitled05/extras/services/app-localization-service/app_localization_delegate.dart';
import 'package:untitled05/extras/services/app-localization-service/app_localization_service.dart';
import 'package:untitled05/extras/services/app-navigation-service/app_navigation_service.dart';
import 'package:untitled05/extras/services/app-navigation-service/app_route_generator.dart';
import 'package:untitled05/extras/utils/app_keyboard_hider_utility.dart';
import 'package:untitled05/extras/utils/app_life_cycle_wrapper_utility.dart';
import 'package:untitled05/core/presentation/pages/splash-page/splash_page_view.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class MyApplication extends StatelessWidget {
  static const _key = ValueKey("my-app",);
  static const _app = MyApplication._(key: _key,);
  /////////////////////////
  const MyApplication._({Key? key,}) : super(key: key,);
  factory MyApplication() => _app;
  /////////////////////////
  @override Widget build(BuildContext context,) {
    if(Platform.isAndroid) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        title: AppConfig.appName,
        theme: AppTheme.isDarkTheme ? AppTheme.appThemeDark : AppTheme.appThemeLight,
        themeMode: AppTheme.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        builder: (BuildContext buildContext, Widget? childWidget,) {
          _setDeviceOrientation();
          childWidget = BotToastInit().call(buildContext, childWidget,);
          childWidget = AppLifeCycleWrapper(childWidget, const [],);
          childWidget = AppKeyboardHiderWrapper(childWidget,);
          return Theme(
            data: ThemeData(fontFamily: _fontFamily,),
            child: childWidget,
          );
        },
        navigatorKey: serviceLocator<AppNavigationService>().navKey,
        navigatorObservers: _navigationObservers,
        initialRoute: AppRouteNames.SPLASH_PAGE,
        onGenerateInitialRoutes: (String initialRouteName,) => [
          AppRouter.onGenerateRoute(RouteSettings(name: initialRouteName, arguments: null,),),
        ],
        routes: const <String, WidgetBuilder>{},
        onGenerateRoute: AppRouter.onGenerateRoute,
        onUnknownRoute: AppRouter.onGenerateRoute,
        locale: serviceLocator<AppLocalizationService>().currentLocale,
        supportedLocales: _supportedLanguages,
        localizationsDelegates: _localizationDelegates,
        localeResolutionCallback: _localeResolutionCallback,
      );
    }
    else {
      return CupertinoApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        title: AppConfig.appName,
        builder: (BuildContext buildContext, Widget? childWidget,) {
          _setDeviceOrientation();
          childWidget = BotToastInit().call(buildContext, childWidget,);
          childWidget = AppLifeCycleWrapper(childWidget, const [],);
          childWidget = AppKeyboardHiderWrapper(childWidget,);
          return Theme(
            data: ThemeData(fontFamily: _fontFamily,),
            child: childWidget,
          );
        },
        navigatorKey: serviceLocator<AppNavigationService>().navKey,
        navigatorObservers: _navigationObservers,
        initialRoute: SplashPageView.routeName,
        onGenerateInitialRoutes: (_,) => [AppRouter.onGenerateRoute(RouteSettings(name: _, arguments: null,),),],
        routes: const <String, WidgetBuilder>{},
        onGenerateRoute: AppRouter.onGenerateRoute,
        onUnknownRoute: AppRouter.onGenerateRoute,
        locale: serviceLocator<AppLocalizationService>().currentLocale,
        supportedLocales: _supportedLanguages,
        localizationsDelegates: _localizationDelegates,
        localeResolutionCallback: _localeResolutionCallback,
      );
    }
  }

  void _setDeviceOrientation() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,],);
  }

  List<NavigatorObserver> get _navigationObservers => [
    serviceLocator<AppNavigationService>().navObserver,
    BotToastNavigatorObserver(),
  ];

  String get _fontFamily => serviceLocator<AppLocalizationService>().isRTL ? "Cairo" : "Poppins";

  List<Locale> get _supportedLanguages => List<Locale>.generate(
    SupportedLanguage.languageNames.length,
        (int index,) => Locale(SupportedLanguage.languageCodes[index], SupportedLanguage.countryCodes[index],),
  );

  List<LocalizationsDelegate> get _localizationDelegates => const <LocalizationsDelegate<dynamic>>[
    AppLocalizationDelegate.instance,
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  Locale? _localeResolutionCallback(Locale? locale, Iterable<Locale> supportedLocales,) {
    if(locale != null && locale.languageCode.isNotEmpty) {
      final int langId = SupportedLanguage.getLanguageIndex(locale.languageCode,);
      final int langIndex = (langId == -1) ? 0 : langId;
      return Locale(
        SupportedLanguage.languageCodes[langIndex],
        SupportedLanguage.countryCodes[langIndex],
      );
    }
    else {
      return supportedLocales.first;
    }
  }
}
