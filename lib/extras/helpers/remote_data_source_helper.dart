import 'dart:io';

import 'package:flutter/material.dart';

class RemoteDataSourceHelper {
  final headers = const <String, dynamic>{
    HttpHeaders.acceptHeader: "text/plain",
    HttpHeaders.contentTypeHeader: "application/json",
  };

  @protected
  Future<String> getAuthHeaders() async {
    return "";
  }

  String getProperUrl({required String url, Map? params, String? stringParams,}) {
    final urlBuffer = StringBuffer()..write(url,);
    ///Params object
    final allParams = {
      if (params != null) ...params,
    };
    if (allParams.isNotEmpty) {
      urlBuffer.write("?${allParams.toString().replaceAll(", ", "&",).replaceAll(": ", "=",).replaceAll("{", "",).replaceAll("}", "",)}",);
    }
    if (stringParams != null) {
      urlBuffer.write(stringParams,);
    }
    final finalUrl = urlBuffer.toString();
    return finalUrl;
  }
}