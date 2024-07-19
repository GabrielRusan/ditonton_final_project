part of 'airing_today_tv_cubit.dart';

abstract class AiringTodayTvState extends Equatable {
  const AiringTodayTvState();

  @override
  List<Object> get props => [];
}

final class AiringTodayTvEmpty extends AiringTodayTvState {}

final class AiringTodayTvLoading extends AiringTodayTvState {}

final class AiringTodayTvError extends AiringTodayTvState {}

final class AiringTodayTvHasData extends AiringTodayTvState {
  final List<Tv> result;

  const AiringTodayTvHasData({required this.result});

  @override
  List<Object> get props => [result];
}
