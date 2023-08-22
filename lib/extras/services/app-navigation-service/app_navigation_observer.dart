import 'package:flutter/material.dart';

class AppNavigationObserver extends NavigatorObserver {
  String? _currentRouteName;
  String? get currentRouteName => _currentRouteName;
  /////////////////////////
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute,) {
    if(route.settings.name != null) _currentRouteName = route.settings.name ;
    super.didPush(route, previousRoute,);
  }
  /////////////////////////
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute,) {
    if(previousRoute?.settings.name != null) _currentRouteName = previousRoute?.settings.name;
    super.didPop(route, previousRoute,);
  }
  /////////////////////////
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute,) {
    if(previousRoute?.settings.name != null) _currentRouteName = previousRoute?.settings.name;
    super.didRemove(route, previousRoute,);
  }
  /////////////////////////
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute,}) {
    if(newRoute?.settings.name != null) _currentRouteName = newRoute?.settings.name;
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute,);
  }
}