// ignore_for_file: non_constant_identifier_names
import 'package:dartz/dartz.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/layers/data/data-models/movies/movies_dto.dart';

class MoviesEndPoint {
  static get NOW_PLAYING => "/movie/now_playing";
  static get MOST_POPULAR => "/movie/popular";
  static get TOP_RATED => "/movie/top_rated";
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