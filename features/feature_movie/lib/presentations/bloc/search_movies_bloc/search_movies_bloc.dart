import 'package:core/utils/transformers.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/search_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;
  SearchMoviesBloc(this.searchMovies) : super(SearchMoviesInitial()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchMoviesLoading());
      final result = await searchMovies.execute(query);

      result.fold((failure) {
        emit(SearchMoviesError(failure.message));
      }, (movieList) {
        if (movieList.isEmpty) {
          emit(SearchMoviesEmpty());
        } else {
          emit(SearchMoviesHasData(result: movieList));
        }
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
