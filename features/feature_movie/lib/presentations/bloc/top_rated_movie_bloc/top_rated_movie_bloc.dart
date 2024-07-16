import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovies;
  TopRatedMovieBloc(this._getTopRatedMovies) : super(TopRatedMovieEmpty()) {
    on<FetchTopRatedMovieEvent>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold((failure) {
        emit(TopRatedMovieError());
      }, (movieList) {
        if (movieList.isEmpty) {
          emit(TopRatedMovieEmpty());
        } else {
          emit(TopRatedMovieHasData(result: movieList));
        }
      });
    });
  }
}
