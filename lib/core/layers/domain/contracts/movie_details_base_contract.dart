import 'package:dartz/dartz.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/layers/data/data-models/movie-details/movie_details_dto.dart';
import 'package:untitled05/core/layers/domain/entities/movie-details-model/movie_details.dart';

abstract class MovieDetailsBaseContract {
  Future<Either<NetworkFailure, MovieDetails>> getMovieDetails({
    required int movieId, required MovieDetails Function(MovieDetailsDto,) fromDto,
  });
}