import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/get_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeasonDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetSeasonDetail(mockTvRepository);
  });

  test('Should get season detail from repository when every thing is allright',
      () async {
    // arrange
    when(mockTvRepository.getSeasonDetail(1, 1))
        .thenAnswer((_) async => Right(tSeasonDetail));
    // act
    final result = await usecase.execute(1, 1);
    // assert
    expect(result, Right(tSeasonDetail));
  });
}
