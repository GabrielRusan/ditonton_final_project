part of 'tv_detail_cubit.dart';

sealed class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

final class TvDetailLoading extends TvDetailState {}

final class TvDetailError extends TvDetailState {}

final class TvDetailHasData extends TvDetailState {
  final TvDetail result;

  const TvDetailHasData({required this.result});

  @override
  List<Object> get props => [result];
}
