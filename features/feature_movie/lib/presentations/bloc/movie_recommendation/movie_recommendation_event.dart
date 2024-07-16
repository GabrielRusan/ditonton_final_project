part of 'movie_recommendation_bloc.dart';

sealed class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieRecommendation extends MovieRecommendationEvent {
  final int id;

  const FetchMovieRecommendation({required this.id});

  @override
  List<Object> get props => [id];
}
