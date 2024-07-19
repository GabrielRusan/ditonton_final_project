import 'package:feature_tv/domain/entities/season_detail.dart';
import 'package:feature_tv/domain/usecases/get_season_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'season_detail_event.dart';
part 'season_detail_state.dart';

class SeasonDetailBloc extends Bloc<SeasonDetailEvent, SeasonDetailState> {
  final GetSeasonDetail _getSeasonDetail;
  SeasonDetailBloc(this._getSeasonDetail) : super(SeasonDetailEmpty()) {
    on<FetchSeasonDetails>((event, emit) async {
      emit(SeasonDetailLoading());

      List<SeasonDetail> seasonDetailList = [];

      for (int i = 0; i < event.numberOfSeasons; i++) {
        final result = await _getSeasonDetail.execute(event.id, i + 1);

        result.fold((failure) {}, (seasonDetail) {
          seasonDetailList.add(seasonDetail);
        });
      }

      if (seasonDetailList.isEmpty) {
        emit(SeasonDetailEmpty());
        return;
      }

      emit(SeasonDetailHasData(result: seasonDetailList));
    });
  }
}
