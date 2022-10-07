import 'dart:io';

import 'package:flutter/material.dart';

import 'app/app.dart';

class AppRoot{
  static const _myApp = MyApp();

  static init() async{
    HttpOverrides.global = MyHttpOverrides();
    WidgetsFlutterBinding.ensureInitialized();
    runApp(_myApp,);
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context,){
    return super.createHttpClient(context,)
      ..badCertificateCallback = (X509Certificate cert, String host, int port,) => true;
  }
}