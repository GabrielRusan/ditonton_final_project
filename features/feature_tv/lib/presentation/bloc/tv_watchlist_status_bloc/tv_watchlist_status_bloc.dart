import 'package:feature_tv/domain/entities/tv_detail.dart';
import 'package:feature_tv/domain/usecases/get_tv_watchlist_status.dart';
import 'package:feature_tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:feature_tv/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_watchlist_status_event.dart';
part 'tv_watchlist_status_state.dart';

class TvWatchlistStatusBloc
    extends Bloc<TvWatchlistStatusEvent, TvWatchlistStatusState> {
  final GetTvWatchlistStatus _getTvWatchlistStatus;
  final SaveWatchlistTv _saveWatchlistTv;
  final RemoveWatchlistTv _removeWatchlistTv;
  TvWatchlistStatusBloc(this._getTvWatchlistStatus, this._saveWatchlistTv,
      this._removeWatchlistTv)
      : super(const TvWatchlistStatusLoaded(isAddedToWatchlist: false)) {
    on<LoadWatchlistStatus>(_onLoadWatchlistStatus);
    on<AddToWatchlist>(_onAddToWatchlist);
    on<RemoveFromWatchlist>(_onRemoveFromWatchlist);
  }

  Future<void> _onLoadWatchlistStatus(
      LoadWatchlistStatus event, Emitter<TvWatchlistStatusState> emit) async {
    final status = await _getTvWatchlistStatus.execute(event.id);
    emit(TvWatchlistStatusLoaded(isAddedToWatchlist: status));
  }

  Future<void> _onAddToWatchlist(
      AddToWatchlist event, Emitter<TvWatchlistStatusState> emit) async {
    final result = await _saveWatchlistTv.execute(event.tv);

    result.fold((failure) {
      emit(FailAddTv());
    }, (message) {
      emit(SuccessAddTv());
    });

    add(LoadWatchlistStatus(id: event.tv.id));
  }

  Future<void> _onRemoveFromWatchlist(
      RemoveFromWatchlist event, Emitter<TvWatchlistStatusState> emit) async {
    final result = await _removeWatchlistTv.execute(event.tv);

    result.fold((failure) {
      emit(FailRemoveTv());
    }, (message) {
      emit(SuccessRemoveTv());
    });

    add(LoadWatchlistStatus(id: event.tv.id));
  }
}
