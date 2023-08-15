import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:untitled05/app/app_entry_point.dart';
import 'package:untitled05/out-buildings/app_environment.dart';
import 'package:untitled05/out-buildings/app_logger.dart';
import 'package:untitled05/out-buildings/dependency_injector.dart';
import 'package:untitled05/out-buildings/development_tools_wrapper.dart';

///SETTING UP THE ENVIRONMENT TYPE
const _environment = String.fromEnvironment("ENV", defaultValue: "PRODUCTION",);
final EnvironmentType _envType = _environment.getEnvType();

///HTTP OVERRIDES
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context,) {
    return super.createHttpClient(context,)..badCertificateCallback = (X509Certificate cert, String host, int port,) => true;
  }
}

void main() async {
  getLogger(className: "mainMethod",).e(_envType,);
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await _appEntryMethod(_envType,);
  final appEntryPoint = Phoenix(child: MyAppEntryPoint(_envType,),);
  if(kDebugMode) {
    runApp(DevToolsWrapper(appEntryPoint,),);
  }
  else {
    runApp(appEntryPoint,);
  }
}

Future _appEntryMethod(EnvironmentType environmentType,) async {
  try {
    await setupServiceLocator(environmentType,);
  } on Exception catch (e) {
    log(e.toString(), name: _envType.name,);
    exit(1,);
  }
}
