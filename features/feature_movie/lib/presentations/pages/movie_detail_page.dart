import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common_entities/genre.dart';
import 'package:core/core.dart';
import 'package:feature_movie/presentations/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:feature_movie/presentations/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:feature_movie/presentations/cubit/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<MovieDetailBloc>().add(FetchMovieDetail(id: widget.id)));
    Future.microtask(() => context
        .read<MovieRecommendationBloc>()
        .add(FetchMovieRecommendation(id: widget.id)));
    Future.microtask(() => context
        .read<WatchlistMovieStatusCubit>()
        .loadWatchlistStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        child: Scaffold(
      body: BlocListener<WatchlistMovieStatusCubit, WatchlistMovieStatusState>(
          listener: (context, state) {
            if (state is WatchlistAddedSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is WatchlistAddedError) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(state.message),
                    );
                  });
            } else if (state is WatchlistRemovedSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is WatchlistRemovedError) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(state.message),
                    );
                  });
            }
          },
          child: const SafeArea(child: DetailContent())),
    ));
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieDetailLoaded) {
          final movie = state.result;
          return Stack(
            children: [
              CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                width: screenWidth,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Container(
                margin: const EdgeInsets.only(top: 48 + 8),
                child: DraggableScrollableSheet(
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: kRichBlack,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        right: 16,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: kHeading5,
                                  ),
                                  BlocBuilder<WatchlistMovieStatusCubit,
                                      WatchlistMovieStatusState>(
                                    builder: (context, state) {
                                      if (state is WatchlistMovieStatusLoaded) {
                                        final bool isAddedWatchlist =
                                            state.isAddedToWatchlist;
                                        return ElevatedButton(
                                          onPressed: () async {
                                            if (isAddedWatchlist) {
                                              context
                                                  .read<
                                                      WatchlistMovieStatusCubit>()
                                                  .removeFromWatchlist(movie);
                                            } else {
                                              context
                                                  .read<
                                                      WatchlistMovieStatusCubit>()
                                                  .saveToWatchlist(movie);
                                            }
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              isAddedWatchlist
                                                  ? const Icon(Icons.check)
                                                  : const Icon(Icons.add),
                                              const Text('Watchlist'),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return ElevatedButton(
                                          onPressed: () {},
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CircularProgressIndicator(),
                                              Text('Watchlist'),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  Text(
                                    _showGenres(movie.genres),
                                  ),
                                  Text(
                                    _showDuration(movie.runtime),
                                  ),
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: movie.voteAverage / 2,
                                        itemCount: 5,
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: kMikadoYellow,
                                        ),
                                        itemSize: 24,
                                      ),
                                      Text('${movie.voteAverage}')
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Overview',
                                    style: kHeading6,
                                  ),
                                  Text(
                                    movie.overview,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Recommendations',
                                    style: kHeading6,
                                  ),
                                  BlocBuilder<MovieRecommendationBloc,
                                          MovieRecommendationState>(
                                      builder: (context, state) {
                                    if (state is MovieRecommendationLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state
                                        is MovieRecommendationError) {
                                      return const Text('Error');
                                    } else if (state
                                        is MovieRecommendationHasData) {
                                      return SizedBox(
                                        height: 150,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final movie = state.result[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                    context,
                                                    MovieDetailPage.ROUTE_NAME,
                                                    arguments: movie.id,
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                    placeholder:
                                                        (context, url) =>
                                                            const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: state.result.length,
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              color: Colors.white,
                              height: 4,
                              width: 48,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  // initialChildSize: 0.5,
                  minChildSize: 0.25,
                  // maxChildSize: 1.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: kRichBlack,
                  foregroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ],
          );
        } else {
          return const Center(
            child: Text('Something wrong happened :('),
          );
        }
      },
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
