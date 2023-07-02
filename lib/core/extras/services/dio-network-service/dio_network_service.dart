import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:open_file/open_file.dart' as open_file;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:untitled05/core/extras/helpers/common_response_model_helper.dart';
import 'package:untitled05/core/extras/services/dio-network-service/common-response-model/common_response_model.dart';
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/out-buildings/app_environment.dart';
import 'package:untitled05/out-buildings/app_logger.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class DioNetworkService {
  ///ignore: constant_identifier_names
  static const CLASS_NAME = "DioNetworkService";

  static const _jsonDecoder = JsonDecoder();
  static const _jsonEncoder = JsonEncoder();

  ///APP ENVIRONMENT
  AppEnvironment get _env => serviceLocator<AppEnvironment>();

  ///DIO VARIABLES
  late final Dio _dio;
  Dio get dio => _dio;

  ///BASE OPTIONS
  final BaseOptions _baseOptions = BaseOptions(
    connectTimeout: 60000,
    sendTimeout: 60000,
    receiveTimeout: 60000,
  );

  ///INTERCEPTORS
  List<Interceptor> get _interceptors => [
    PrettyDioLogger(requestBody: true, requestHeader: true, responseBody: true, responseHeader: true,),
    RequestsInspectorInterceptor(),
  ];

  ///INTERCEPTOR WRAPPER
  InterceptorsWrapper get _interceptorWrapper => InterceptorsWrapper(
    onRequest: (options, handler,) async {
      return handler.next(options,);
    },
    onResponse: (response, handler,) async {
      return handler.next(response,);
    },
    onError: (DioError e, handler,) async {
      return handler.next(e,);
    },
  );

  ///CACHE OPTIONS
  CacheOptions get firstCacheOptions => CacheOptions(store: MemCacheStore(), hitCacheOnErrorExcept: [],);
  DioCacheManager get secondCacheOptions => DioCacheManager(CacheConfig(),);

  DioNetworkService() {
    _dio = Dio();
    _baseOptions.baseUrl = _env.environmentType.apiUrl;
    if (_env.environmentType.isDebugMode()) {
      _dio.interceptors.addAll(
        [..._interceptors, _interceptorWrapper, DioCacheInterceptor(options: firstCacheOptions,), secondCacheOptions.interceptor,],
      );
    }
    _dio.options = _baseOptions;
  }

  Future<T> postHttp<T>({
    required String url, required Map<String, dynamic> body,
    List<Interceptor>? interceptors, Options? options,
  }) async {
    ///Add request interceptors [interceptors]
    if (interceptors != null) _dio.interceptors.addAll(interceptors,);
    ///firing the request
    late Response response;
    try {
      response = await _dio.post<T>(
        url,
        data: jsonEncode(body,),
        options: options,
      );
      final CommonResponse commonResponse = CommonResponse.fromJson(responseConverter(response.statusCode, response.data,),);
      if (commonResponse.status ?? false) {
        return (commonResponse.data?.value ?? {}) as T;
      } else {
        return throw NetworkFailure<dynamic>(NetworkFailureType.serverError, commonResponse.errors,);
      }
    } catch (e) {
      e.exceptionErrorLog(CLASS_NAME,);
      ///All exceptions when using Dio, must be dio-error
      if (e is SocketException || e is WebSocketException) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.offline, e,);
      } else if(e is DioError && e.type == DioErrorType.connectTimeout) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.connectionTimeOut, e,);
      }
      ///return Either-Left
      return throw NetworkFailure<dynamic>(NetworkFailureType.unknown, e,);
    }
  }

  Future<T> multiPartPostHttp<T>({
    required String url, required FormData formData,
    List<Interceptor>? interceptors, Options? options,
    void Function(int, int,)? onSendProgress,
  }) async {
    ///Add request interceptors [interceptors]
    if (interceptors != null) _dio.interceptors.addAll(interceptors,);
    ///firing the request
    late Response response;
    try {
      response = await _dio.post<T>(
        url,
        data: formData,
        options: options,
        onSendProgress: onSendProgress,
      );
      final CommonResponse commonResponse = CommonResponse.fromJson(responseConverter(response.statusCode, response.data,),);
      if (commonResponse.status ?? false) {
        return (commonResponse.data?.value ?? {}) as T;
      } else {
        return throw NetworkFailure<dynamic>(NetworkFailureType.serverError, commonResponse.errors,);
      }
    } catch (e) {
      e.exceptionErrorLog(CLASS_NAME,);
      ///All exceptions when using Dio, must be dio-error
      if (e is SocketException || e is WebSocketException) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.offline, e,);
      } else if(e is DioError && e.type == DioErrorType.connectTimeout) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.connectionTimeOut, e,);
      }
      ///return Either-Left
      return throw NetworkFailure<dynamic>(NetworkFailureType.unknown, e,);
    }
  }

  Future<T> getHttp<T>({
    required String url, List<Interceptor>? interceptors, Options? options,
  }) async {
    /// Add request interceptors [interceptors]
    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors,);
    }

    ///firing the request
    late Response response;
    try {
      response = await _dio.get<T>(
        url,
        options: options,
      );
      final CommonResponse commonResponse = CommonResponse.fromJson(responseConverter(response.statusCode, response.data,),);
      if (commonResponse.status ?? false) {
        return (commonResponse.data?.value ?? {}) as T;
      } else {
        return throw NetworkFailure<dynamic>(NetworkFailureType.serverError, commonResponse.errors,);
      }
    } catch (e) {
      e.exceptionErrorLog(CLASS_NAME,);
      ///All exceptions when using Dio, must be dio-error
      if (e is SocketException || e is WebSocketException) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.offline, e,);
      } else if(e is DioError && e.type == DioErrorType.connectTimeout) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.connectionTimeOut, e,);
      }
      ///return Either-Left
      return throw NetworkFailure<dynamic>(NetworkFailureType.unknown, e,);
    }
  }

  Future<bool> downloadFile({
    required String url, required String fileName,
    List<Interceptor>? interceptors,
    void Function(int, int,)? onReceiveProgress,
  }) async {
    /// Add request interceptors [interceptors]
    try {
      ///ADDING INTERCEPTORS
      if (interceptors != null) _dio.interceptors.addAll(interceptors,);
      ///Get temp directory
      final dir = await path_provider.getApplicationDocumentsDirectory();
      ///get directory for downloads
      final downloadDir = await Directory('${dir.path}/downloads',).create(recursive: true,);
      ///create full file name
      final newFileName = fileName.replaceAll(" ", "-",);
      final fileExtension = path.extension(url,);
      ///Path you need to store this file and open it
      final fileInfo = "${downloadDir.path}/$newFileName$fileExtension";
      await _dio.download(url, fileInfo, onReceiveProgress: onReceiveProgress,);
      final file = File(fileInfo,);
      if (await file.exists()) {
        if(Platform.isAndroid) await open_file.OpenFile.open(fileInfo,);
        if(Platform.isIOS) await open_file.OpenFile.open(fileInfo,);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      ///All exceptions when using Dio, must be dio-error
      if (e is DioError) e.exceptionErrorLog(CLASS_NAME,);
      return false;
    }
  }
}
