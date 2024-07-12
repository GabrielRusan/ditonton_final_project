import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';

class RemoveWatchlistTv {
  final MovieRepository _repository;
  const RemoveWatchlistTv(this._repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return _repository.removeWatchlistTv(tv);
  }
}
