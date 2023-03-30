import 'package:dartz/dartz.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/layers/domain/entities/movie-model/movie.dart';
import 'package:untitled05/core/layers/data/data-models/movies/movies_dto.dart' as movies_dto;

abstract class MoviesBaseUsecase {
  List<Movie> moviesListFromDto(movies_dto.MoviesDto dto,) {
    final list = dto.results ?? <movies_dto.Movie>[];
    return List.generate(
      list.length,
      (index,) => Movie.from(list[index],),
    );
  }

  Future<Either<NetworkFailure, List<Movie>>> call();
}