import 'package:dartz/dartz.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/layers/data/data-models/movies/movies_dto.dart';

class MoviesEndPoint {
  static const NOW_PLAYING = "/movie/now_playing";
  static const MOST_POPULAR = "/movie/now_playing";
  static const TOP_RATED = "/movie/top_rated";
}

abstract class MoviesBaseDataSource {
  Future<Either<NetworkFailure, MoviesDto>> getNowPlayingMovies({
    bool localRequest = false, bool authRequest = false,
  });
  Future<Either<NetworkFailure, MoviesDto>> getTopRatedMovies({
    bool localRequest = false, bool authRequest = false,
  });
  Future<Either<NetworkFailure, MoviesDto>> getMostPopularMovies({
    bool localRequest = false, bool authRequest = false,
  });
}