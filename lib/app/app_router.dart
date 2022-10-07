import 'package:flutter/material.dart';

import 'app.dart';

class AppRouter{
  static Route? onGenerateRoute(RouteSettings routeSettings,){
    switch (routeSettings.name){
      default:
        return _routeTo(() => const HomeView(),);
    }
  }

  static Route? _routeTo(Widget Function() widgetFunction,){
    return MaterialPageRoute(
      builder: (_,) => widgetFunction(),
    );
  }
}