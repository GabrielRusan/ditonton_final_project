part of 'search_movies_bloc.dart';

sealed class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object> get props => [];
}

final class SearchMoviesEmpty extends SearchMoviesState {}

final class SearchMoviesLoading extends SearchMoviesState {}

final class SearchMoviesError extends SearchMoviesState {
  final String message;

  const SearchMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

final class SearchMoviesHasData extends SearchMoviesState {
  final List<Movie> result;

  const SearchMoviesHasData({required this.result});

  @override
  List<Object> get props => [result];
}
