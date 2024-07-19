part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailError extends MovieDetailState {}

final class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  final List<Movie> recommendationList;

  const MovieDetailLoaded({
    required this.movieDetail,
    required this.recommendationList,
  });

  @override
  List<Object> get props => [movieDetail, recommendationList];
}
