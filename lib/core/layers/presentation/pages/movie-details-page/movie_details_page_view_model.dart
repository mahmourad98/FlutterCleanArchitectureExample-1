import 'package:bot_toast/bot_toast.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:stacked/stacked.dart';
import 'package:untitled05/core/extras/helpers/base_view_model_helper.dart';
import 'package:untitled05/core/extras/services/app-navigation-service/app_navigation_service.dart';
import 'package:untitled05/core/extras/utils/bot_toast_utility.dart';
import 'package:untitled05/core/extras/utils/progress_dialog_utility.dart';
import 'package:untitled05/core/layers/domain/entities/movie-details-model/movie_details.dart';
import 'package:untitled05/core/layers/domain/usecases/movie_details_usecase.dart';
import 'package:untitled05/core/layers/presentation/shared-view-components/custom_loader_widget.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class MovieDetailsPageViewModel extends BaseViewModel with BaseViewModelHelper {
  final int _movieId;
  late final MovieDetails _movieDetails;
  static const String GET_MOVIE_DETAILS = "get-movie-details";
  MovieDetails get movieDetails => _movieDetails;

  ProgressDialog get _progressDialog => ProgressDialogUtility.create();

  SingleMovieDetailsUsecase get _singleMovieDetailsUsecase => serviceLocator<SingleMovieDetailsUsecase>();

  ///DEFAULT CONSTRUCTOR
  MovieDetailsPageViewModel(this._movieId,);

  Future<void> _getMovieDetails() async {
    _progressDialog.show();
    await Future.delayed(const Duration(seconds: 5,),);
    return await _singleMovieDetailsUsecase(_movieId,).then(
      (value,) => {
        value.fold(
          (l,) => {
            setError(l,),
            _progressDialog.hide(),
          },
          (r,) => {
            _movieDetails = r,
            notifyListeners(),
            _progressDialog.hide(),
          },
        ),
      },
    );
  }

  @override
  void onClose() {
    serviceLocator<AppNavigationService>().goBack();
  }

  @override
  void onDispose() {}

  @override
  void onModelReady() {
    waitMultipleFutures(
      [
        Future(() async => await _getMovieDetails(),),
      ],
    );
  }
}