import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/domain/usecases/get_watchlist_tvs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTvs _getWatchlistTv;
  WatchlistTvBloc(this._getWatchlistTv) : super(WatchlistTvEmpty()) {
    on<FetchWatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());

      final result = await _getWatchlistTv.execute();

      result.fold((failure) {
        emit(WatchlistTvError());
      }, (tvList) {
        if (tvList.isEmpty) {
          emit(WatchlistTvEmpty());
        } else {
          emit(WatchlistTvHasData(result: tvList));
        }
      });
    });
  }
}
