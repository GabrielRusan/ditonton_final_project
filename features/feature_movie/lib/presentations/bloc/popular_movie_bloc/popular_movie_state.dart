part of 'popular_movie_bloc.dart';

sealed class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

final class PopularMovieEmpty extends PopularMovieState {}

final class PopularMovieLoading extends PopularMovieState {}

final class PopularMovieError extends PopularMovieState {}

final class PopularMovieHasData extends PopularMovieState {
  final List<Movie> result;

  const PopularMovieHasData({required this.result});

  @override
  List<Object> get props => [result];
}
