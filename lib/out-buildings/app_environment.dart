import 'package:flutter/foundation.dart';

enum EnvironmentType {
  development, testing, acceptance, production,
}

extension EnvTypeInfo on EnvironmentType {
  ///GET ENVIRONMENT NAME
  String get envName => _envName();
  String _envName() {
    switch (this) {
      case EnvironmentType.development:
      return "DEVELOPMENT";
      case EnvironmentType.testing:
      return "TESTING";
      case EnvironmentType.acceptance:
      return "ACCEPTANCE";
      default:
        return "PRODUCTION";
    }
  }
  ///GET API URL
  String get apiUrl => _apiUrl();
  String _apiUrl() {
    switch (this) {
      case EnvironmentType.development:
      return "";
      case EnvironmentType.testing:
      return "";
      case EnvironmentType.acceptance:
      return "";
      default:
      return "";
    }
  }
}

extension EnvTypeFromString on String {
  EnvironmentType getEnvType() {
    if (this == EnvironmentType.development.envName) {
      return EnvironmentType.development;
    } else if (this == EnvironmentType.testing.envName) {
      return EnvironmentType.testing;
    } else if (this == EnvironmentType.acceptance.envName) {
      return EnvironmentType.acceptance;
    } else {
      return EnvironmentType.production;
    }
  }
}

@immutable
class AppEnvironment {
  //ignore: constant_identifier_names
  static const ENV_TYPE_KEY = "ENV_TYPE";
  ///LOCAL VARIABLES
  final EnvironmentType _environmentType;
  EnvironmentType get environmentType => _environmentType;

  ///CONSTRUCTOR
  const AppEnvironment(this._environmentType,);

  ///CHANGE CURRENT ENVIRONMENT TYPE
  static Future<void> changeEnvType(EnvironmentType envType,) async {
    //TODO implement Log-Out environment
    /*await locator<LogoutService>().logout();
    serviceLocator.unregister<AppEnvironment>();
    final EnvironmentType result = await saveAppEnv();
    dev.log("App Env Was Changed To: $result", name: "AppEnvironment.changeEnvType()",);
    serviceLocator.registerSingleton<AppEnvironment>(AppEnvironment(result,),);
    return;*/
  }

  ///GET CURRENT ENVIRONMENT NAME
  /*static Future<EnvironmentType> saveAppEnv({EnvironmentType? envType,}) async {
    envType ??= serviceLocator<AppEnvironment>().environmentType;
    (await SharedPreferences.getInstance()).setString(ENV_TYPE_KEY, envType.envName,);
    return (await getEnvName());
  }*/

  ///GET CURRENT ENVIRONMENT NAME
  /*static Future<EnvironmentType> getEnvName() async {
    return (await SharedPreferences.getInstance()).getString(ENV_TYPE_KEY,)?.getEnvType() ??  serviceLocator<AppEnvironment>().environmentType;
  }*/
}

