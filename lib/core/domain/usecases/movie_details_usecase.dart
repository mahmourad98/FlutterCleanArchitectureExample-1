import 'package:dartz/dartz.dart';
import 'package:untitled05/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/data/data-models/movie-details/movie_details_dto.dart';
import 'package:untitled05/core/domain/contracts/movie_details_base_contract.dart';
import 'package:untitled05/core/domain/entities/movie-details-model/movie_details.dart';

abstract class MovieDetailsBaseUsecase {
  Future<Either<dynamic, MovieDetails>> call(int movieId,);
}

class SingleMovieDetailsUsecase extends MovieDetailsBaseUsecase {
  final MovieDetailsBaseContract _movieDetailsBaseContract;
  ////////////////////
  SingleMovieDetailsUsecase(this._movieDetailsBaseContract,);
  ////////////////////
  @override
  Future<Either<dynamic, MovieDetails>> call(int movieId,) async {
    return await _movieDetailsBaseContract.getMovieDetails(movieId: movieId,).then(
      (value,) => value.fold(
        (l,) => Left(l,),
        (MovieDetailsDto r,) => Right(MovieDetails.from(r,),),
      ),
    );
  }
}