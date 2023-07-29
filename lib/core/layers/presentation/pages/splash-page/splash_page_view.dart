import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:untitled05/core/layers/presentation/pages/splash-page/splash_page_view_model.dart';
import 'package:untitled05/core/layers/presentation/shared-view-components/custom_loader_widget.dart';

class SplashPageView extends StatelessWidget {
  static const String routeName = "/splash-page";
  static const ValueKey<String> routeKey = ValueKey<String>("splash-page",);
  /////////////////////////
  const SplashPageView() : super(key: null,);
  /////////////////////////
  @override
  Widget build(BuildContext context,) {
    return ViewModelBuilder<SplashPageViewModel>.nonReactive(
      fireOnViewModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: true,
      viewModelBuilder: () => SplashPageViewModel(),
      onViewModelReady: (viewModel,) => viewModel.onModelReady(),
      builder: (_, viewModel, __,) => const _SplashPageView(key: routeKey,),
    );
  }
}

class _SplashPageView extends ViewModelWidget<SplashPageViewModel> {
  const _SplashPageView({Key? key,}) : super(key: key,);
  /////////////////////////
  @override
  Widget build(BuildContext context, SplashPageViewModel viewModel,) {
    return WillPopScope(
      onWillPop: () async {
        viewModel.onClose();
        return true;
      },
      child: const Scaffold(
        body: Center(
          child: CustomLoader(customLoaderTypes: CustomLoaderTypes.ripple,),
        ),
      ),
    );
  }
}

