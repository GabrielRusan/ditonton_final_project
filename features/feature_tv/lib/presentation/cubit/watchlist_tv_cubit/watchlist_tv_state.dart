part of 'watchlist_tv_cubit.dart';

sealed class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

final class WatchlistTvEmpty extends WatchlistTvState {}

final class WatchlistTvLoading extends WatchlistTvState {}

final class WatchlistTvError extends WatchlistTvState {}

final class WatchlistTvHasData extends WatchlistTvState {
  final List<Tv> result;

  const WatchlistTvHasData({required this.result});

  @override
  List<Object> get props => [result];
}
