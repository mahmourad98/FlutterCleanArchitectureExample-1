import 'package:dartz/dartz.dart';
import 'package:untitled05/core/data/data-models/movies/movies_dto.dart' as movies_dto;
import 'package:untitled05/core/domain/contracts/movies_base_contract.dart';
import 'package:untitled05/core/domain/entities/movie-model/movie.dart';

abstract class MoviesBaseUsecase {
  List<Movie> moviesListFromDto(movies_dto.MoviesDto dto,) {
    final list = dto.results ?? <movies_dto.Movie>[];
    return List.generate(list.length, (index,) => Movie.from(list[index],),);
  }
  ////////////////////
  Future<Either<dynamic, List<Movie>>> call();
}

class NowPlayingMoviesUsecase extends MoviesBaseUsecase {
  final MoviesBaseContract _movieBaseContract;
  ////////////////////
  NowPlayingMoviesUsecase(this._movieBaseContract,);
  ////////////////////
  @override
  Future<Either<dynamic, List<Movie>>> call() async {
    return await _movieBaseContract.getNowPlayingMovies().then(
      (value,) => value.fold(
        (l,) => Left(l,),
        (movies_dto.MoviesDto r,) => Right(moviesListFromDto(r,),),
      ),
    );
  }
}

class MostPopularMoviesUsecase extends MoviesBaseUsecase {
  final MoviesBaseContract _movieBaseContract;
  ////////////////////
  MostPopularMoviesUsecase(this._movieBaseContract,);
  ////////////////////
  @override
  Future<Either<dynamic, List<Movie>>> call() async {
    return await _movieBaseContract.getMostPopularMovies().then(
      (value,) => value.fold(
        (l,) => Left(l,),
        (movies_dto.MoviesDto r,) => Right(moviesListFromDto(r,),),
      ),
    );
  }
}

class TopRatedMoviesUsecase extends MoviesBaseUsecase {
  final MoviesBaseContract _movieBaseContract;
  ////////////////////
  TopRatedMoviesUsecase(this._movieBaseContract,);
  ////////////////////
  @override
  Future<Either<dynamic, List<Movie>>> call() async {
    return await _movieBaseContract.getTopRatedMovies().then(
      (value,) => value.fold(
        (l,) => Left(l,),
        (movies_dto.MoviesDto r,) => Right(moviesListFromDto(r,),),
      ),
    );
  }
}