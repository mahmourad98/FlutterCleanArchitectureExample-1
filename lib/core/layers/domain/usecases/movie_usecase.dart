import 'package:dartz/dartz.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/layers/domain/contracts/movies_base_contract.dart';
import 'package:untitled05/core/layers/domain/entities/movie-model/movie.dart';
import 'package:untitled05/core/layers/data/data-models/movies/movies_dto.dart' as movies_dto;

abstract class MoviesUsecase{
  List<Movie> moviesListFromDto(movies_dto.MoviesDto dto,) {
    final list = dto.results ?? <movies_dto.Movie>[];
    return List.generate(
      list.length,
      (index,) => Movie.from(list[index],),
    );
  }
}

class NowPlayingMoviesUsecase extends MoviesUsecase{
  final MoviesBaseContract _movieBaseContract;

  NowPlayingMoviesUsecase(this._movieBaseContract,);

  Future<Either<NetworkFailure, List<Movie>>> call() async {
    return await _movieBaseContract.getNowPlayingMovies(
      fromDto: (moviesDto,) => moviesListFromDto(moviesDto,),
    );
  }
}

class PopularMoviesUsecase extends MoviesUsecase {
  final MoviesBaseContract _movieBaseContract;

  PopularMoviesUsecase(this._movieBaseContract,);

  Future<Either<NetworkFailure, List<Movie>>> call() async {
    return await _movieBaseContract.getMostPopularMovies(
      fromDto: (moviesDto,) => moviesListFromDto(moviesDto,),
    );
  }
}

class TopRatedMoviesUsecase extends MoviesUsecase {
  final MoviesBaseContract _movieBaseContract;

  TopRatedMoviesUsecase(this._movieBaseContract,);

  Future<Either<NetworkFailure, List<Movie>>> call() async {
    return await _movieBaseContract.getTopRatedMovies(
      fromDto: (moviesDto,) => moviesListFromDto(moviesDto,),
    );
  }
}