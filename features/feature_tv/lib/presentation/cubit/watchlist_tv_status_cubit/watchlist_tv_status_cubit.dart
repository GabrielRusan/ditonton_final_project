import 'package:feature_tv/domain/entities/tv_detail.dart';
import 'package:feature_tv/domain/usecases/get_tv_watchlist_status.dart';
import 'package:feature_tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:feature_tv/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_status_state.dart';

class WatchlistTvStatusCubit extends Cubit<WatchlistTvStatusState> {
  final GetTvWatchlistStatus _getTvWatchlistStatus;
  final SaveWatchlistTv _saveWatchlistTv;
  final RemoveWatchlistTv _removeWatchlistTv;

  WatchlistTvStatusCubit(this._getTvWatchlistStatus, this._saveWatchlistTv,
      this._removeWatchlistTv)
      : super(const WatchlistTvStatusLoaded(isAddedToWatchlist: false));

  Future<void> loadWatchlistTvStatus(int id) async {
    final status = await _getTvWatchlistStatus.execute(id);

    emit(WatchlistTvStatusLoaded(isAddedToWatchlist: status));
  }

  Future<void> addTvToWatchlist(TvDetail tv) async {
    final result = await _saveWatchlistTv.execute(tv);

    result.fold((failure) {
      emit(FailAddTv());
    }, (message) {
      emit(SuccessAddTv());
    });

    await loadWatchlistTvStatus(tv.id);
  }

  Future<void> removeTvFromWatchlist(TvDetail tv) async {
    final result = await _removeWatchlistTv.execute(tv);

    result.fold((failure) {
      emit(FailRemoveTv());
    }, (message) {
      emit(SuccessRemoveTv());
    });

    await loadWatchlistTvStatus(tv.id);
  }
}
