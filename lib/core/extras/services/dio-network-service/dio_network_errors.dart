enum NetworkFailureType { offline, serverError, connectionTimeOut, unknown,}

extension FailureMessage on NetworkFailureType{
  String get message {
    switch (this) {
      case NetworkFailureType.offline: return "Check Your Internet Connection.";
      case NetworkFailureType.serverError: return "Sorry, Server Is Not Available.";
      case NetworkFailureType.connectionTimeOut: return "Sorry, Connection Time-Outed.";
      case NetworkFailureType.unknown: return "Sorry, Some Error Occurred.";
    }
  }
}

class NetworkFailure implements Exception {
  final NetworkFailureType failure;
  final dynamic error;
  NetworkFailure(this.failure, this.error,);
}