import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTvDetail(mockMovieRepository);
  });

  test('Should get list of tv from repository when every thing is allright',
      () async {
    // arrange
    when(mockMovieRepository.getTvDetail(1))
        .thenAnswer((_) async => Right(tTvDetail));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, Right(tTvDetail));
  });
}
