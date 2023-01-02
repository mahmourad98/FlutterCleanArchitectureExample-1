import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:untitled05/app_entry_point.dart';
import 'package:untitled05/core/layers/data/enums/environment_type.dart';

///SETTING UP THE ENVIRONMENT TYPE
const _environment = EnvironmentType.development;
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context,) {
    return super.createHttpClient(context,)..badCertificateCallback = (X509Certificate cert, String host, int port,) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await _appEntryMethod();
  Widget appEntryPoint = const AppEntryPoint(_environment,);
  runApp(appEntryPoint,);
}

Future _appEntryMethod() async {
  try {
    //ToDo: IMPLEMENT THE PRE-REQUESTS
  } on Exception catch (e) {
    log(e.toString(), name: _environment.name,);
  }
}
