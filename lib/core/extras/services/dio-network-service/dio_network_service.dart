//ignore_for_file: constant_identifier_names
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
import 'package:untitled05/core/extras/services/dio-network-service/dio_network_errors.dart';
import 'package:untitled05/core/extras/services/dio-network-service/general_network_interceptor.dart';
import 'package:untitled05/out-buildings/app_environment.dart';
import 'package:untitled05/out-buildings/app_logger.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';

class DioNetworkService {
  static const CLASS_NAME = "DioNetworkService";
  /////////////////////////
  static const _jsonDecoder = JsonDecoder();
  static const _jsonEncoder = JsonEncoder();
  /////////////////////////
  final Dio _dio;
  Dio get dio => _dio;
  ///DEFAULT CONSTRUCTOR
  DioNetworkService.create(this._dio,){
    _dio.options = _baseOptions;
    _dio.interceptors.addAll(_cacheInterceptors,);
    _dio.interceptors.addAll(_interceptors,);
  }
  ///FACTORY CONSTRUCTOR - USE ONLY WHEN YOU NEED TO CREATE A NEW INSTANCE OF THIS CLASS ON EVERY CALL
  factory DioNetworkService.insert([Dio? dio,]) {
    final obj = DioNetworkService.create(dio ?? Dio(),);
    return obj;
  }
  ///APP ENVIRONMENT
  AppEnvironment get _env => serviceLocator<AppEnvironment>();
  ///BASE OPTIONS
  late final BaseOptions _baseOptions = BaseOptions(
    baseUrl: _env.environmentType.apiUrl,
    connectTimeout: 60000,
    sendTimeout: 60000,
    receiveTimeout: 60000,
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
    validateStatus: (int? status,) => (status != null),
    receiveDataWhenStatusError: true,
    setRequestContentTypeWhenNoPayload: true,
  );
  ///INTERCEPTORS
  late final List<Interceptor> _interceptors = [
    PrettyDioLogger(requestBody: true, requestHeader: true, responseBody: true, responseHeader: true,),
    RequestsInspectorInterceptor(),
    GeneralRequestAndResponseInterceptor(dio: dio,),
  ];
  ///CACHE INTERCEPTORS
  late final List<Interceptor> _cacheInterceptors = [
    DioCacheInterceptor(options: CacheOptions(store: MemCacheStore(), hitCacheOnErrorExcept: [],),),
    DioCacheManager(CacheConfig(),).interceptor,
  ];
  ///POST HTTP
  Future<Map<String, dynamic>> postHttp<T>({
    required String url, required Map<String, dynamic> body,
    List<Interceptor>? interceptors, Options? options, Map<String, dynamic>? queryParameters,
  }) async {
    ///ADD REQUEST INTERCEPTORS
    if (interceptors != null) _dio.interceptors.addAll(interceptors,);
    ///FIRING REQUEST
    late Response response;
    try {
      response = await _dio.post<T>(
        url,
        data: _jsonEncoder.convert(body,),
        queryParameters: queryParameters,
        options: options,
        onSendProgress: null,
      );
    }
    ///NETWORK FAILURE
    catch (e) {
      e.exceptionErrorLog(CLASS_NAME,);
      if (e is DioError && (e.error is SocketException || e.error is WebSocketException)) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.offline, e,);
      }
      else if(e is DioError && (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout)) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.connectionTimeOut, e.error,);
      }
      else if(e is DioError && e.type == DioErrorType.cancel) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.cancelled, e,);
      }
      else {
        return throw NetworkFailure<dynamic>(NetworkFailureType.unknown, e,);
      }
    }
    ///NETWORK SUCCESS
    if(response.statusCode?.responseType == null) {
      final result = responseConverter(response.statusCode, response.data,);
      return result;
    }
    ///NETWORK ERROR
    else {
      return throw NetworkError(response.statusCode!.responseType!, response.data,);
    }
  }
  ///POST HTTP WITH FILE
  Future<Map<String, dynamic>> multiPartPostHttp<T>({
    required String url, required Map<String, dynamic> body,
    List<Interceptor>? interceptors, Options? options, Map<String, dynamic>? queryParameters,
    void Function(int, int,)? onSendProgress,
  }) async {
    ///ADD REQUEST INTERCEPTORS
    if (interceptors != null) _dio.interceptors.addAll(interceptors,);
    ///FIRING REQUEST
    late Response response;
    try {
      response = await _dio.post<T>(
        url,
        data: FormData.fromMap(body,),
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
      );
    }
    ///NETWORK FAILURE
    catch (e) {
      e.exceptionErrorLog(CLASS_NAME,);
      if (e is DioError && (e.error is SocketException || e.error is WebSocketException)) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.offline, e,);
      }
      else if(e is DioError && (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout)) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.connectionTimeOut, e.error,);
      }
      else if(e is DioError && e.type == DioErrorType.cancel) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.cancelled, e,);
      }
      else {
        return throw NetworkFailure<dynamic>(NetworkFailureType.unknown, e,);
      }
    }
    ///NETWORK SUCCESS
    if(response.statusCode?.responseType == null) {
      final result = responseConverter(response.statusCode, response.data,);
      return result;
    }
    ///NETWORK ERROR
    else {
      return throw NetworkError(response.statusCode!.responseType!, response.data,);
    }
  }
  ///PUT HTTP
  Future<Map<String, dynamic>> putHttp<T>({
    required String url, required Map<String, dynamic> body,
    List<Interceptor>? interceptors, Options? options, Map<String, dynamic>? queryParameters,
  }) async {
    ///ADD REQUEST INTERCEPTORS
    if (interceptors != null) _dio.interceptors.addAll(interceptors,);
    ///FIRING REQUEST
    late Response response;
    try {
      response = await _dio.put<T>(
        url,
        data: _jsonEncoder.convert(body,),
        queryParameters: queryParameters,
        options: options,
        onSendProgress: null,
      );
    }
    ///NETWORK FAILURE
    catch (e) {
      e.exceptionErrorLog(CLASS_NAME,);
      if (e is DioError && (e.error is SocketException || e.error is WebSocketException)) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.offline, e,);
      }
      else if(e is DioError && (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout)) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.connectionTimeOut, e.error,);
      }
      else if(e is DioError && e.type == DioErrorType.cancel) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.cancelled, e,);
      }
      else {
        return throw NetworkFailure<dynamic>(NetworkFailureType.unknown, e,);
      }
    }
    ///NETWORK SUCCESS
    if(response.statusCode?.responseType == null) {
      final result = responseConverter(response.statusCode, response.data,);
      return result;
    }
    ///NETWORK ERROR
    else {
      return throw NetworkError(response.statusCode!.responseType!, response.data,);
    }
  }
  ///GET HTTP
  Future<Map<String, dynamic>> getHttp<T>({
    required String url,
    List<Interceptor>? interceptors, Options? options,  Map<String, dynamic>? queryParameters,
  }) async {
    ///ADD REQUEST INTERCEPTORS
    if (interceptors != null) _dio.interceptors.addAll(interceptors,);
    ///FIRING REQUEST
    late Response response;
    try {
      response = await _dio.get<T>(
        url,
        options: options,
        queryParameters: queryParameters,
      );
    }
    ///NETWORK FAILURE
    catch (e) {
      e.exceptionErrorLog(CLASS_NAME,);
      if (e is DioError && (e.error is SocketException || e.error is WebSocketException)) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.offline, e,);
      }
      else if(e is DioError && (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout)) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.connectionTimeOut, e.error,);
      }
      else if(e is DioError && e.type == DioErrorType.cancel) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.cancelled, e,);
      }
      else {
        return throw NetworkFailure<dynamic>(NetworkFailureType.unknown, e,);
      }
    }
    ///NETWORK SUCCESS
    if(response.statusCode?.responseType == null) {
      final result = responseConverter(response.statusCode, response.data,);
      return result;
    }
    ///NETWORK ERROR
    else {
      return throw NetworkError(response.statusCode!.responseType!, response.data,);
    }
  }
  ///DELETE HTTP
  Future<Map<String, dynamic>> deleteHttp<T>({
    required String url,
    List<Interceptor>? interceptors, Options? options,  Map<String, dynamic>? queryParameters,
  }) async {
    ///ADD REQUEST INTERCEPTORS
    if (interceptors != null) _dio.interceptors.addAll(interceptors,);
    ///FIRING REQUEST
    late Response response;
    try {
      response = await _dio.delete<T>(
        url,
        options: options,
        queryParameters: queryParameters,
      );
    }
    ///NETWORK FAILURE
    catch (e) {
      e.exceptionErrorLog(CLASS_NAME,);
      if (e is DioError && (e.error is SocketException || e.error is WebSocketException)) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.offline, e,);
      }
      else if(e is DioError && (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout)) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.connectionTimeOut, e.error,);
      }
      else if(e is DioError && e.type == DioErrorType.cancel) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.cancelled, e,);
      }
      else {
        return throw NetworkFailure<dynamic>(NetworkFailureType.unknown, e,);
      }
    }
    ///NETWORK SUCCESS
    if(response.statusCode?.responseType == null) {
      final result = responseConverter(response.statusCode, response.data,);
      return result;
    }
    ///NETWORK ERROR
    else {
      return throw NetworkError(response.statusCode!.responseType!, response.data,);
    }
  }
  ///DOWNLOAD FILE
  Future<bool> downloadFile({
    required String url, required String fileName,
    List<Interceptor>? interceptors, Options? options,  Map<String, dynamic>? queryParameters,
    void Function(int, int,)? onReceiveProgress,
  }) async {
    ///ADDING INTERCEPTORS
    if (interceptors != null) _dio.interceptors.addAll(interceptors,);
    late Response response;
    try {
      ///GETTING DOWNLOAD DIRECTORY + FILE INFO
      final dir = await path_provider.getApplicationDocumentsDirectory();
      final downloadDir = await Directory('${dir.path}/downloads',).create(recursive: true,);
      final newFileName = fileName.replaceAll(" ", "-",);
      final fileExtension = path.extension(url,);
      final fileInfo = "${downloadDir.path}/$newFileName$fileExtension";
      ///FIRING REQUEST
      response = await _dio.download(
        url,
        fileInfo,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onReceiveProgress,
      );
      final file = File(fileInfo,);
      if (await file.exists()) {
        if(Platform.isAndroid) await open_file.OpenFile.open(fileInfo,);
        if(Platform.isIOS) await open_file.OpenFile.open(fileInfo,);
        return true;
      }
      else {
        return false;
      }
    }
    ///NETWORK FAILURE
    catch (e) {
      e.exceptionErrorLog(CLASS_NAME,);
      if (e is DioError && (e.error is SocketException || e.error is WebSocketException)) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.offline, e,);
      }
      else if(e is DioError && (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout)) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.connectionTimeOut, e.error,);
      }
      else if(e is DioError && e.type == DioErrorType.cancel) {
        return throw NetworkFailure<dynamic>(NetworkFailureType.cancelled, e,);
      }
      else {
        return throw NetworkFailure<dynamic>(NetworkFailureType.unknown, e,);
      }
    }
  }
}
