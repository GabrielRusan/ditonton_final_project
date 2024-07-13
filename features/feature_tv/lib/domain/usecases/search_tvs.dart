import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/domain/repositories/tv_repository.dart';

class SearchTvs {
  final TvRepository _repository;
  const SearchTvs(this._repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return _repository.searchTvs(query);
  }
}
