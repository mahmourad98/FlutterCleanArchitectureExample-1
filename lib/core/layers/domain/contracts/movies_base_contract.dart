import 'package:dartz/dartz.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/layers/data/data-models/movies/movies_dto.dart' as movies_dto;
import 'package:untitled05/core/layers/domain/entities/movie-model/movie.dart';

abstract class MoviesBaseContract {
  Future<Either<NetworkFailure, List<Movie>>> getNowPlayingMovies({required List<Movie> Function(movies_dto.MoviesDto,) fromDto,});
  Future<Either<NetworkFailure, List<Movie>>> getTopRatedMovies({required List<Movie> Function(movies_dto.MoviesDto,) fromDto,});
  Future<Either<NetworkFailure, List<Movie>>> getMostPopularMovies({required List<Movie> Function(movies_dto.MoviesDto,) fromDto,});
}