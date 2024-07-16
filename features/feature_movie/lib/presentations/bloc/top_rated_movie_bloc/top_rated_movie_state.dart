part of 'top_rated_movie_bloc.dart';

sealed class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

final class TopRatedMovieEmpty extends TopRatedMovieState {}

final class TopRatedMovieLoading extends TopRatedMovieState {}

final class TopRatedMovieError extends TopRatedMovieState {}

final class TopRatedMovieHasData extends TopRatedMovieState {
  final List<Movie> result;

  const TopRatedMovieHasData({required this.result});

  @override
  List<Object> get props => [result];
}
