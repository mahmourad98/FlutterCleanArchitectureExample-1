import 'package:dio/dio.dart';

Options copyOptions(RequestOptions requestOptions,) {
  final options = Options(
    method: requestOptions.method,
    headers: requestOptions.headers,
    responseType: requestOptions.responseType,
    contentType: requestOptions.contentType,
    extra: requestOptions.extra,
    sendTimeout: requestOptions.sendTimeout,
    receiveTimeout: requestOptions.receiveTimeout,
    validateStatus: requestOptions.validateStatus,
    receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
    followRedirects: requestOptions.followRedirects,
    maxRedirects: requestOptions.maxRedirects,
    requestEncoder: requestOptions.requestEncoder,
    responseDecoder: requestOptions.responseDecoder,
    listFormat: requestOptions.listFormat,
  );
  return options;
}

void updateTokenInHeaders(Map<String, dynamic> headers, String token,) {
  headers['Authorization'] = "Bearer $token";
}