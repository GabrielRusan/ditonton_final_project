import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/presentation/cubit/top_rated_tv_cubit/top_rated_tv_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late TopRatedTvCubit cubit;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    cubit = TopRatedTvCubit(mockGetTopRatedTv);
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

  test('initial state should be TopRatedTvEmpty', () {
    expect(cubit.state, TopRatedTvEmpty());
  });

  blocTest<TopRatedTvCubit, TopRatedTvState>(
    'should emit [Loading, HasData] when fetching data is success',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      return cubit;
    },
    act: (bloc) async => await bloc.fetchTopRatedTv(),
    expect: () => [TopRatedTvLoading(), TopRatedTvHasData(result: tTvList)],
  );
  blocTest<TopRatedTvCubit, TopRatedTvState>(
    'should emit [Loading, Empty] when fetching data is success but empty',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Right([]));
      return cubit;
    },
    act: (bloc) async => await bloc.fetchTopRatedTv(),
    expect: () => [TopRatedTvLoading(), TopRatedTvEmpty()],
  );
  blocTest<TopRatedTvCubit, TopRatedTvState>(
    'should emit [Loading, Error] when fetching data is not success',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('')));
      return cubit;
    },
    act: (bloc) async => await bloc.fetchTopRatedTv(),
    expect: () => [TopRatedTvLoading(), TopRatedTvError()],
  );
}
