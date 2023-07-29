import 'package:flutter/material.dart';
import 'package:untitled05/core/layers/presentation/pages/movie-details-page/movie_details_page_view.dart';
import 'package:untitled05/core/layers/presentation/pages/movies-page/movies_page_view.dart';
import 'package:untitled05/core/layers/presentation/pages/splash-page/splash_page_view.dart';

class AppRouter{
  const AppRouter._();

  static Route onGenerateRoute(RouteSettings routeSettings,){
    switch (routeSettings.name){
      case SplashPageView.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (BuildContext buildContext,) {
          return const SplashPageView();
        },
      );
      case MoviesPageView.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (BuildContext buildContext,) {
          return const MoviesPageView();
        },
      );
      case MovieDetailsPageView.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (BuildContext buildContext,) {
          return MovieDetailsPageView((routeSettings.arguments as int),);
        },
      );
      default:
      return MaterialPageRoute(
        builder: (_,) {
          return Scaffold(body: SizedBox.expand(child: ErrorWidget("unknown-route",),),);
        },
        settings: routeSettings,
      );
    }
  }
}
