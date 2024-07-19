part of 'top_rated_tv_cubit.dart';

sealed class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

final class TopRatedTvEmpty extends TopRatedTvState {}

final class TopRatedTvLoading extends TopRatedTvState {}

final class TopRatedTvError extends TopRatedTvState {}

final class TopRatedTvHasData extends TopRatedTvState {
  final List<Tv> result;

  const TopRatedTvHasData({required this.result});

  @override
  List<Object> get props => [result];
}
