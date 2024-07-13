import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/domain/usecases/get_airing_today_tv.dart';
import 'package:feature_tv/presentation/provider/airing_today_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetAiringTodayTv])
void main() {
  late MockGetAiringTodayTv mockGetAiringTodayTv;
  late AiringTodayTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTodayTv = MockGetAiringTodayTv();
    notifier = AiringTodayTvNotifier(mockGetAiringTodayTv)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTv = Tv(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: const [1],
      id: 1,
      originCountry: const ['Us'],
      originalLanguage: 'originalLanguage',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      name: 'name',
      voteAverage: 1,
      voteCount: 1);

  final tTvList = <Tv>[tTv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetAiringTodayTv.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchAiringTodayTv();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetAiringTodayTv.execute())
        .thenAnswer((_) async => Right(tTvList));
    // act
    await notifier.fetchAiringTodayTv();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvs, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetAiringTodayTv.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchAiringTodayTv();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
