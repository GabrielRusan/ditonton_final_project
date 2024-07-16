import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:core/widgets/custom_drawer.dart';
import 'package:ditonton_submission/firebase_options.dart';
import 'package:feature_movie/presentations/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:feature_movie/presentations/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:feature_movie/presentations/bloc/now_playing_movie_bloc/now_playing_movie_bloc.dart';
import 'package:feature_movie/presentations/bloc/popular_movie_bloc/popular_movie_bloc.dart';
import 'package:feature_movie/presentations/bloc/search_movies_bloc/search_movies_bloc.dart';
import 'package:feature_movie/presentations/bloc/top_rated_movie_bloc/top_rated_movie_bloc.dart';
import 'package:feature_movie/presentations/cubit/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:feature_movie/presentations/pages/movie_detail_page.dart';
import 'package:feature_movie/presentations/pages/popular_movies_page.dart';
import 'package:feature_movie/presentations/pages/search_page.dart';
import 'package:feature_movie/presentations/pages/top_rated_movies_page.dart';
import 'package:feature_movie/presentations/pages/watchlist_movies_page.dart';
import 'package:feature_tv/presentation/bloc/search_tvs_bloc/search_tvs_bloc.dart';
import 'package:feature_tv/presentation/pages/tv_pages/airing_today_tv_page.dart';
import 'package:feature_tv/presentation/pages/tv_pages/popular_tv_page.dart';
import 'package:feature_tv/presentation/pages/tv_pages/search_tv_page.dart';
import 'package:feature_tv/presentation/pages/tv_pages/top_rated_tv_page.dart';
import 'package:feature_tv/presentation/pages/tv_pages/tv_detail_page.dart';
import 'package:feature_tv/presentation/pages/tv_pages/watchlist_tv_page.dart';
import 'package:feature_tv/presentation/provider/airing_today_tv_notifier.dart';
import 'package:feature_tv/presentation/provider/popular_tv_notifier.dart';
import 'package:feature_tv/presentation/provider/top_rated_tv_notifier.dart';
import 'package:feature_tv/presentation/provider/tv_detail_notifier.dart';
import 'package:feature_tv/presentation/provider/tv_list_notifier.dart';
import 'package:feature_tv/presentation/provider/watchlist_tv_notifier.dart';
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

  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AiringTodayTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
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
        BlocProvider<MovieRecommendationBloc>(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider<WatchlistMovieCubit>(
          create: (_) => di.locator<WatchlistMovieCubit>(),
        ),
        BlocProvider<WatchlistMovieStatusCubit>(
          create: (_) => di.locator<WatchlistMovieStatusCubit>(),
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
