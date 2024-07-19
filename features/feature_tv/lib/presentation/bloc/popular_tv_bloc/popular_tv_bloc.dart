import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/domain/usecases/get_popular_tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv _getPopularTv;
  PopularTvBloc(this._getPopularTv) : super(PopularTvEmpty()) {
    on<FetchPopularTv>((event, emit) async {
      emit(PopularTvLoading());

      final result = await _getPopularTv.execute();

      result.fold((failure) {
        emit(PopularTvError());
      }, (tvList) {
        if (tvList.isEmpty) {
          emit(PopularTvEmpty());
        } else {
          emit(PopularTvHasData(result: tvList));
        }
      });
    });
  }
}
