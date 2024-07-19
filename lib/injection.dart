import 'package:core/core.dart';
import 'package:core/helper/db/database_helper.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:feature_movie/domain/repositories/movie_repository.dart';
import 'package:feature_movie/domain/usecases/search_movies.dart';
import 'package:feature_movie/presentations/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:feature_movie/presentations/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:feature_movie/presentations/bloc/now_playing_movie_bloc/now_playing_movie_bloc.dart';
import 'package:feature_movie/presentations/bloc/popular_movie_bloc/popular_movie_bloc.dart';
import 'package:feature_movie/presentations/bloc/search_movies_bloc/search_movies_bloc.dart';
import 'package:feature_movie/presentations/bloc/top_rated_movie_bloc/top_rated_movie_bloc.dart';
import 'package:feature_movie/presentations/cubit/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:feature_movie/data/datasources/movie_local_data_source.dart';
import 'package:feature_movie/data/datasources/movie_remote_data_source.dart';
import 'package:feature_movie/data/repositories/movie_repository_impl.dart';
import 'package:feature_tv/data/datasources/tv_local_data_source.dart';
import 'package:feature_tv/data/datasources/tv_remote_data_source.dart';
import 'package:feature_tv/data/repositories/tv_repository_impl.dart';
import 'package:feature_tv/domain/repositories/tv_repository.dart';
import 'package:feature_tv/domain/usecases/get_airing_today_tv.dart';
import 'package:feature_movie/domain/usecases/get_movie_detail.dart';
import 'package:feature_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:feature_movie/domain/usecases/get_now_playing_movies.dart';
import 'package:feature_movie/domain/usecases/get_popular_movies.dart';
import 'package:feature_tv/domain/usecases/get_popular_tv.dart';
import 'package:feature_tv/domain/usecases/get_season_detail.dart';
import 'package:feature_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:feature_tv/domain/usecases/get_top_rated_tv.dart';
import 'package:feature_tv/domain/usecases/get_tv_detail.dart';
import 'package:feature_tv/domain/usecases/get_tv_recommendations.dart';
import 'package:feature_tv/domain/usecases/get_tv_watchlist_status.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_movies.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_status.dart';
import 'package:feature_tv/domain/usecases/get_watchlist_tvs.dart';
import 'package:feature_movie/domain/usecases/remove_watchlist.dart';
import 'package:feature_tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:feature_movie/domain/usecases/save_watchlist.dart';
import 'package:feature_tv/domain/usecases/save_watchlist_tv.dart';
import 'package:feature_tv/domain/usecases/search_tvs.dart';
import 'package:feature_tv/presentation/bloc/airing_today_tv_bloc/airing_today_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/recommendation_tv_bloc/recommendation_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/search_tvs_bloc/search_tvs_bloc.dart';
import 'package:feature_tv/presentation/bloc/season_detail_bloc/season_detail_bloc.dart';
import 'package:feature_tv/presentation/bloc/top_rated_tv_bloc/top_rated_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:feature_tv/presentation/bloc/tv_watchlist_status_bloc/tv_watchlist_status_bloc.dart';
import 'package:feature_tv/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> init() async {
  final myHttpClient = await getSSLPinningClient();

  locator.registerFactory(
    () => NowPlayingMovieBloc(locator()),
  );

  locator.registerFactory(
    () => PopularMovieBloc(locator()),
  );

  locator.registerFactory(
    () => TopRatedMovieBloc(locator()),
  );

  locator.registerFactory(
    () => SearchMoviesBloc(locator()),
  );

  locator.registerFactory(
    () => SearchTvsBloc(locator()),
  );

  locator.registerFactory(
    () => MovieDetailBloc(locator()),
  );

  locator.registerFactory(
    () => MovieRecommendationBloc(locator()),
  );

  locator.registerFactory(
    () => WatchlistMovieCubit(locator()),
  );

  locator.registerFactory(
    () => WatchlistMovieStatusCubit(locator(), locator(), locator()),
  );

  locator.registerFactory(
    () => AiringTodayTvBloc(locator()),
  );
  locator.registerFactory(
    () => PopularTvBloc(locator()),
  );
  locator.registerFactory(
    () => TopRatedTvBloc(locator()),
  );
  locator.registerFactory(
    () => RecommendationTvBloc(locator()),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(locator()),
  );
  locator.registerFactory(
    () => TvWatchlistStatusBloc(locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => SeasonDetailBloc(locator()),
  );
  locator.registerFactory(
    () => TvDetailBloc(locator(), locator(), locator()),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetAiringTodayTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetTvWatchlistStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetSeasonDetail(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external

  locator.registerLazySingleton<http.Client>(() => myHttpClient);
  locator.registerLazySingleton(() => DataConnectionChecker());
}

Future<SecurityContext> get globalContext async {
  final sslCert = await rootBundle.load('assets/certificate.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

Future<http.Client> getSSLPinningClient() async {
  HttpClient client = HttpClient(context: await globalContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
  IOClient ioClient = IOClient(client);
  return ioClient;
}
