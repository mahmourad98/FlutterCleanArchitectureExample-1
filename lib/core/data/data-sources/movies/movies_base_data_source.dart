// ignore_for_file: non_constant_identifier_names
import 'package:dartz/dartz.dart';
import 'package:untitled05/core/data/data-models/common-response-model/common_response_model.dart';

class MoviesEndPoint {
  static get NOW_PLAYING => "/movie/now_playing";
  static get MOST_POPULAR => "/movie/popular";
  static get TOP_RATED => "/movie/top_rated";
}

abstract class MoviesBaseDataSource {
  const MoviesBaseDataSource();
  ////////////////////
  Future<Either<dynamic, CommonResponse>> getNowPlayingMovies({
    bool localRequest = false, bool authRequest = false,
  });
  ////////////////////
  Future<Either<dynamic, CommonResponse>> getTopRatedMovies({
    bool localRequest = false, bool authRequest = false,
  });
  ////////////////////
  Future<Either<dynamic, CommonResponse>> getMostPopularMovies({
    bool localRequest = false, bool authRequest = false,
  });
}