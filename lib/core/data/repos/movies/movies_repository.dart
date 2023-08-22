import 'package:dartz/dartz.dart';
import 'package:untitled05/core/data/data-models/movies/movies_dto.dart';
import 'package:untitled05/core/data/data-sources/movies/movies_base_data_source.dart';
import 'package:untitled05/core/domain/contracts/movies_base_contract.dart';

class MoviesRepository extends MoviesBaseContract {
  final MoviesBaseDataSource _moviesBaseDataSource;
  ////////////////////
  const MoviesRepository(this._moviesBaseDataSource,);
  ////////////////////
  @override
  Future<Either<dynamic, MoviesDto>> getMostPopularMovies() async{
    return await _moviesBaseDataSource.getMostPopularMovies().then(
      (value,) => value.fold(
        (l,) => Left(l,),
        (r,) => Right(MoviesDto.fromJson((r.data!.value as Map<String, dynamic>),),),
      ),
    );
  }
  ////////////////////
  @override
  Future<Either<dynamic, MoviesDto>> getNowPlayingMovies() async{
    return await _moviesBaseDataSource.getNowPlayingMovies().then(
      (value,) => value.fold(
        (l,) => Left(l,),
        (r,) => Right(MoviesDto.fromJson((r.data!.value as Map<String, dynamic>),),),
      ),
    );
  }
  ////////////////////
  @override
  Future<Either<dynamic, MoviesDto>> getTopRatedMovies() async{
    return await _moviesBaseDataSource.getTopRatedMovies().then(
      (value,) => value.fold(
        (l,) => Left(l,),
        (r,) => Right(MoviesDto.fromJson((r.data!.value as Map<String, dynamic>),),),
      ),
    );
  }

}