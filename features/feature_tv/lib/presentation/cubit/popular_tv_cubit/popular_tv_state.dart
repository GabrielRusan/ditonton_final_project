part of 'popular_tv_cubit.dart';

sealed class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

final class PopularTvEmpty extends PopularTvState {}

final class PopularTvLoading extends PopularTvState {}

final class PopularTvError extends PopularTvState {}

final class PopularTvHasData extends PopularTvState {
  final List<Tv> result;

  const PopularTvHasData({required this.result});

  @override
  List<Object> get props => [result];
}
