part of 'recommendation_tv_bloc.dart';

sealed class RecommendationTvEvent extends Equatable {
  const RecommendationTvEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendationTv extends RecommendationTvEvent {
  final int id;

  const FetchRecommendationTv({required this.id});

  @override
  List<Object> get props => [id];
}
