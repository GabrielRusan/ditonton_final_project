part of 'season_detail_bloc.dart';

sealed class SeasonDetailState extends Equatable {
  const SeasonDetailState();

  @override
  List<Object> get props => [];
}

final class SeasonDetailEmpty extends SeasonDetailState {}

final class SeasonDetailLoading extends SeasonDetailState {}

final class SeasonDetailError extends SeasonDetailState {}

final class SeasonDetailHasData extends SeasonDetailState {
  final List<SeasonDetail> result;

  const SeasonDetailHasData({required this.result});

  @override
  List<Object> get props => [result];
}
