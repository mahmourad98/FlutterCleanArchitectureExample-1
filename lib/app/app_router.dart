import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:untitled05/core/layers/data/data-sources/movies/movies_remote_data_source.dart';
import 'package:untitled05/core/layers/data/repos/movies/movies-repository.dart';
import 'package:untitled05/core/layers/domain/entities/movie-model/movie.dart';
import 'package:untitled05/core/layers/domain/usecases/movie_usecase.dart';
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
    switch (routeSettings.name){
      // case AppRouteNames.phoneVerificationRoute:
      // return _routeTo(() => const PhoneVerificationRoute(),);
      default:
      return _routeTo(
        () => const MoviesPageView(),
      );
    }
  }

  static Route? _routeTo(Widget Function() widgetFunction,){
    return MaterialPageRoute(
      builder: (_,) => widgetFunction(),
    );
  }
}
