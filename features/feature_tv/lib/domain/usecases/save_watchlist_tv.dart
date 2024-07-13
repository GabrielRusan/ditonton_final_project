import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:feature_tv/domain/entities/tv_detail.dart';
import 'package:feature_tv/domain/repositories/tv_repository.dart';

class SaveWatchlistTv {
  final TvRepository _repository;
  const SaveWatchlistTv(this._repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return _repository.saveWatchlistTv(tv);
  }
}
