import 'package:stacked/stacked.dart';
import 'package:untitled05/extras/helpers/base_view_model_helper.dart';
import 'package:untitled05/extras/services/app-navigation-service/app_navigation_service.dart';
import 'package:untitled05/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/data/repos/movies/movies_repository.dart';
import 'package:untitled05/core/domain/entities/movie-model/movie.dart';
import 'package:untitled05/core/domain/usecases/movies_usecase.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class MoviesPageViewModel extends BaseViewModel with BaseViewModelHelper{
  late final NowPlayingMoviesUsecase _nowPlayingMoviesUsecase;
  late final TopRatedMoviesUsecase _topRatedMoviesUsecase;
  late final MostPopularMoviesUsecase _mostPopularMoviesUsecase;
  /////////////////////////
  final List<Movie> _topRatedMovies = <Movie>[];
  List<Movie> get topRatedMovies => _topRatedMovies;
  void setTopRatedMovies(List<Movie> value,) {
    _topRatedMovies..clear()..addAll(value,);
    notifyListeners();
  }
  /////////////////////////
  final List<Movie> _mostPopularMovies = <Movie>[];
  List<Movie> get mostPopularMovies => _mostPopularMovies;
  void setMostPopularMovies(List<Movie> value,) {
    _mostPopularMovies..clear()..addAll(value,);
    notifyListeners();
  }
  /////////////////////////
  final List<Movie> _nowPlayingMovies = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  void setNowPlayingMovies(List<Movie> value,) {
    _nowPlayingMovies..clear()..addAll(value,);
    notifyListeners();
  }
  ///DEFAULT CONSTRUCTOR
  MoviesPageViewModel._();
  factory MoviesPageViewModel.create() {
    final viewModel = MoviesPageViewModel._();
    viewModel._nowPlayingMoviesUsecase = NowPlayingMoviesUsecase(serviceLocator<MoviesRepository>(),);
    viewModel._topRatedMoviesUsecase = TopRatedMoviesUsecase(serviceLocator<MoviesRepository>(),);
    viewModel._mostPopularMoviesUsecase = MostPopularMoviesUsecase(serviceLocator<MoviesRepository>(),);
    return viewModel;
  }
  /////////////////////////
  Future<void> _getNowPlayingMovie() async {
    return await _nowPlayingMoviesUsecase().then(
      (value,) => {
        value.fold(
          (l,) => setError(l,),
          (r,) => setNowPlayingMovies(r,),
        ),
      },
    );
  }
  /////////////////////////
  Future<void> _getMostPopularMovie() async {
    return _mostPopularMoviesUsecase().then(
      (value,) => {
        value.fold(
          (l,) => setError(l,),
          (r,) => setMostPopularMovies(r,),
        ),
      },
    );
  }
  /////////////////////////
  Future<void> _getTopRatedMovie() async {
    return _topRatedMoviesUsecase().then(
      (value,) => {
        value.fold(
          (l,) => setError(l,),
          (r,) => setTopRatedMovies(r,),
        ),
      },
    );
  }
  /////////////////////////
  @override
  void onClose() { serviceLocator<AppNavigationService>().goBack(); }
  /////////////////////////
  @override
  void onDispose() {}
  /////////////////////////
  @override
  void onModelReady() {
    runBusyFuture(
      Future.wait(
       [
         Future.delayed(const Duration(seconds: 5,),),
         Future(() => _getMostPopularMovie(),),
         Future(() => _getNowPlayingMovie(),),
         Future(() => _getTopRatedMovie(),),
       ],
      ),
    );
  }
  /////////////////////////
  @override
  void dispose() {
    onDispose();
    super.dispose();
  }
}