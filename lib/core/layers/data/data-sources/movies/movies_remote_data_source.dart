import 'dart:io';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled05/core/extras/constants/app_constants.dart';
import 'package:untitled05/core/extras/constants/params_constants.dart';
import 'package:untitled05/core/extras/helpers/remote_data_source_helper.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_service.dart';
import 'package:untitled05/core/layers/data/data-models/movies/movies_dto.dart';
import 'package:untitled05/core/layers/data/data-sources/movies/movies_base_data_source.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class MoviesRemoteDataSource extends MoviesBaseDataSource with RemoteDataSourceHelper {
  final DioNetworkService _networkService = serviceLocator<DioNetworkService>();

  @override
  Future<Either<NetworkFailure, MoviesDto>> getNowPlayingMovies({
    bool localRequest = false, bool authRequest = false,
  }) async {
    ///ADDING HEADERS TO OUR REQUEST
    Map<String, dynamic> allHeaders = Map.from(headers,);
    if (authRequest) {
      final authToken = await getAuthHeaders();
      allHeaders.putIfAbsent(HttpHeaders.authorizationHeader, () => authToken,);
    }
    if (localRequest) {
      allHeaders.putIfAbsent(HttpHeaders.acceptLanguageHeader, () => const Locale('en',).languageCode,);
    }
    try {
      final result = await _networkService.getHttp<Map<String, dynamic>>(
        url: getProperUrl(
          url: "${AppConstants.MOVIES_API_BASE_URL}${MoviesEndPoint.NOW_PLAYING}",
          params: {
            ParamsConstants.API_KEY: AppConstants.MOVIES_API_KEY,
          },
        ),
        options: Options(headers: allHeaders,),
      );
      return Right(MoviesDto.fromJson(result,),);
    } on NetworkFailure catch (failure) {
      return Left(failure,);
    }
  }

  @override
  Future<Either<NetworkFailure, MoviesDto>> getMostPopularMovies({
    bool localRequest = false, bool authRequest = false,
  }) async {
    //ADDING HEADERS TO OUR REQUEST
    Map<String, dynamic> allHeaders = Map.from(headers,);
    if (authRequest) {
      final authToken = await getAuthHeaders();
      allHeaders.putIfAbsent(HttpHeaders.authorizationHeader, () => authToken,);
    }
    if (localRequest) {
      allHeaders.putIfAbsent(HttpHeaders.acceptLanguageHeader, () => const Locale('en',).languageCode,);
    }
    try {
      final result = await _networkService.getHttp<Map<String, dynamic>>(
        url: getProperUrl(
          url: "${AppConstants.MOVIES_API_BASE_URL}${MoviesEndPoint.MOST_POPULAR}",
          params: {
            ParamsConstants.API_KEY: AppConstants.MOVIES_API_KEY,
          },
        ),
        options: Options(headers: allHeaders,),
      );
      return Right(MoviesDto.fromJson(result,),);
    } on NetworkFailure catch (failure) {
      return Left(failure,);
    }
  }

  @override
  Future<Either<NetworkFailure, MoviesDto>> getTopRatedMovies({
    bool localRequest = false, bool authRequest = false,
  }) async {
    //ADDING HEADERS TO OUR REQUEST
    Map<String, dynamic> allHeaders = Map.from(headers,);
    if (authRequest) {
      final authToken = await getAuthHeaders();
      allHeaders.putIfAbsent(HttpHeaders.authorizationHeader, () => authToken,);
    }
    if (localRequest) {
      allHeaders.putIfAbsent(HttpHeaders.acceptLanguageHeader, () => const Locale('en',).languageCode,);
    }
    try {
      final result = await _networkService.getHttp<Map<String, dynamic>>(
        url: getProperUrl(
          url: "${AppConstants.MOVIES_API_BASE_URL}${MoviesEndPoint.TOP_RATED}",
          params: {
            ParamsConstants.API_KEY: AppConstants.MOVIES_API_KEY,
          },
        ),
        options: Options(headers: allHeaders,),
      );
      return Right(MoviesDto.fromJson(result,),);
    } on NetworkFailure catch (failure) {
      return Left(failure,);
    }
  }

}