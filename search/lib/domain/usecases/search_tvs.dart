import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/repositories/movie_repository.dart';

class SearchTvs {
  final MovieRepository _repository;
  const SearchTvs(this._repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return _repository.searchTvs(query);
  }
}
