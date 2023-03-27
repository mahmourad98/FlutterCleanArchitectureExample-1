import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:untitled05/app/app_entry_point.dart';
import 'package:untitled05/core/layers/data/enums/environment_type.dart';
import 'package:untitled05/out-buildings/development_tools_wrapper.dart';

///SETTING UP THE ENVIRONMENT TYPE
const _environment = String.fromEnvironment("ENV", defaultValue: "DEVELOPMENT",);
final EnvironmentType _envType = _environment.getEnvTypeFromString();

///HTTP OVERRIDES
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context,) {
    return super.createHttpClient(context,)..badCertificateCallback = (X509Certificate cert, String host, int port,) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await _appEntryMethod(_envType,);
  Widget appEntryPoint = AppEntryPoint(_envType,);
  if(_envType.isDebugMode()) {
    runApp(DevToolsWrapper(appEntryPoint,),);
  } else {
    runApp(appEntryPoint,);
  }
}

Future _appEntryMethod(EnvironmentType environmentType,) async {
  try {
    //ToDo: IMPLEMENT THE PRE-REQUESTS
  } on Exception catch (e) {
    log(e.toString(), name: _envType.name,);
  }
}
