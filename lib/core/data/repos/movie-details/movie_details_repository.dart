import 'package:dartz/dartz.dart';
import 'package:untitled05/core/data/data-models/common-response-model/common_response_model.dart';
import 'package:untitled05/core/data/data-models/movie-details/movie_details_dto.dart';
import 'package:untitled05/core/data/data-sources/movie-details/movie_details_base_data_source.dart';
import 'package:untitled05/core/domain/contracts/movie_details_base_contract.dart';

class MovieDetailsRepository extends MovieDetailsBaseContract {
  final MovieDetailsBaseDataSource _movieDetailsBaseDataSource;
  ////////////////////
  MovieDetailsRepository(this._movieDetailsBaseDataSource,);
  ////////////////////
  @override
  Future<Either<dynamic, MovieDetailsDto>> getMovieDetails({required int movieId,}) async{
    return await _movieDetailsBaseDataSource.getMovieDetails(movieId: movieId,).then(
      (value,) => value.fold(
        (l,) => Left(l,),
        (CommonResponse r,) => Right(MovieDetailsDto.fromJson((r.data!.value as Map<String, dynamic>),),),
      ),
    );
  }
}