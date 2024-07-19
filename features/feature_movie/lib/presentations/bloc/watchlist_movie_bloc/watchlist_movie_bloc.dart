import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  WatchlistMovieBloc(this._getWatchlistMovies) : super(WatchlistMovieEmpty()) {
    on<FetchWatchlistMovie>((event, emit) async {
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
    });
  }
}
