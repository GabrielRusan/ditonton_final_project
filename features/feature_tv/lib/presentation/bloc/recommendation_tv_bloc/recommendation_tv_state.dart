part of 'recommendation_tv_bloc.dart';

sealed class RecommendationTvState extends Equatable {
  const RecommendationTvState();

  @override
  List<Object> get props => [];
}

final class RecommendationTvEmpty extends RecommendationTvState {}

final class RecommendationTvLoading extends RecommendationTvState {}

final class RecommendationTvError extends RecommendationTvState {}

final class RecommendationTvHasData extends RecommendationTvState {
  final List<Tv> result;

  const RecommendationTvHasData({required this.result});

  @override
  List<Object> get props => [result];
}
