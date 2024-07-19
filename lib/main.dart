import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:core/widgets/custom_drawer.dart';
import 'package:ditonton_submission/firebase_options.dart';
import 'package:feature_movie/presentations/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:feature_movie/presentations/bloc/now_playing_movie_bloc/now_playing_movie_bloc.dart';
import 'package:feature_movie/presentations/bloc/popular_movie_bloc/popular_movie_bloc.dart';
import 'package:feature_movie/presentations/bloc/search_movies_bloc/search_movies_bloc.dart';
import 'package:feature_movie/presentations/bloc/top_rated_movie_bloc/top_rated_movie_bloc.dart';
import 'package:feature_movie/presentations/pages/movie_detail_page.dart';
import 'package:feature_movie/presentations/pages/popular_movies_page.dart';
import 'package:feature_movie/presentations/pages/search_page.dart';
import 'package:feature_movie/presentations/pages/top_rated_movies_page.dart';
import 'package:feature_movie/presentations/pages/watchlist_movies_page.dart';
import 'package:feature_tv/presentation/bloc/airing_today_tv_bloc/airing_today_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/recommendation_tv_bloc/recommendation_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/search_tvs_bloc/search_tvs_bloc.dart';
import 'package:feature_tv/presentation/bloc/season_detail_bloc/season_detail_bloc.dart';
import 'package:feature_tv/presentation/bloc/top_rated_tv_bloc/top_rated_tv_bloc.dart';
import 'package:feature_tv/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:feature_tv/presentation/bloc/tv_watchlist_status_bloc/tv_watchlist_status_bloc.dart';
import 'package:feature_tv/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';
import 'package:feature_tv/presentation/pages/airing_today_tv_page.dart';
import 'package:feature_tv/presentation/pages/popular_tv_page.dart';
import 'package:feature_tv/presentation/pages/search_tv_page.dart';
import 'package:feature_tv/presentation/pages/top_rated_tv_page.dart';
import 'package:feature_tv/presentation/pages/tv_detail_page.dart';
import 'package:feature_tv/presentation/pages/watchlist_tv_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton_submission/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<NowPlayingMovieBloc>(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider<TopRatedMovieBloc>(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider<PopularMovieBloc>(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider<SearchMoviesBloc>(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider<SearchTvsBloc>(
          create: (_) => di.locator<SearchTvsBloc>(),
        ),
        BlocProvider<MovieDetailBloc>(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider<AiringTodayTvBloc>(
          create: (_) => di.locator<AiringTodayTvBloc>(),
        ),
        BlocProvider<PopularTvBloc>(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider<TopRatedTvBloc>(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider<TvDetailBloc>(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider<SeasonDetailBloc>(
          create: (_) => di.locator<SeasonDetailBloc>(),
        ),
        BlocProvider<TvWatchlistStatusBloc>(
          create: (_) => di.locator<TvWatchlistStatusBloc>(),
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider<RecommendationTvBloc>(
          create: (_) => di.locator<RecommendationTvBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const CustomDrawer(content: HomePage()),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            case PopularTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const PopularTvPage());
            case TopRatedTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const TopRatedTvPage());
            case AiringTodayTvPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const AiringTodayTvPage());
            case WatchlistTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case SearchTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const SearchTvPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
