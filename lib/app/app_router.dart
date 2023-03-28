import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:untitled05/core/layers/data/data-sources/movies/movies_remote_data_source.dart';
import 'package:untitled05/core/layers/data/repos/movies/movies-repository.dart';
import 'package:untitled05/core/layers/domain/entities/movie-model/movie.dart';
import 'package:untitled05/core/layers/domain/usecases/movie_usecase.dart';

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
        () => const UnknownRoute(),
      );
    }
  }

  static Route? _routeTo(Widget Function() widgetFunction,){
    return MaterialPageRoute(
      builder: (_,) => widgetFunction(),
    );
  }
}

class UnknownRoute extends StatefulWidget {
  const UnknownRoute({Key? key}) : super(key: key);

  @override
  State<UnknownRoute> createState() => _UnknownRouteState();
}

class _UnknownRouteState extends State<UnknownRoute> {
  @override
  void initState() {
    NowPlayingMoviesUsecase(MoviesRepository(MoviesRemoteDataSource(),),).call().then(
      (value,) => value.fold(
        (l,) => dev.log(l.error.toString(), name: "Data",),
        (r,) => r.forEach((element,) => dev.log(r.toString(), name: "Data",),),
      ),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: FutureBuilder<List<Movie>>(
            future: Future(() => _getData(),),
            builder: (buildContext, asyncSnapshot,) => ListView.separated(
              itemBuilder: (BuildContext context, int index) => Text(asyncSnapshot.data![index].toString(),),
              separatorBuilder: (BuildContext context, int index) => const Divider(
                color: Colors.black,
                thickness: 1.0,
                height: 4.0,
              ),
              itemCount: asyncSnapshot.data?.length ?? 0,
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Movie>> _getData() async {
    return await NowPlayingMoviesUsecase(MoviesRepository(MoviesRemoteDataSource(),),).call().then(
      (value) => value.fold((l,) => [], (r,) => r..shuffle(),),
    );
  }
}
