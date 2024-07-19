import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/presentation/cubit/airing_today_tv_cubit/airing_today_tv_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late AiringTodayTvCubit cubit;
  late MockGetAiringTodayTv mockGetAiringTodayTv;

  setUp(() {
    mockGetAiringTodayTv = MockGetAiringTodayTv();
    cubit = AiringTodayTvCubit(mockGetAiringTodayTv);
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

  test('initial state should be AiringTodayTvEmpty', () {
    expect(cubit.state, AiringTodayTvEmpty());
  });

  blocTest<AiringTodayTvCubit, AiringTodayTvState>(
    'should emit [Loading, HasData] when fetching data is success',
    build: () {
      when(mockGetAiringTodayTv.execute())
          .thenAnswer((_) async => Right(tTvList));
      return cubit;
    },
    act: (bloc) async => await bloc.fetchAiringTodayTv(),
    expect: () =>
        [AiringTodayTvLoading(), AiringTodayTvHasData(result: tTvList)],
  );
  blocTest<AiringTodayTvCubit, AiringTodayTvState>(
    'should emit [Loading, Empty] when fetching data is success but empty',
    build: () {
      when(mockGetAiringTodayTv.execute())
          .thenAnswer((_) async => const Right([]));
      return cubit;
    },
    act: (bloc) async => await bloc.fetchAiringTodayTv(),
    expect: () => [AiringTodayTvLoading(), AiringTodayTvEmpty()],
  );
  blocTest<AiringTodayTvCubit, AiringTodayTvState>(
    'should emit [Loading, Error] when fetching data is not success',
    build: () {
      when(mockGetAiringTodayTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('')));
      return cubit;
    },
    act: (bloc) async => await bloc.fetchAiringTodayTv(),
    expect: () => [AiringTodayTvLoading(), AiringTodayTvError()],
  );
}
