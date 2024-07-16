import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/presentations/bloc/now_playing_movie_bloc/now_playing_movie_bloc.dart';
import 'package:feature_movie/presentations/bloc/popular_movie_bloc/popular_movie_bloc.dart';
import 'package:feature_movie/presentations/bloc/top_rated_movie_bloc/top_rated_movie_bloc.dart';
import 'package:feature_movie/presentations/pages/movie_detail_page.dart';
import 'package:feature_movie/presentations/pages/popular_movies_page.dart';
import 'package:feature_movie/presentations/pages/search_page.dart';
import 'package:feature_movie/presentations/pages/top_rated_movies_page.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/presentation/pages/tv_pages/airing_today_tv_page.dart';
import 'package:feature_tv/presentation/pages/tv_pages/popular_tv_page.dart';
import 'package:feature_tv/presentation/pages/tv_pages/search_tv_page.dart';
import 'package:feature_tv/presentation/pages/tv_pages/top_rated_tv_page.dart';
import 'package:feature_tv/presentation/pages/tv_pages/tv_detail_page.dart';
import 'package:feature_tv/presentation/provider/tv_list_notifier.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<NowPlayingMovieBloc>().add(FetchNowPlayingMovie()));
    Future.microtask(
        () => context.read<PopularMovieBloc>().add(FetchPopularMovie()));
    Future.microtask(
        () => context.read<TopRatedMovieBloc>().add(FetchTopRatedMovieEvent()));

    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchAiringTodayTv()
      ..fetchPopularTv()
      ..fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ditonton'),
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Movies',
                      style: kHeadingLarge,
                    ), // Elemen pertama di tengah mutlak
                  ),
                  Row(
                    children: [
                      const Spacer(), // Mengisi ruang kosong di awal
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
                        },
                        icon: const Icon(Icons.search),
                      ) // Elemen kedua di paling akhir // Elemen kedua di paling akhir
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Now Playing',
                      style: kHeading6,
                    ),
                    BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
                        builder: (context, state) {
                      if (state is NowPlayingMovieLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is NowPlayingMovieHasData) {
                        return MovieList(state.result);
                      } else {
                        return const Text('Failed');
                      }
                    }),
                    _buildSubHeading(
                      title: 'Popular',
                      onTap: () => Navigator.pushNamed(
                          context, PopularMoviesPage.ROUTE_NAME),
                    ),
                    BlocBuilder<PopularMovieBloc, PopularMovieState>(
                        builder: (context, state) {
                      if (state is PopularMovieLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is PopularMovieHasData) {
                        return MovieList(state.result);
                      } else {
                        return const Text('Failed');
                      }
                    }),
                    _buildSubHeading(
                      title: 'Top Rated',
                      onTap: () => Navigator.pushNamed(
                          context, TopRatedMoviesPage.ROUTE_NAME),
                    ),
                    BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                        builder: (context, state) {
                      if (state is TopRatedMovieLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TopRatedMovieHasData) {
                        return MovieList(state.result);
                      } else {
                        return const Text('Failed');
                      }
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'TV Series',
                      style: kHeadingLarge,
                    ), // Elemen pertama di tengah mutlak
                  ),
                  Row(
                    children: [
                      const Spacer(), // Mengisi ruang kosong di awal
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
                        },
                        icon: const Icon(Icons.search),
                      ) // Elemen kedua di paling akhir // Elemen kedua di paling akhir
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubHeading(
                      title: 'Airing Today',
                      onTap: () => Navigator.pushNamed(
                          context, AiringTodayTvPage.ROUTE_NAME),
                    ),
                    Consumer<TvListNotifier>(builder: (context, data, child) {
                      final state = data.airingTodayState;
                      if (state == RequestState.Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        return TvList(data.airingTodayTv);
                      } else {
                        return const Text('Failed');
                      }
                    }),
                    _buildSubHeading(
                      title: 'Popular',
                      onTap: () => Navigator.pushNamed(
                          context, PopularTvPage.ROUTE_NAME),
                    ),
                    Consumer<TvListNotifier>(builder: (context, data, child) {
                      final state = data.popularTvState;
                      if (state == RequestState.Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        return TvList(data.popularTv);
                      } else {
                        return const Text('Failed');
                      }
                    }),
                    _buildSubHeading(
                      title: 'Top Rated',
                      onTap: () => Navigator.pushNamed(
                          context, TopRatedTvPage.ROUTE_NAME),
                    ),
                    Consumer<TvListNotifier>(builder: (context, data, child) {
                      final state = data.topRatedTvState;
                      if (state == RequestState.Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state == RequestState.Loaded) {
                        return TvList(data.topRatedTv);
                      } else {
                        return const Text('Failed');
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  const TvList(this.tvs, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}