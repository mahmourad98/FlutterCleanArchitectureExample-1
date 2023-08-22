import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled05/extras/services/app-localization-service/app_localization_service.dart';
import 'package:untitled05/extras/services/app-navigation-service/app_navigation_service.dart';
import 'package:untitled05/extras/services/dio-network-service/dio_network_service.dart';
import 'package:untitled05/core/data/data-sources/movie-details/movie_details_remote_data_source.dart';
import 'package:untitled05/core/data/data-sources/movies/movies_remote_data_source.dart';
import 'package:untitled05/core/data/repos/movie-details/movie_details_repository.dart';
import 'package:untitled05/core/data/repos/movies/movies_repository.dart';
import 'package:untitled05/core/domain/usecases/movie_details_usecase.dart';
import 'package:untitled05/core/domain/usecases/movies_usecase.dart';
import 'package:untitled05/out-buildings/app_environment.dart';
import 'package:untitled05/out-buildings/app_logger.dart';

final serviceLocator = GetIt.instance;

Future setupServiceLocator(EnvironmentType envIfoMode,) async {
  ///Log locator Environment
  envIfoMode.exceptionErrorLog("Env: $envIfoMode",);

  ///Must be in orders dependencies
  {
    //1-EnvSolution
    serviceLocator.registerSingleton<AppEnvironment>(AppEnvironment(envIfoMode,),);
    serviceLocator.registerSingleton<AppNavigationService>(AppNavigationService(),);
    serviceLocator.registerSingleton<AppLocalizationService>(AppLocalizationService(),);
    await serviceLocator<AppLocalizationService>().initAppLocaleFromDB();
    serviceLocator.registerSingleton<DioNetworkService>(DioNetworkService.create(Dio(),),);
    serviceLocator.registerLazySingleton<MoviesRemoteDataSource>(() => MoviesRemoteDataSource(),);
    serviceLocator.registerLazySingleton<MoviesRepository>(() => MoviesRepository(serviceLocator<MoviesRemoteDataSource>(),),);
    serviceLocator.registerLazySingleton<NowPlayingMoviesUsecase>(() => NowPlayingMoviesUsecase(serviceLocator<MoviesRepository>(),),);
    serviceLocator.registerLazySingleton<MostPopularMoviesUsecase>(() => MostPopularMoviesUsecase(serviceLocator<MoviesRepository>(),),);
    serviceLocator.registerLazySingleton<TopRatedMoviesUsecase>(() => TopRatedMoviesUsecase(serviceLocator<MoviesRepository>(),),);
    serviceLocator.registerLazySingleton<MovieDetailsRemoteDataSource>(() => MovieDetailsRemoteDataSource(),);
    serviceLocator.registerLazySingleton<MovieDetailsRepository>(() => MovieDetailsRepository(serviceLocator<MovieDetailsRemoteDataSource>(),),);
    serviceLocator.registerLazySingleton<SingleMovieDetailsUsecase>(() => SingleMovieDetailsUsecase(serviceLocator<MovieDetailsRepository>(),),);
  }
}
