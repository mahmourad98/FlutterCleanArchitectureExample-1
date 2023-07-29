import 'package:stacked/stacked.dart';
import 'package:untitled05/core/extras/helpers/base_view_model_helper.dart';
import 'package:untitled05/core/extras/services/app-navigation-service/app_navigation_service.dart';
import 'package:untitled05/core/layers/presentation/pages/movies-page/movies_page_view.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class SplashPageViewModel extends BaseViewModel with BaseViewModelHelper{

  @override
  void onClose() {
    serviceLocator<AppNavigationService>().goBack();
  }

  @override
  void onDispose() {}

  @override
  void onModelReady() {
    Future.delayed(
      const Duration(seconds: 3,),
      () => serviceLocator<AppNavigationService>().navigateTo(routeName: MoviesPageView.routeName,),
    );
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }
}