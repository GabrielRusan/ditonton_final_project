part of 'tv_detail_bloc.dart';

sealed class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

final class TvDetailLoading extends TvDetailState {}

final class TvDetailError extends TvDetailState {}

final class TvDetailLoaded extends TvDetailState {
  final TvDetail tvDetail;
  final List<Tv> recommendationList;
  final List<SeasonDetail> seasonDetailList;

  const TvDetailLoaded(
      {required this.tvDetail,
      required this.recommendationList,
      required this.seasonDetailList});

  @override
  List<Object> get props => [tvDetail, recommendationList, seasonDetailList];
}
