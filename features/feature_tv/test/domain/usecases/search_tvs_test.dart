import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/search_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTvs(mockTvRepository);
  });

  test('Should get list of tv from repository when every thing is allright',
      () async {
    // arrange
    when(mockTvRepository.searchTvs('The Boys'))
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute('The Boys');
    // assert
    expect(result, Right(testTvList));
  });
}
