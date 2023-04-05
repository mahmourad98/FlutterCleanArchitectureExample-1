import 'package:untitled05/app/app_router.dart';
import 'package:untitled05/core/extras/helpers/base_view_model_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:untitled05/core/layers/domain/entities/movie-details-model/movie_details.dart';
import 'package:untitled05/core/layers/domain/usecases/movie_details_usecase.dart';
import 'package:untitled05/out-buildings/service_locator.dart';

class MovieDetailsPageViewModel extends BaseViewModel with BaseViewModelHelper {
  final int _movieId;
  late final MovieDetails _movieDetails;
  static const String GET_MOVIE_DETAILS = "get-movie-details";
  MovieDetails get movieDetails => _movieDetails;

  SingleMovieDetailsUsecase get _singleMovieDetailsUsecase => serviceLocator<SingleMovieDetailsUsecase>();

  ///DEFAULT CONSTRUCTOR
  MovieDetailsPageViewModel(this._movieId,);

  Future<void> _getMovieDetails() async {
    return await _singleMovieDetailsUsecase(_movieId,).then(
      (value,) => {
        value.fold(
          (l,) => setError(l,),
          (r,) => {
            _movieDetails = r,
            notifyListeners(),
          },
        ),
      },
    );
  }

  @override
  void onClose() {
    if(AppRouter.instance.navKey.currentState != null) {
      AppRouter.instance.navKey.currentState!.pop();
      /*Navigator.of(AppRouter.instance.navKey.currentContext!,).pop();*/
    }
  }

  @override
  void onDispose() {}

  @override
  void onModelReady() {
    waitMultipleFutures(
      [
        Future.delayed(const Duration(seconds: 5,),),
        Future(() async => await _getMovieDetails(),),
      ],
    );
  }
}