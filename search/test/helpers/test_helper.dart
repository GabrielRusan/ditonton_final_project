import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tvs.dart';

@GenerateMocks([MovieRepository, SearchMovies, SearchTvs])
void main() {}
