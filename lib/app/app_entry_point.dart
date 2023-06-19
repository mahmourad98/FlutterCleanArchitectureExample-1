import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:untitled05/app/app_route_names.dart';
import 'package:untitled05/app/app_router.dart';
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

