import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:untitled05/core/app_routing/app_router.dart';
import 'package:untitled05/core/delegations/helpers/app_entry_point_environment_helper.dart';
import 'package:untitled05/core/delegations/helpers/base_view_model_helper.dart';
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
        _deviceOrientation();
        return () => _dispose();
      },
      const [],
    );

    ///Builders
    return ViewModelBuilder<_AppEntryPointViewModel>.reactive(
      viewModelBuilder: () => _AppEntryPointViewModel(),
      onModelReady: (viewModel,) => viewModel.onModelReady(),
      fireOnModelReadyOnce: true,
      builder: (_, viewModel, __,) => MaterialApp(
        builder: (buildContext, childWidget,) {
          childWidget = botToastBuilder(buildContext, childWidget,);
          return childWidget.renderTreeHandler(
            environmentType,
            const [],
          );
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
    );
  }

  void _dispose() {}

  void _deviceOrientation() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,],);
  }
}

class _AppEntryPointViewModel extends ReactiveViewModel with BaseViewModelHelper {
  @override
  void onClose() {}

  @override
  void onModelReady() {}

  @override
  void dispose() { super.dispose(); }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
