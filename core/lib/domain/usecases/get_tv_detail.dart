import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';

class GetTvDetail {
  final MovieRepository _repository;
  const GetTvDetail(this._repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return _repository.getTvDetail(id);
  }
}
