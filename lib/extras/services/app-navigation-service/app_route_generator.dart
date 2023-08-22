import 'package:flutter/material.dart';
import 'package:untitled05/core/presentation/pages/movie-details-page/movie_details_page_view.dart';
import 'package:untitled05/core/presentation/pages/movies-page/movies_page_view.dart';
import 'package:untitled05/core/presentation/pages/splash-page/splash_page_view.dart';

class AppRouteNames{
  const AppRouteNames._();
  /////////////////////////
  static const String SPLASH_PAGE = "/splash-page";
  static const String MOVIES_PAGE = "/movies-page";
  static const String MOVIE_DETAILS_PAGE = "/movie-details-page";
}

class AppRouter{
  const AppRouter._();
  /////////////////////////
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings,){
    switch (routeSettings.name){
      case AppRouteNames.SPLASH_PAGE:
      return MaterialPageRoute<dynamic>(
        settings: routeSettings,
        builder: (BuildContext buildContext,) {
          return const SplashPageView();
        },
      );
      case AppRouteNames.MOVIES_PAGE:
      return MaterialPageRoute<dynamic>(
        settings: routeSettings,
        builder: (BuildContext buildContext,) {
          return const MoviesPageView();
        },
      );
      case AppRouteNames.MOVIE_DETAILS_PAGE:
      return MaterialPageRoute<dynamic>(
        settings: routeSettings,
        builder: (BuildContext buildContext,) {
          return MovieDetailsPageView((routeSettings.arguments as int),);
        },
      );
      default:
      return MaterialPageRoute<dynamic>(
        builder: (_,) {
          return Scaffold(body: SizedBox.expand(child: Center(child: ErrorWidget("unknown-route",),),),);
        },
        settings: routeSettings,
      );
    }
  }
}
