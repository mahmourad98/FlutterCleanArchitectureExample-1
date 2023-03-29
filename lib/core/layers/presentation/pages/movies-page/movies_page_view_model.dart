import 'package:stacked/stacked.dart';
import 'package:untitled05/core/extras/helpers/base_view_model_helper.dart';
import 'package:untitled05/core/layers/domain/entities/movie-model/movie.dart';
import 'package:untitled05/core/layers/domain/usecases/movie_usecase.dart';
import 'package:untitled05/out-buildings/service_locator.dart';

class MoviesPageViewModel extends BaseViewModel with BaseViewModelHelper{
  NowPlayingMoviesUsecase get _nowPlayingMoviesUsecase => serviceLocator<NowPlayingMoviesUsecase>();
  TopRatedMoviesUsecase get _topRatedMoviesUsecase => serviceLocator<TopRatedMoviesUsecase>();
  MostPopularMoviesUsecase get _mostPopularMoviesUsecase => serviceLocator<MostPopularMoviesUsecase>();

  final List<Movie> _topRatedMovies = <Movie>[];
  List<Movie> get topRatedMovies => _topRatedMovies;

  final List<Movie> _mostPopularMovies = <Movie>[];
  List<Movie> get mostPopularMovies => _mostPopularMovies;

  final List<Movie> _nowPlayingMovies = <Movie>[];
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;


  Future<void> _getNowPlayingMovie() async {
    return await _nowPlayingMoviesUsecase.call().then(
      (value,) => {
        _nowPlayingMovies.addAll(
          value.foldRight<List<Movie>>(
            <Movie>[],
            (r, _,) => r,
          ),
        ),
        notifyListeners(),
      },
    );
  }

  Future<void> _getMostPopularMovie() async {
    _mostPopularMoviesUsecase.call().then(
      (value,) => {
        _mostPopularMovies.addAll(
          value.foldRight<List<Movie>>(
            <Movie>[],
            (r, _,) => r,
          ),
        ),
        notifyListeners(),
      },
    );

  }

  Future<void> _getTopRatedMovie() async {
    _topRatedMoviesUsecase.call().then(
      (value,) => {
        _topRatedMovies.addAll(
          value.foldRight<List<Movie>>(
            <Movie>[],
            (r, _,) => r,
          ),
        ),
        notifyListeners(),
      },
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
  }

  @override
  void onDispose() {
    // TODO: implement onDispose
  }

  @override
  void onModelReady() {
    runBusyFuture(
      Future.wait(
       [
         Future.delayed(const Duration(seconds: 5,),),
         Future(() => _getMostPopularMovie()),
         Future(() => _getNowPlayingMovie()),
         Future(() => _getTopRatedMovie()),
       ],
      )
    );
  }
}