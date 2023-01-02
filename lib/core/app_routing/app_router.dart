import 'package:flutter/material.dart';

class AppRouter{
  AppRouter._();
  static AppRouter? _appRouter;
  static AppRouter get instance { _appRouter ??= AppRouter._(); return _appRouter!; }

  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navKey => _navKey;
  final NavigatorObserver _navObserver = NavigatorObserver();
  NavigatorObserver get navObserver => _navObserver;

  static Route? onGenerateRoute(RouteSettings routeSettings,){
    switch (routeSettings.name){
      // case AppRouteNames.phoneVerificationRoute:
      //   return _routeTo(() => const PhoneVerificationRoute(),);
      default:
        return _routeTo(() => const SizedBox.expand(child: Center(child: Text("No View",),),),);
    }
  }

  static Route? _routeTo(Widget Function() widgetFunction,){
    return MaterialPageRoute(
      builder: (_,) => widgetFunction(),
    );
  }

}