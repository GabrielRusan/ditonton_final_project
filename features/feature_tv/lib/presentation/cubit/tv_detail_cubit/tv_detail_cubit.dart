import 'package:feature_tv/domain/entities/tv_detail.dart';
import 'package:feature_tv/domain/usecases/get_tv_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_state.dart';

class TvDetailCubit extends Cubit<TvDetailState> {
  final GetTvDetail _getTvDetail;
  TvDetailCubit(this._getTvDetail) : super(TvDetailLoading());

  Future<void> fetchTvDetail(int id) async {
    emit(TvDetailLoading());
    final result = await _getTvDetail.execute(id);

    result.fold((failure) {
      emit(TvDetailError());
    }, (tvDetail) {
      emit(TvDetailHasData(result: tvDetail));
    });
  }
}
