enum NetworkFailureType {
  offline,
  connectionTimeOut,
  cancelled,
  unknown,
  validationError,
  clientError,
  serverError,
  noResponse,
}

extension FailureMessage on NetworkFailureType{
  String get message {
    switch (this) {
      case NetworkFailureType.offline: return "Check Your Internet Connection.";
      case NetworkFailureType.connectionTimeOut: return "Sorry, Connection Time-Outed.";
      case NetworkFailureType.cancelled: return "Sorry, Operation Was Cancelled.";
      case NetworkFailureType.unknown: return "Sorry, Some Error Occurred.";
      case NetworkFailureType.validationError: return "Sorry, Wrong Data Was Sent.";
      case NetworkFailureType.clientError: return "Sorry, You Are Not Authorized.";
      case NetworkFailureType.serverError: return "Sorry, Server Is Not Available.";
      case NetworkFailureType.noResponse: return "Sorry, Empty Response.";
    }
  }
}

extension StatusCodesResult on int {
  NetworkFailureType? get responseType {
    if (this >= 0 && this < 100) {
      return null;
    }
    else if (this >= 100 && this < 300) {
      return null;
    }
    else if (this >= 300 && this < 400) {
      return NetworkFailureType.validationError;
    }
    else if (this >= 400 && this < 500) {
      return NetworkFailureType.clientError;
    }
    else if (this >= 500 && this < 600) {
      return NetworkFailureType.serverError;
    }
    else {
      return NetworkFailureType.noResponse;
    }
  }
}

class NetworkFailure<T> implements Exception {
  final NetworkFailureType failure;
  final T error;
  NetworkFailure(this.failure, this.error,);
}

class NetworkError extends NetworkFailure<Map> {
  NetworkError(NetworkFailureType failure, Map error,) : super(failure, error,);
}