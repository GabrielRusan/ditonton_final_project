import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/repositories/movie_repository.dart';

class GetTopRatedTv {
  final MovieRepository _repository;
  const GetTopRatedTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getTopRatedTv();
  }
}
