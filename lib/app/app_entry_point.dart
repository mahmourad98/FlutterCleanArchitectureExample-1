import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:untitled05/app/app_router.dart';
import 'package:untitled05/core/extras/helpers/base_view_model_helper.dart';
import 'package:untitled05/core/extras/utils/app_life_cycle_wrapper_utility.dart';
import 'package:untitled05/core/layers/data/enums/environment_type.dart';

class AppEntryPoint extends HookWidget {
  final EnvironmentType environmentType;

  const AppEntryPoint(this.environmentType, {Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context,) {
    ///Hooks
    late final TransitionBuilder botToastBuilder;
    useEffect(
      () {
         botToastBuilder = BotToastInit();
        _setDeviceOrientation();
        return () => _dispose();
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
            childWidget = botToastBuilder.call(buildContext, childWidget,);
            childWidget = AppLifeCycleWrapper(childWidget, const [],);
            return childWidget.renderTreeHandler(environmentType, const [],);
          },
          navigatorObservers: [
            AppRouter.instance.navObserver,
            BotToastNavigatorObserver(),
          ],
          onGenerateRoute: AppRouter.onGenerateRoute,
          navigatorKey: AppRouter.instance.navKey,
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
        ),
      ),
    );
  }

  void _dispose() {}

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

extension AppEntryPointEnvHelper on Widget? {
  ///Here all the test env wrapping widgets must be implemented !
  Widget renderTreeHandler(EnvironmentType environmentType, List<Tuple3<AppLifecycleState, AppLifecycleState, Function>> appliedStateChangedProcedures,) {
    final mainWidget = this ?? const SizedBox.expand();
    switch (environmentType) {
      ///Production Mode
      case EnvironmentType.production:
      return mainWidget;
      ///Acceptance Mode
      case EnvironmentType.acceptance:
      return mainWidget;
      ///Development Mode
      case EnvironmentType.testing:
      return mainWidget;
      ///Development Mode
      case EnvironmentType.development:
      return mainWidget;
    }
  }
}

