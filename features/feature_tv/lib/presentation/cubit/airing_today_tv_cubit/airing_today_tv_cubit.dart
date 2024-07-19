import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/domain/usecases/get_airing_today_tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'airing_today_tv_state.dart';

class AiringTodayTvCubit extends Cubit<AiringTodayTvState> {
  final GetAiringTodayTv _getAiringTodayTv;
  AiringTodayTvCubit(this._getAiringTodayTv) : super(AiringTodayTvEmpty());

  Future<void> fetchAiringTodayTv() async {
    emit(AiringTodayTvLoading());
    final result = await _getAiringTodayTv.execute();

    result.fold((failure) {
      emit(AiringTodayTvError());
    }, (tvList) {
      if (tvList.isEmpty) {
        emit(AiringTodayTvEmpty());
      } else {
        emit(AiringTodayTvHasData(result: tvList));
      }
    });
  }
}
