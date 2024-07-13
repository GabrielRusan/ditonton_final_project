import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetail(mockTvRepository);
  });

  test('Should get list of tv from repository when every thing is allright',
      () async {
    // arrange
    when(mockTvRepository.getTvDetail(1))
        .thenAnswer((_) async => Right(tTvDetail));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, Right(tTvDetail));
  });
}
