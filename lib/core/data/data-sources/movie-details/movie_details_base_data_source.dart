// ignore_for_file: non_constant_identifier_names
import 'package:dartz/dartz.dart';
import 'package:untitled05/core/data/data-models/common-response-model/common_response_model.dart';

class MovieDetailsEndPoint {
  static String MOVIE_DETAILS(int id,) => "/movie/$id";
}

abstract class MovieDetailsBaseDataSource {
  const MovieDetailsBaseDataSource();
  ////////////////////
  Future<Either<dynamic, CommonResponse>> getMovieDetails({
    required int movieId, bool localRequest = false, bool authRequest = false,
  });
}