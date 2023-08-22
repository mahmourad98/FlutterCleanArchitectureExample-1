import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:untitled05/app/app.dart';
import 'package:untitled05/extras/helpers/base_view_model_helper.dart';
import 'package:untitled05/out-buildings/app_environment.dart';

class MyAppEntryPoint extends StatelessWidget {
  final EnvironmentType environmentType;

  const MyAppEntryPoint(this.environmentType,) : super(key: null,);

  @override
  Widget build(BuildContext context,) {
    ///Builders
    return ViewModelBuilder<_AppEntryPointViewModel>.nonReactive(
      fireOnViewModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      createNewViewModelOnInsert: false,
      disposeViewModel: false,
      viewModelBuilder: () => _AppEntryPointViewModel(),
      onViewModelReady: (_AppEntryPointViewModel viewModel,) => viewModel.onModelReady(),
      builder: (_, _AppEntryPointViewModel viewModel, __,) => WillPopScope(
        onWillPop: () async {
          viewModel.onClose();
          return true;
        },
        child: MyApplication(),
      ),
    );
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

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }
}

