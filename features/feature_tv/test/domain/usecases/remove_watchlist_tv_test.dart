import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchlistTv(mockTvRepository);
  });

  test(
      'Should get "Removed from Watchlist" message from repository when every thing is allright',
      () async {
    // arrange
    when(mockTvRepository.removeWatchlistTv(tTvDetail))
        .thenAnswer((_) async => Right('Removed from Watchlist'));
    // act
    final result = await usecase.execute(tTvDetail);
    // assert
    expect(result, Right('Removed from Watchlist'));
  });
}
