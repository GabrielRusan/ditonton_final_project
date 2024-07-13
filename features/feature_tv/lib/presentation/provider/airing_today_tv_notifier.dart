import 'package:core/core.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/domain/usecases/get_airing_today_tv.dart';
import 'package:flutter/foundation.dart';

class AiringTodayTvNotifier extends ChangeNotifier {
  final GetAiringTodayTv getAiringTodayTv;

  AiringTodayTvNotifier(this.getAiringTodayTv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tvs = [];
  List<Tv> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchAiringTodayTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTv.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (tvsData) {
      _tvs = tvsData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
