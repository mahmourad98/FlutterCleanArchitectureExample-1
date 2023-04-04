import 'package:dartz/dartz.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/layers/domain/entities/movie-details-model/movie_details.dart';

abstract class MovieDetailsBaseUsecase {
  Future<Either<NetworkFailure, MovieDetails>> call({required int movieId,});
}