import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';

class SaveWatchlistTv {
  final MovieRepository _repository;
  const SaveWatchlistTv(this._repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return _repository.saveWatchlistTv(tv);
  }
}
