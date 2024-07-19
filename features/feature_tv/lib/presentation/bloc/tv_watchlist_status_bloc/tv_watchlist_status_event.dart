part of 'tv_watchlist_status_bloc.dart';

sealed class TvWatchlistStatusEvent extends Equatable {
  const TvWatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistStatus extends TvWatchlistStatusEvent {
  final int id;

  const LoadWatchlistStatus({required this.id});

  @override
  List<Object> get props => [id];
}

class AddToWatchlist extends TvWatchlistStatusEvent {
  final TvDetail tv;

  const AddToWatchlist({required this.tv});

  @override
  List<Object> get props => [tv];
}

class RemoveFromWatchlist extends TvWatchlistStatusEvent {
  final TvDetail tv;

  const RemoveFromWatchlist({required this.tv});

  @override
  List<Object> get props => [tv];
}
