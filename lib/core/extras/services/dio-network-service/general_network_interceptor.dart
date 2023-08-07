import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled05/config/shared_prefs_keys.dart';
import 'package:untitled05/config/supported_languages.dart';
import 'package:untitled05/core/extras/services/app-localization-service/app_localization_service.dart';
import 'package:untitled05/core/extras/services/app-navigation-service/app_navigation_service.dart';
import 'package:untitled05/core/layers/presentation/pages/splash-page/splash_page_view.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class GeneralRequestAndResponseInterceptor extends Interceptor {
  final Dio dio;
  /////////////////////////
  GeneralRequestAndResponseInterceptor({required this.dio,});
  /////////////////////////
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(SharedPrefsKeys.ACCESS_TOKEN,);
    final local = serviceLocator<AppLocalizationService>().currentLocale;
    if (local.languageCode.isEmpty) {
      options.headers["locale"] = SupportedLanguage.languageCodes.first;
    }
    else {
      options.headers["locale"] = local.languageCode;
    }
    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }
    return handler.next(options,);
  }
  /////////////////////////
  @override
  void onResponse(Response<Object?> response, ResponseInterceptorHandler handler,) async {
    if (response.statusCode == HttpStatus.unauthorized) {
      try{
        //ToDo: Update Your Token Here
        //final prefs = await SharedPreferences.getInstance();
        //final token = prefs.getString(SharedPrefsKeys.ACCESS_TOKEN,);
        //if (token == null || token.isEmpty) throw Exception("could-not-revoke-token",);
        //final otherResponse = await dio.get<dynamic>("/revokeAccessToken",);
        //if (otherResponse.statusCode != HttpStatus.ok) throw Exception("could-not-revoke-token",);
        //response.headers.add("Authorization", "Bearer ${newAccessToken!}",);
        return handler.resolve(response,);
      } catch (e) {
        serviceLocator<AppNavigationService>().clearStackAndShow(routeName: SplashPageView.routeName,);
        return handler.reject(DioError(requestOptions: response.requestOptions,),);
      }
    }
    return handler.next(response,);
  }
  /////////////////////////
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      serviceLocator<AppNavigationService>().clearStackAndShow(routeName: SplashPageView.routeName,);
      return handler.reject(DioError(requestOptions: err.response!.requestOptions,),);
    }
    return handler.next(err,);
  }
}