enum EnvironmentType { production, acceptance, testing, development, }

extension EnvTypeFromString on String {
  EnvironmentType getEnvTypeFromString() {
    final String _env = this;
    if (_env == EnvironmentType.testing.appMode) {
      return EnvironmentType.testing;
    }
    if (_env == EnvironmentType.acceptance.appMode) {
      return EnvironmentType.acceptance;
    }
    if (_env == EnvironmentType.production.appMode) {
      return EnvironmentType.production;
    } else {
      return EnvironmentType.development;
    }
  }
}

extension EnvInfo on EnvironmentType {
  String get baseUrl => _baseUrl();
  String _baseUrl() {
    switch (this) {
      case EnvironmentType.production:
      return "";
      case EnvironmentType.acceptance:
      return "";
      case EnvironmentType.testing:
      return "";
      default:
      return "";
    }
  }

  String get baseUrlNoApi => _baseUrlNoApi();
  String _baseUrlNoApi() {
    switch (this) {
      case EnvironmentType.production:
      return "";
      case EnvironmentType.acceptance:
      return "";
      case EnvironmentType.testing:
      return "";
      default:
      return "";
    }
  }

  String get appMode => _appMode();
  String _appMode() {
    switch (this) {
      case EnvironmentType.production:
      return "";
      case EnvironmentType.acceptance:
      return "";
      case EnvironmentType.testing:
      return "";
      default:
      return "";
    }
  }

  bool isDebugMode() => (this == EnvironmentType.development);
  bool isReleaseMode() => (this == EnvironmentType.testing) || (this == EnvironmentType.acceptance) ||(this == EnvironmentType.production);
}