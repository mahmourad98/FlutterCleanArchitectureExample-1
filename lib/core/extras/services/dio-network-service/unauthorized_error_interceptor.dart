import 'dart:io';
import 'package:dio/dio.dart';
import 'package:untitled05/core/extras/helpers/network_helper_methods.dart';
import 'package:untitled05/core/extras/services/app-navigation-service/app_navigation_service.dart';
import 'package:untitled05/core/layers/presentation/pages/splash-page/splash_page_view.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class UnauthorizedErrorInterceptor extends QueuedInterceptor {
  final Dio dio;
  /////////////////////////
  UnauthorizedErrorInterceptor({required this.dio,});
  /////////////////////////
  @override
  void onError(DioError err, ErrorInterceptorHandler handler,) async {
    if (err.response == null) return;
    if (err.response!.statusCode == HttpStatus.unauthorized) {
      final tokenRefreshed = await refreshToken();
      if (tokenRefreshed != null) {
        updateTokenInHeaders(err.requestOptions.headers, tokenRefreshed,);
        _retry(err.requestOptions,);
      }
      else {
        serviceLocator<AppNavigationService>().clearStackAndShow(routeName: SplashPageView.routeName,);
        return handler.reject(DioError(requestOptions: err.requestOptions,),);
      }
    }
    return handler.next(err,);
  }
  /////////////////////////
  Future<String?> refreshToken() async {
    try {
      //ToDo: Update Your Token Here
      // final tokenResult = await dio.get<dynamic>(Urls.refreshToken,);
      // final tokeResponse = RefreshTokeResponse.fromJson(tokenResult.data!['data'],);
      // if (tokeResponse.accessToken == null || tokeResponse.accessToken!.isEmpty) throw Exception();
      // return tokeResponse.accessToken!;
      return null;
    } catch (e) {
      return null;
    }
  }
  /////////////////////////
  Future<Response<dynamic>> _retry(RequestOptions requestOptions,) async {
    return await dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      cancelToken: requestOptions.cancelToken,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      options: copyOptions(requestOptions,),
    );
  }
}
