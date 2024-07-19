import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common_entities/genre.dart';
import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/season_detail.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/domain/entities/tv_detail.dart';
import 'package:feature_tv/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:feature_tv/presentation/bloc/tv_watchlist_status_bloc/tv_watchlist_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-detail';

  final int id;
  const TvDetailPage({super.key, required this.id});

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvDetailBloc>().add(FetchTvDetail(id: widget.id));
    context
        .read<TvWatchlistStatusBloc>()
        .add(LoadWatchlistStatus(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: BlocListener<TvWatchlistStatusBloc, TvWatchlistStatusState>(
          listener: (context, state) {
            if (state is SuccessAddTv) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is FailAddTv) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(state.message),
                    );
                  });
            } else if (state is SuccessRemoveTv) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is FailRemoveTv) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(state.message),
                    );
                  });
            }
          },
          child: BlocBuilder<TvDetailBloc, TvDetailState>(
              builder: (context, state) {
            if (state is TvDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvDetailLoaded) {
              return DetailContent(
                  tvDetail: state.tvDetail,
                  recommendationList: state.recommendationList,
                  seasonDetailList: state.seasonDetailList);
            } else {
              return const Center(
                child: Text('An Error Occured :('),
              );
            }
          }),
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tvDetail;
  final List<Tv> recommendationList;
  final List<SeasonDetail> seasonDetailList;
  const DetailContent(
      {super.key,
      required this.tvDetail,
      required this.recommendationList,
      required this.seasonDetailList});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                              tvDetail.name ?? "",
                              style: kHeading5,
                            ),
                            BlocBuilder<TvWatchlistStatusBloc,
                                TvWatchlistStatusState>(
                              buildWhen: (previous, current) =>
                                  current is TvWatchlistStatusLoaded,
                              builder: (context, state) {
                                if (state is TvWatchlistStatusLoaded) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        backgroundColor: kMikadoYellow,
                                        foregroundColor: Colors.black),
                                    onPressed: () async {
                                      if (state.isAddedToWatchlist) {
                                        context
                                            .read<TvWatchlistStatusBloc>()
                                            .add(RemoveFromWatchlist(
                                                tv: tvDetail));
                                      } else {
                                        context
                                            .read<TvWatchlistStatusBloc>()
                                            .add(AddToWatchlist(tv: tvDetail));
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        state.isAddedToWatchlist
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                            Text(
                              _showGenres(tvDetail.genres ?? []),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: (tvDetail.voteAverage ?? 0) / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvDetail.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvDetail.overview ?? '-',
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Seasons and Episodes',
                              style: kHeading6,
                            ),
                            const SizedBox(height: 16),
                            ...seasonDetailList.map((seasonDetail) {
                              return seasonDetail.airDate == null
                                  ? const SizedBox()
                                  : _buildSeasonDetail(
                                      seasonDetail, '${seasonDetail.id}');
                            }),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                key: const Key('recommendation'),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final tv = recommendationList[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TvDetailPage.ROUTE_NAME,
                                          arguments: tv.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendationList.length,
                              ),
                            )
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

  // String _showDuration(int runtime) {
  //   final int hours = runtime ~/ 60;
  //   final int minutes = runtime % 60;

  //   if (hours > 0) {
  //     return '${hours}h ${minutes}m';
  //   } else {
  //     return '${minutes}m';
  //   }
  // }

  Widget _buildSeasonDetail(SeasonDetail seasonDetail, String keyVal) {
    return Column(
      key: Key(keyVal),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 60,
                  decoration: const BoxDecoration(color: Colors.red),
                  child: Center(
                    child: Text(
                      '${seasonDetail.seasonNumber}',
                      style: kHeading7,
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Center(
                    child: Text(
                      'Season ${seasonDetail.seasonNumber}',
                      style: kHeading7,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  '${seasonDetail.airDate}',
                  style: kBodyTextGrey,
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: kMikadoYellow,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text('${seasonDetail.voteAverage}')
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        ...seasonDetail.episodes!.map((episode) {
          return episode.airDate == null
              ? const SizedBox()
              : Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 60,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        SizedBox(
                            width: 100,
                            child: Center(
                              child: Text(
                                  '${seasonDetail.seasonNumber} - ${episode.episodeNumber}'),
                            )),
                        Container(
                          width: 1,
                          height: 25,
                          color: Colors.grey.shade800,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${episode.name}',
                                style: kSubtitle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${episode.airDate}',
                                style: kBodyTextGrey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.shade800,
                    )
                  ],
                );
        }),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
