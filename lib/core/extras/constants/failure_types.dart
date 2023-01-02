enum FailureType { offline, serverError, emptyCache, }

extension FailureMessage on FailureType{
  String get message {
    switch (this) {
      case FailureType.offline: return "Check Your Internet Connection.";
      case FailureType.serverError: return "Sorry, Server Is Not Available.";
      case FailureType.emptyCache: return "Sorry, Some Error Occurred.";
    }
  }
}

class Failure implements Exception{
  final FailureType failure;

  Failure(this.failure,);
}