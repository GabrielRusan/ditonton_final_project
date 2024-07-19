import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecommendationTvBloc
    extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  final GetTvRecommendations _getRecommendationTv;
  RecommendationTvBloc(this._getRecommendationTv)
      : super(RecommendationTvEmpty()) {
    on<FetchRecommendationTv>((event, emit) async {
      emit(RecommendationTvLoading());

      final result = await _getRecommendationTv.execute(event.id);

      result.fold((failure) {
        emit(RecommendationTvError());
      }, (tvList) {
        if (tvList.isEmpty) {
          emit(RecommendationTvEmpty());
        } else {
          emit(RecommendationTvHasData(result: tvList));
        }
      });
    });
  }
}
