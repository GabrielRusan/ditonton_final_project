part of 'watchlist_tv_status_cubit.dart';

sealed class WatchlistTvStatusState extends Equatable {
  const WatchlistTvStatusState();

  @override
  List<Object> get props => [];
}

final class WatchlistTvStatusLoaded extends WatchlistTvStatusState {
  final bool isAddedToWatchlist;

  const WatchlistTvStatusLoaded({required this.isAddedToWatchlist});

  @override
  List<Object> get props => [isAddedToWatchlist];
}

final class SuccessAddTv extends WatchlistTvStatusState {
  final String message = 'Added to Watchlist';
}

final class FailAddTv extends WatchlistTvStatusState {
  final String message = 'Failed Adding Tv to Watchlist';
}

final class SuccessRemoveTv extends WatchlistTvStatusState {
  final String message = 'Removed from Watchlist';
}

final class FailRemoveTv extends WatchlistTvStatusState {
  final String message = 'Failed to Remove Tv from Watchlist';
}
