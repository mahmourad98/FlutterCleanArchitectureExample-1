import 'package:dartz/dartz.dart';
import 'package:untitled05/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/data/data-models/movie-details/movie_details_dto.dart';

abstract class MovieDetailsBaseContract {
  Future<Either<dynamic, MovieDetailsDto>> getMovieDetails({required int movieId,});
}