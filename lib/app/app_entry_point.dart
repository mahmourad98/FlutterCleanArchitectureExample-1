import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stacked/stacked.dart';
import 'package:untitled05/app/app_route_names.dart';
import 'package:untitled05/app/app_router.dart';
import 'package:untitled05/core/extras/config/app_config.dart';
import 'package:untitled05/core/extras/config/app_theme.dart';
import 'package:untitled05/core/extras/config/supported_languages.dart';
import 'package:untitled05/core/extras/helpers/base_view_model_helper.dart';
import 'package:untitled05/core/extras/utils/app_keyboard_hider_utility.dart';
import 'package:untitled05/core/extras/utils/app_life_cycle_wrapper_utility.dart';
import 'package:untitled05/out-buildings/app_environment.dart';

class AppEntryPoint extends HookWidget {
  final EnvironmentType environmentType;

  const AppEntryPoint(this.environmentType, {Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context,) {
    useEffect(
      () {
        _setDeviceOrientation();
        return null;
      },
      const [],
    );

    ///Builders
    return ViewModelBuilder<_AppEntryPointViewModel>.reactive(
      fireOnViewModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      createNewViewModelOnInsert: false,
      disposeViewModel: false,
      viewModelBuilder: () => _AppEntryPointViewModel(),
      onViewModelReady: (viewModel,) => viewModel.onModelReady(),
      onDispose: (viewModel,) => viewModel.onDispose(),
      builder: (_, viewModel, __,) => WillPopScope(
        onWillPop: () async {
          viewModel.onClose();
          return true;
        },
        child: MaterialApp(
          title: AppConfig.appName,
          theme: AppTheme.isDarkTheme ? AppTheme.appThemeDark : AppTheme.appThemeLight,
          themeMode: AppTheme.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          builder: (buildContext, childWidget,) {
            childWidget = BotToastInit().call(buildContext, childWidget,);
            childWidget = AppLifeCycleWrapper(childWidget, const [],);
            childWidget = AppKeyboardHiderWrapper(childWidget,);
            return childWidget;
          },
          navigatorKey: AppRouter.instance.navKey,
          navigatorObservers: [
            AppRouter.instance.navObserver,
            BotToastNavigatorObserver(),
          ],
          initialRoute: AppRouteNames.moviesRoute,
          onGenerateInitialRoutes: (_,) => [AppRouter.onGenerateRoute(RouteSettings(name: _,),)!,],
          onGenerateRoute: AppRouter.onGenerateRoute,
          onUnknownRoute: AppRouter.onGenerateRoute,
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          locale: Locale(SupportedLanguage.languageCodes.first, SupportedLanguage.countryCodes.first,),
          supportedLocales: List<Locale>.generate(
            SupportedLanguage.languageNames.length,
            (int index,) => Locale(SupportedLanguage.languageCodes[index], SupportedLanguage.countryCodes[index],),
          ),
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales,) {
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
          },
        ),
      ),
    );
  }

  void _setDeviceOrientation() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,],);
  }
}

class _AppEntryPointViewModel extends ReactiveViewModel with BaseViewModelHelper {
  @override
  void onClose() {}

  @override
  void onModelReady() {}

  @override
  void onDispose() {}

  @override
  List<ListenableServiceMixin> get listenableServices => const [];
}

