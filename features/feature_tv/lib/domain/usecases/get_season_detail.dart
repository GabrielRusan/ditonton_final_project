import 'package:feature_tv/domain/entities/season_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/repositories/tv_repository.dart';

class GetSeasonDetail {
  final TvRepository _repository;
  const GetSeasonDetail(this._repository);

  Future<Either<Failure, SeasonDetail>> execute(int id, int seasonNumber) {
    return _repository.getSeasonDetail(id, seasonNumber);
  }
}
