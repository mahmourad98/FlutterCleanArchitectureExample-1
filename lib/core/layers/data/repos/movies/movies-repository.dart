import 'package:dartz/dartz.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/layers/data/data-models/movies/movies_dto.dart' as movies_dto;
import 'package:untitled05/core/layers/data/data-sources/movies/movies_base_data_source.dart';
import 'package:untitled05/core/layers/domain/contracts/movies_base_contract.dart';
import 'package:untitled05/core/layers/domain/entities/movie-model/movie.dart';

class MoviesRepository extends MoviesBaseContract {
  final MoviesBaseDataSource _moviesBaseDataSource;

  MoviesRepository(this._moviesBaseDataSource,);

  @override
  Future<Either<NetworkFailure, List<Movie>>> getMostPopularMovies({required List<Movie> Function(movies_dto.MoviesDto dto) fromDto,}) async {
    return await _moviesBaseDataSource.getMostPopularMovies().then(
      (value,) => value.fold(
        (l,) => Left(l,),
        (r,) => Right(fromDto(r,),),
      ),
    );
  }

  @override
  Future<Either<NetworkFailure, List<Movie>>> getNowPlayingMovies({required List<Movie> Function(movies_dto.MoviesDto dto) fromDto,}) async {
    return await _moviesBaseDataSource.getNowPlayingMovies().then(
      (value,) => value.fold(
        (l,) => Left(l,),
        (r,) => Right(fromDto(r,),),
      ),
    );
  }

  @override
  Future<Either<NetworkFailure, List<Movie>>> getTopRatedMovies({required List<Movie> Function(movies_dto.MoviesDto dto) fromDto,}) async {
    return await _moviesBaseDataSource.getTopRatedMovies().then(
      (value,) => value.fold(
        (l,) => Left(l,),
        (r,) => Right(fromDto(r,),),
      ),
    );
  }

}