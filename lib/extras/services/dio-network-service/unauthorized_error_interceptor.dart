import 'dart:io';
import 'package:dio/dio.dart';
import 'package:untitled05/extras/helpers/network_helper_methods.dart';
import 'package:untitled05/extras/services/app-navigation-service/app_navigation_service.dart';
import 'package:untitled05/core/presentation/pages/splash-page/splash_page_view.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class UnauthorizedErrorInterceptor extends QueuedInterceptor {
  final Dio dio;
  /////////////////////////
  UnauthorizedErrorInterceptor({required this.dio,});
  /////////////////////////
  @override void onRequest(RequestOptions options, RequestInterceptorHandler handler,) async{
    return super.onRequest(options, handler,);
  }
  /////////////////////////
  @override void onResponse(Response response, ResponseInterceptorHandler handler,) async{
    if (response.statusCode == HttpStatus.unauthorized) {
      final tokenRefreshed = await refreshToken();
      if (tokenRefreshed != null) {
        updateTokenInHeaders(response.requestOptions.headers, tokenRefreshed,);
        final otherResponse =  await _retry(response.requestOptions,);
        return handler.resolve(otherResponse,);
      }
      else {
        if(serviceLocator<AppNavigationService>().currentRouteName != SplashPageView.routeName){
          serviceLocator<AppNavigationService>().clearStackAndShow(routeName: SplashPageView.routeName,);
        }
        return super.onResponse(response, handler,);
      }
    }
    return handler.next(response,);
  }
  /////////////////////////
  @override
  void onError(DioError err, ErrorInterceptorHandler handler,) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      if(serviceLocator<AppNavigationService>().currentRouteName != SplashPageView.routeName){
        serviceLocator<AppNavigationService>().clearStackAndShow(routeName: SplashPageView.routeName,);
      }
      return handler.reject(
        DioError(
          requestOptions: err.response!.requestOptions,
          response: err.response,
          error: err,
          type: DioErrorType.response,
        ),
      );
    }
    return handler.next(err,);
  }
  /////////////////////////
  Future<String?> refreshToken() async {
    try {
      //ToDo: Update Your Token Here
      // final tokenResult = await dio.get<dynamic>(Urls.refreshToken,);
      // final tokeResponse = RefreshTokeResponse.fromJson(tokenResult.data!['data'],);
      // if (tokeResponse.accessToken == null || tokeResponse.accessToken!.isEmpty) {
      //   throw DioError(requestOptions: tokenResult.requestOptions,);
      // }
      // { (await SharedPreferences.getInstance()).setString(SharedPrefsKeys.TOKEN, tokeResponse.accessToken!,); }
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
