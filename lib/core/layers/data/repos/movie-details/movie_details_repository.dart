import 'package:dartz/dartz.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/layers/data/data-models/movie-details/movie_details_dto.dart';
import 'package:untitled05/core/layers/data/data-sources/movie-details/movie_details_base_data_source.dart';
import 'package:untitled05/core/layers/domain/contracts/movie_details_base_contract.dart';
import 'package:untitled05/core/layers/domain/entities/movie-details-model/movie_details.dart';

class MoviesRepository extends MovieDetailsBaseContract {
  final MovieDetailsBaseDataSource _movieDetailsBaseDataSource;

  MoviesRepository(this._movieDetailsBaseDataSource,);

  @override
  Future<Either<NetworkFailure, MovieDetails>> getMovieDetails({
    required int movieId, required MovieDetails Function(MovieDetailsDto,) fromDto,
  }) async {
    return await _movieDetailsBaseDataSource.getMovieDetails(movieId: movieId,).then(
      (value,) => value.fold(
        (l,) => Left(l,),
        (r,) => Right(fromDto(r,),),
      ),
    );
  }
}