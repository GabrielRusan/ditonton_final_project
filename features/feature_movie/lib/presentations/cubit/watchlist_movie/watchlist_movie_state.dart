part of 'watchlist_movie_cubit.dart';

sealed class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

final class WatchlistMovieEmpty extends WatchlistMovieState {}

final class WatchlistMovieError extends WatchlistMovieState {}

final class WatchlistMovieLoading extends WatchlistMovieState {}

final class WatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> result;

  const WatchlistMovieHasData({required this.result});
  @override
  List<Object> get props => [result];
}

sealed class WatchlistMovieStatusState extends Equatable {
  const WatchlistMovieStatusState();

  @override
  List<Object> get props => [];
}

final class WatchlistMovieStatusLoaded extends WatchlistMovieStatusState {
  final bool isAddedToWatchlist;

  const WatchlistMovieStatusLoaded({required this.isAddedToWatchlist});

  @override
  List<Object> get props => [isAddedToWatchlist];
}

final class WatchlistAddedSuccess extends WatchlistMovieStatusState {
  final message = 'Added to Watchlist';

  @override
  List<Object> get props => [message];
}

final class WatchlistAddedError extends WatchlistMovieStatusState {
  final message = 'Failed to Add';

  @override
  List<Object> get props => [message];
}

final class WatchlistRemovedSuccess extends WatchlistMovieStatusState {
  final message = 'Removed from Watchlist';

  @override
  List<Object> get props => [message];
}

final class WatchlistRemovedError extends WatchlistMovieStatusState {
  final message = 'Removed Failed';

  @override
  List<Object> get props => [message];
}
