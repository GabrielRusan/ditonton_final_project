import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tvs.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvs usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchTvs(mockMovieRepository);
  });

  test('Should get list of tv from repository when every thing is allright',
      () async {
    // arrange
    when(mockMovieRepository.searchTvs('The Boys'))
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute('The Boys');
    // assert
    expect(result, Right(testTvList));
  });
}
