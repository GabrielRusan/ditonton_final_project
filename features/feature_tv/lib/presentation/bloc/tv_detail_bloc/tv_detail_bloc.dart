import 'package:feature_tv/domain/entities/season_detail.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/domain/entities/tv_detail.dart';
import 'package:feature_tv/domain/usecases/get_season_detail.dart';
import 'package:feature_tv/domain/usecases/get_tv_detail.dart';
import 'package:feature_tv/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;
  final GetTvRecommendations _getTvRecommendations;
  final GetSeasonDetail _getSeasonDetail;
  TvDetailBloc(
      this._getTvDetail, this._getTvRecommendations, this._getSeasonDetail)
      : super(TvDetailLoading()) {
    on<FetchTvDetail>(onFetchTvDetail);
  }

  Future<void> onFetchTvDetail(
      FetchTvDetail event, Emitter<TvDetailState> emit) async {
    emit(TvDetailLoading());

    final tvDetailResult = await _getTvDetail.execute(event.id);
    final recommendationResult = await _getTvRecommendations.execute(event.id);

    late TvDetail tvDetailValue;
    List<Tv> recommendations = [];
    List<SeasonDetail> seasonDetailList = [];

    tvDetailResult.fold((failure) {
      emit(TvDetailError());
    }, (tvDetail) {
      tvDetailValue = tvDetail;

      recommendationResult.fold((failure) {}, (tvList) {
        recommendations = tvList;
      });
    });

    if (state is! TvDetailError) {
      final int numberOfSeasons = tvDetailValue.numberOfSeasons ?? 0;

      for (int i = 0; i < numberOfSeasons; i++) {
        final result = await _getSeasonDetail.execute(event.id, i + 1);

        result.fold((failure) {}, (seasonDetail) {
          seasonDetailList.add(seasonDetail);
        });
      }

      emit(TvDetailLoaded(
        tvDetail: tvDetailValue,
        recommendationList: recommendations,
        seasonDetailList: seasonDetailList,
      ));
    }
  }
}
