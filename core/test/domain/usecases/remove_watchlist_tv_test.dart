import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveWatchlistTv(mockMovieRepository);
  });

  test(
      'Should get "Removed from Watchlist" message from repository when every thing is allright',
      () async {
    // arrange
    when(mockMovieRepository.removeWatchlistTv(tTvDetail))
        .thenAnswer((_) async => Right('Removed from Watchlist'));
    // act
    final result = await usecase.execute(tTvDetail);
    // assert
    expect(result, Right('Removed from Watchlist'));
  });
}
