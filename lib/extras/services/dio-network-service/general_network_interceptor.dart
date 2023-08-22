import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled05/config/shared_prefs_keys.dart';
import 'package:untitled05/config/supported_languages.dart';
import 'package:untitled05/extras/services/app-localization-service/app_localization_service.dart';
import 'package:untitled05/extras/services/app-navigation-service/app_navigation_service.dart';
import 'package:untitled05/core/presentation/pages/splash-page/splash_page_view.dart';
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
      options.headers[HttpHeaders.acceptLanguageHeader] = SupportedLanguage.languageCodes.first;
    }
    else {
      options.headers[HttpHeaders.acceptLanguageHeader] = local.languageCode;
    }
    if (token != null && token.isNotEmpty) {
      options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
    }
    return handler.next(options,);
  }
  /////////////////////////
  @override
  void onResponse(Response<Object?> response, ResponseInterceptorHandler handler,) async {
    return super.onResponse(response, handler,);
  }
  /////////////////////////
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.error is IOException || err.error is SocketException || err.error is WebSocketException) {
      return handler.reject(
        DioError(
          requestOptions: err.requestOptions, response: err.response, error: err, type: DioErrorType.other,
        ),
      );
    }
    else if (err.error is TimeoutException) {
      return handler.reject(
        DioError(
          requestOptions: err.requestOptions, response: err.response, error: err, type: DioErrorType.connectTimeout,
        ),
      );
    }
    return handler.next(err,);
  }
}