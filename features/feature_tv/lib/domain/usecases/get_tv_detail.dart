import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv_detail.dart';
import 'package:feature_tv/domain/repositories/tv_repository.dart';

class GetTvDetail {
  final TvRepository _repository;
  const GetTvDetail(this._repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return _repository.getTvDetail(id);
  }
}
