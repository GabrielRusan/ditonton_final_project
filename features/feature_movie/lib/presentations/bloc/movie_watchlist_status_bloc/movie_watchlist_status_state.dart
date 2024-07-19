part of 'movie_watchlist_status_bloc.dart';

sealed class MovieWatchlistStatusState extends Equatable {
  const MovieWatchlistStatusState();

  @override
  List<Object> get props => [];
}

final class MovieWatchlistStatusInitial extends MovieWatchlistStatusState {}

final class MovieWatchlistStatusLoaded extends MovieWatchlistStatusState {
  final bool isAddedToWatchlist;

  const MovieWatchlistStatusLoaded({required this.isAddedToWatchlist});

  @override
  List<Object> get props => [isAddedToWatchlist];
}

final class SuccessAddMovie extends MovieWatchlistStatusState {
  final String message = 'Added to Watchlist';
}

final class FailAddMovie extends MovieWatchlistStatusState {
  final String message = 'Failed Adding Movie to Watchlist';
}

final class SuccessRemoveMovie extends MovieWatchlistStatusState {
  final String message = 'Removed from Watchlist';
}

final class FailRemoveMovie extends MovieWatchlistStatusState {
  final String message = 'Failed to Remove Movie from Watchlist';
}
