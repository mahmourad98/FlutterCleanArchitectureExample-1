import 'package:flutter/material.dart';
import 'package:untitled05/app/app_route_names.dart';
import 'package:untitled05/core/layers/presentation/pages/movie-details-page/movie_details_page_view.dart';
import 'package:untitled05/core/layers/presentation/pages/movies-page/movies_page_view.dart';

class AppRouter{
  AppRouter._();
  static AppRouter? _appRouter;
  static AppRouter get instance { _appRouter ??= AppRouter._(); return _appRouter!; }

  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navKey => _navKey;
  final NavigatorObserver _navObserver = NavigatorObserver();
  NavigatorObserver get navObserver => _navObserver;

  static Route? onGenerateRoute(RouteSettings routeSettings,){
    if(routeSettings.name == Navigator.defaultRouteName) return null;
    switch (routeSettings.name){
      case AppRouteNames.moviesRoute:
      return _routeTo(() => const MoviesPageView(), routeSettings,);
      case AppRouteNames.movieDetailsRoute:
      return _routeTo(() => MovieDetailsPageView((routeSettings.arguments as int),), routeSettings,);
      default:
      return _routeTo(
        () => const Scaffold(body: SizedBox.expand(child: Center(child: Text("Unknown",),),),),
        null,
      );
    }
  }

  static Route? _routeTo(Widget Function() widgetFunction, RouteSettings? settings,){
    return MaterialPageRoute(
      builder: (_,) => widgetFunction(),
      settings: settings,
    );
  }
}
