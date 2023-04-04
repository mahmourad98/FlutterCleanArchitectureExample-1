import 'package:dartz/dartz.dart';
import 'package:untitled05/core/extras/helpers/usecase-helpers/movies_usecase_helper.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/layers/domain/contracts/movies_base_contract.dart';
import 'package:untitled05/core/layers/domain/entities/movie-model/movie.dart';

class NowPlayingMoviesUsecase extends MoviesBaseUsecase {
  final MoviesBaseContract _movieBaseContract;

  NowPlayingMoviesUsecase(this._movieBaseContract,);

  @override
  Future<Either<NetworkFailure, List<Movie>>> call() async {
    return await _movieBaseContract.getNowPlayingMovies(
      fromDto: (moviesDto,) => moviesListFromDto(moviesDto,),
    );
  }
}

class MostPopularMoviesUsecase extends MoviesBaseUsecase {
  final MoviesBaseContract _movieBaseContract;

  MostPopularMoviesUsecase(this._movieBaseContract,);

  @override
  Future<Either<NetworkFailure, List<Movie>>> call() async {
    return await _movieBaseContract.getMostPopularMovies(
      fromDto: (moviesDto,) => moviesListFromDto(moviesDto,),
    );
  }
}

class TopRatedMoviesUsecase extends MoviesBaseUsecase {
  final MoviesBaseContract _movieBaseContract;

  TopRatedMoviesUsecase(this._movieBaseContract,);

  @override
  Future<Either<NetworkFailure, List<Movie>>> call() async {
    return await _movieBaseContract.getTopRatedMovies(
      fromDto: (moviesDto,) => moviesListFromDto(moviesDto,),
    );
  }
}