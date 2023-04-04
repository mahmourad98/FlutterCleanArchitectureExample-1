import 'package:dartz/dartz.dart';
import 'package:untitled05/core/extras/helpers/usecase-helpers/movie_details_usecase_helper.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/layers/domain/contracts/movie_details_base_contract.dart';
import 'package:untitled05/core/layers/domain/entities/movie-details-model/movie_details.dart';

class SingleMovieDetailsUsecase extends MovieDetailsBaseUsecase {
  final MovieDetailsBaseContract _movieDetailsBaseContract;

  SingleMovieDetailsUsecase(this._movieDetailsBaseContract,);

  @override
  Future<Either<NetworkFailure, MovieDetails>> call({required int movieId,}) async {
    return await _movieDetailsBaseContract.getMovieDetails(
      movieId: movieId, fromDto: (movieDetailsDto,) => MovieDetails.from(movieDetailsDto,),
    );
  }

}