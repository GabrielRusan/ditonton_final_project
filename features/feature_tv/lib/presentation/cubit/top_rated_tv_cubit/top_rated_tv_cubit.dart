import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_state.dart';

class TopRatedTvCubit extends Cubit<TopRatedTvState> {
  final GetTopRatedTv _getTopRatedTv;
  TopRatedTvCubit(this._getTopRatedTv) : super(TopRatedTvEmpty());

  Future<void> fetchTopRatedTv() async {
    emit(TopRatedTvLoading());
    final result = await _getTopRatedTv.execute();

    result.fold((failure) {
      emit(TopRatedTvError());
    }, (tvList) {
      if (tvList.isEmpty) {
        emit(TopRatedTvEmpty());
      } else {
        emit(TopRatedTvHasData(result: tvList));
      }
    });
  }
}
