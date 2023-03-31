import 'dart:io';

Map<String, dynamic> responseConverter(int? statusCode, dynamic dataOrErrors,) {
  final isNotSuccessful = statusCode != HttpStatus.ok;
  if(isNotSuccessful) {
    final data = <String, dynamic>{};
    data['status'] = false;
    data['data'] = null;
    data['errors'] = dataOrErrors;
    return data;
  }
  final result = <String, dynamic>{
    "status": true,
    "data": dataOrErrors,
    "errors": null,
  };
  return result;
}