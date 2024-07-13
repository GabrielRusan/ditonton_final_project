import 'package:feature_tv/domain/repositories/tv_repository.dart';

class GetTvWatchlistStatus {
  final TvRepository _repository;
  const GetTvWatchlistStatus(this._repository);

  Future<bool> execute(int id) {
    return _repository.isAddedToWatchlistTv(id);
  }
}
