import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/domain/repositories/tv_repository.dart';

class GetTopRatedTv {
  final TvRepository _repository;
  const GetTopRatedTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getTopRatedTv();
  }
}
