part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailError extends MovieDetailState {}

final class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail result;

  const MovieDetailLoaded({required this.result});

  @override
  List<Object> get props => [result];
}
