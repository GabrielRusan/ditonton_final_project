import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveWatchlistTv(mockMovieRepository);
  });

  test(
      'Should get "Added to Watchlist" from repository when every thing is allright',
      () async {
    // arrange
    when(mockMovieRepository.saveWatchlistTv(tTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(tTvDetail);
    // assert
    expect(result, Right('Added to Watchlist'));
  });
}
