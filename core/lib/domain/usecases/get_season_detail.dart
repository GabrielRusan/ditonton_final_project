import 'package:core/domain/entities/season_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/repositories/movie_repository.dart';

class GetSeasonDetail {
  final MovieRepository _repository;
  const GetSeasonDetail(this._repository);

  Future<Either<Failure, SeasonDetail>> execute(int id, int seasonNumber) {
    return _repository.getSeasonDetail(id, seasonNumber);
  }
}
