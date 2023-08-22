import 'dart:io';
import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled05/extras/constants/app_constants.dart';
import 'package:untitled05/extras/constants/params_constants.dart';
import 'package:untitled05/extras/helpers/remote_data_source_helper.dart';
import 'package:untitled05/core/data/data-models/common-response-model/common_response_model.dart';
import 'package:untitled05/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/extras/services/dio-network-service/dio_network_service.dart';
import 'package:untitled05/core/data/data-sources/movie-details/movie_details_base_data_source.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class MovieDetailsRemoteDataSource extends MovieDetailsBaseDataSource with RemoteDataSourceHelper {
  final DioNetworkService _networkService = serviceLocator<DioNetworkService>();
  ////////////////////
  MovieDetailsRemoteDataSource();
  ////////////////////
  @override
  Future<Either<dynamic, CommonResponse>> getMovieDetails({
    required int movieId, bool localRequest = false, bool authRequest = false
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
          url: "${AppConstants.MOVIES_API_BASE_URL}${MovieDetailsEndPoint.MOVIE_DETAILS(movieId,)}",
          params: {
            ParamsConstants.API_KEY: AppConstants.MOVIES_API_KEY,
          },
        ),
        options: Options(headers: allHeaders,),
      );
      final commonResponse = CommonResponse.fromJson(result,);
      return Right(commonResponse,);
    } on NetworkError catch (error) {
      return Left(error,);
    } on NetworkFailure catch (failure) {
      return Left(failure,);
    } catch (error) {
      return Left(error,);
    }
  }
}