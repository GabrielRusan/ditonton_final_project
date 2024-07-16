part of 'movie_recommendation_bloc.dart';

sealed class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

final class MovieRecommendationHasData extends MovieRecommendationState {
  final List<Movie> result;

  const MovieRecommendationHasData({required this.result});

  @override
  List<Object> get props => [result];
}

final class MovieRecommendationLoading extends MovieRecommendationState {}

final class MovieRecommendationEmpty extends MovieRecommendationState {}

final class MovieRecommendationError extends MovieRecommendationState {}
