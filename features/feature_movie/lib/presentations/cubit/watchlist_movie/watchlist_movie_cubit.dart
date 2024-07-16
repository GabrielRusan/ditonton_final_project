import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/entities/movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_movies.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_status.dart';
import 'package:feature_movie/domain/usecases/remove_watchlist.dart';
import 'package:feature_movie/domain/usecases/save_watchlist.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieCubit extends Cubit<WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMovieCubit(this._getWatchlistMovies) : super(WatchlistMovieEmpty());

  Future<void> fetchWatchlistMovie() async {
    emit(WatchlistMovieLoading());
    final result = await _getWatchlistMovies.execute();

    result.fold((failure) {
      emit(WatchlistMovieError());
    }, (movieList) {
      if (movieList.isEmpty) {
        emit(WatchlistMovieEmpty());
      } else {
        emit(WatchlistMovieHasData(result: movieList));
      }
    });
  }
}

class WatchlistMovieStatusCubit extends Cubit<WatchlistMovieStatusState> {
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;
  WatchlistMovieStatusCubit(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(const WatchlistMovieStatusLoaded(isAddedToWatchlist: false));

  Future<void> loadWatchlistStatus(int id) async {
    final result = await _getWatchListStatus.execute(id);
    emit(WatchlistMovieStatusLoaded(isAddedToWatchlist: result));
  }

  Future<void> saveToWatchlist(MovieDetail movie) async {
    final result = await _saveWatchlist.execute(movie);

    result.fold((failure) {
      emit(WatchlistAddedError());
    }, (message) {
      emit(WatchlistAddedSuccess());
    });
    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await _removeWatchlist.execute(movie);

    result.fold((failure) {
      emit(WatchlistRemovedError());
    }, (message) {
      emit(WatchlistRemovedSuccess());
    });
    await loadWatchlistStatus(movie.id);
  }
}
