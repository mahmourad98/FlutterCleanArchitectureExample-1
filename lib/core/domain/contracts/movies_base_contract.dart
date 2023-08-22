import 'package:dartz/dartz.dart';
import 'package:untitled05/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/data/data-models/movies/movies_dto.dart' as movies_dto;

abstract class MoviesBaseContract {
  const MoviesBaseContract();
  Future<Either<dynamic, movies_dto.MoviesDto>> getNowPlayingMovies();
  Future<Either<dynamic, movies_dto.MoviesDto>> getTopRatedMovies();
  Future<Either<dynamic, movies_dto.MoviesDto>> getMostPopularMovies();
}