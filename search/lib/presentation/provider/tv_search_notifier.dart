import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/foundation.dart';
import 'package:search/domain/usecases/search_tvs.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvs searchTvs;

  TvSearchNotifier({required this.searchTvs});

  List<Tv> _tvs = [];
  List<Tv> get tvs => _tvs;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchSearchTv(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvs.execute(query);

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
