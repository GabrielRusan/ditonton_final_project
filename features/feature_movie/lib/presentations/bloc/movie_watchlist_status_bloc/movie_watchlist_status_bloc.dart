import 'package:feature_movie/domain/entities/movie_detail.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_status.dart';
import 'package:feature_movie/domain/usecases/remove_watchlist.dart';
import 'package:feature_movie/domain/usecases/save_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_status_event.dart';
part 'movie_watchlist_status_state.dart';

class MovieWatchlistStatusBloc
    extends Bloc<MovieWatchlistStatusEvent, MovieWatchlistStatusState> {
  final GetWatchListStatus _getMovieWatchlistStatus;
  final SaveWatchlist _saveWatchlistMovie;
  final RemoveWatchlist _removeWatchlistMovie;
  MovieWatchlistStatusBloc(this._getMovieWatchlistStatus,
      this._saveWatchlistMovie, this._removeWatchlistMovie)
      : super(const MovieWatchlistStatusLoaded(isAddedToWatchlist: false)) {
    on<LoadWatchlistStatus>(_onLoadWatchlistStatus);
    on<AddToWatchlist>(_onAddToWatchlist);
    on<RemoveFromWatchlist>(_onRemoveFromWatchlist);
  }

  Future<void> _onLoadWatchlistStatus(LoadWatchlistStatus event,
      Emitter<MovieWatchlistStatusState> emit) async {
    final status = await _getMovieWatchlistStatus.execute(event.id);
    emit(MovieWatchlistStatusLoaded(isAddedToWatchlist: status));
  }

  Future<void> _onAddToWatchlist(
      AddToWatchlist event, Emitter<MovieWatchlistStatusState> emit) async {
    final result = await _saveWatchlistMovie.execute(event.movie);

    result.fold((failure) {
      emit(FailAddMovie());
    }, (message) {
      emit(SuccessAddMovie());
    });

    add(LoadWatchlistStatus(id: event.movie.id));
  }

  Future<void> _onRemoveFromWatchlist(RemoveFromWatchlist event,
      Emitter<MovieWatchlistStatusState> emit) async {
    final result = await _removeWatchlistMovie.execute(event.movie);

    result.fold((failure) {
      emit(FailRemoveMovie());
    }, (message) {
      emit(SuccessRemoveMovie());
    });

    add(LoadWatchlistStatus(id: event.movie.id));
  }
}
