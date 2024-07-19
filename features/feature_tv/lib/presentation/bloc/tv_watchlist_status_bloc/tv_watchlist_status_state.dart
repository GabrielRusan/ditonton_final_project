part of 'tv_watchlist_status_bloc.dart';

sealed class TvWatchlistStatusState extends Equatable {
  const TvWatchlistStatusState();

  @override
  List<Object> get props => [];
}

final class TvWatchlistStatusInitial extends TvWatchlistStatusState {}

final class TvWatchlistStatusLoaded extends TvWatchlistStatusState {
  final bool isAddedToWatchlist;

  const TvWatchlistStatusLoaded({required this.isAddedToWatchlist});

  @override
  List<Object> get props => [isAddedToWatchlist];
}

final class SuccessAddTv extends TvWatchlistStatusState {
  final String message = 'Added to Watchlist';
}

final class FailAddTv extends TvWatchlistStatusState {
  final String message = 'Failed Adding Tv to Watchlist';
}

final class SuccessRemoveTv extends TvWatchlistStatusState {
  final String message = 'Removed from Watchlist';
}

final class FailRemoveTv extends TvWatchlistStatusState {
  final String message = 'Failed to Remove Tv from Watchlist';
}
