import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/repositories/movie_repository.dart';

class GetTvRecommendations {
  final MovieRepository _repository;
  const GetTvRecommendations(this._repository);

  Future<Either<Failure, List<Tv>>> execute(int id) {
    return _repository.getTvRecommendations(id);
  }
}
