import 'package:stacked/stacked.dart';
import 'package:untitled05/core/extras/helpers/base_view_model_helper.dart';
import 'package:untitled05/core/extras/services/app-navigation-service/app_navigation_service.dart';
import 'package:untitled05/core/layers/data/repos/movie-details/movie_details_repository.dart';
import 'package:untitled05/core/layers/domain/entities/movie-details-model/movie_details.dart';
import 'package:untitled05/core/layers/domain/usecases/movie_details_usecase.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class MovieDetailsPageViewModel extends DynamicSourceViewModel with BaseViewModelHelper {
  static const String GET_MOVIE_DETAILS = "get-movie-details";
  /////////////////////////
  final int _movieId;
  late final SingleMovieDetailsUsecase _singleMovieDetailsUsecase;
  /////////////////////////
  late final MovieDetails _movieDetails;
  MovieDetails get movieDetails => _movieDetails;
  set movieDetails(MovieDetails value) {
    _movieDetails = value;
    notifyListeners();
  }
  ///DEFAULT CONSTRUCTOR
  MovieDetailsPageViewModel._(this._movieId,);
  factory MovieDetailsPageViewModel.create(int movieId,) {
    final viewModel = MovieDetailsPageViewModel._(movieId,);
    viewModel._singleMovieDetailsUsecase = SingleMovieDetailsUsecase(serviceLocator<MovieDetailsRepository>(),);
    return viewModel;
  }
  /////////////////////////
  Future<void> _getMovieDetails() async {
    await Future.delayed(const Duration(seconds: 5,),);
    return await _singleMovieDetailsUsecase(_movieId,).then(
      (value,) => {
        value.fold(
          (l,) => {setError(l,),},
          (r,) => {_movieDetails = r,},
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
    runBusyFuture(
      Future.wait(
        [
          Future(() => _getMovieDetails(),),
        ],
      ),
      busyObject: this,
    );
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }
}