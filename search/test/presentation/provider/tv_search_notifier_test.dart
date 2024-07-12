import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/presentation/provider/tv_search_notifier.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSearchNotifier provider;
  late MockSearchTvs mockSearchTvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvs = MockSearchTvs();
    provider = TvSearchNotifier(searchTvs: mockSearchTvs)
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

  const String query = 'query';

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockSearchTvs.execute(query)).thenAnswer((_) async => Right(tTvList));
    // act
    provider.fetchSearchTv(query);
    // assert
    expect(provider.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockSearchTvs.execute(query)).thenAnswer((_) async => Right(tTvList));
    // act
    await provider.fetchSearchTv(query);
    // assert
    expect(provider.state, RequestState.Loaded);
    expect(provider.tvs, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockSearchTvs.execute(query))
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await provider.fetchSearchTv(query);
    // assert
    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
