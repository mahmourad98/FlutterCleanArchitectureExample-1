// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/layers/data/data-models/movie-details/movie_details_dto.dart';

class MovieDetailsEndPoint {
  static String MOVIE_DETAILS(int id,) => "/movie/$id";
}

abstract class MovieDetailsBaseDataSource {
  Future<Either<NetworkFailure, MovieDetailsDto>> getMovieDetails({
    required int movieId, bool localRequest = false, bool authRequest = false,
  });
}