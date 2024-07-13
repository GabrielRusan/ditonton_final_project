import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveWatchlistTv(mockTvRepository);
  });

  test(
      'Should get "Added to Watchlist" from repository when every thing is allright',
      () async {
    // arrange
    when(mockTvRepository.saveWatchlistTv(tTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(tTvDetail);
    // assert
    expect(result, Right('Added to Watchlist'));
  });
}
