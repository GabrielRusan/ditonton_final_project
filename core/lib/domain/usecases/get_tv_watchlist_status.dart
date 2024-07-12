import 'package:core/domain/repositories/movie_repository.dart';

class GetTvWatchlistStatus {
  final MovieRepository _repository;
  const GetTvWatchlistStatus(this._repository);

  Future<bool> execute(int id) {
    return _repository.isAddedToWatchlistTv(id);
  }
}
