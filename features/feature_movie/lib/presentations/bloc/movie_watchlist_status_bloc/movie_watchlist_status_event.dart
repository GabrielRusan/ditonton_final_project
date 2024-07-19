part of 'movie_watchlist_status_bloc.dart';

sealed class MovieWatchlistStatusEvent extends Equatable {
  const MovieWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistStatus extends MovieWatchlistStatusEvent {
  final int id;

  const LoadWatchlistStatus({required this.id});

  @override
  List<Object> get props => [id];
}

class AddToWatchlist extends MovieWatchlistStatusEvent {
  final MovieDetail movie;

  const AddToWatchlist({required this.movie});

  @override
  List<Object> get props => [movie];
}

class RemoveFromWatchlist extends MovieWatchlistStatusEvent {
  final MovieDetail movie;

  const RemoveFromWatchlist({required this.movie});

  @override
  List<Object> get props => [movie];
}
