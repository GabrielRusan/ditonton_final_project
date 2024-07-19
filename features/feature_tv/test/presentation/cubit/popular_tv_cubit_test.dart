import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/presentation/cubit/popular_tv_cubit/popular_tv_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late PopularTvCubit cubit;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    cubit = PopularTvCubit(mockGetPopularTv);
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

  test('initial state should be PopularTvEmpty', () {
    expect(cubit.state, PopularTvEmpty());
  });

  blocTest<PopularTvCubit, PopularTvState>(
    'should emit [Loading, HasData] when fetching data is success',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      return cubit;
    },
    act: (bloc) async => await bloc.fetchPopularTv(),
    expect: () => [PopularTvLoading(), PopularTvHasData(result: tTvList)],
  );
  blocTest<PopularTvCubit, PopularTvState>(
    'should emit [Loading, Empty] when fetching data is success but empty',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer((_) async => const Right([]));
      return cubit;
    },
    act: (bloc) async => await bloc.fetchPopularTv(),
    expect: () => [PopularTvLoading(), PopularTvEmpty()],
  );
  blocTest<PopularTvCubit, PopularTvState>(
    'should emit [Loading, Error] when fetching data is not success',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => const Left(ServerFailure('')));
      return cubit;
    },
    act: (bloc) async => await bloc.fetchPopularTv(),
    expect: () => [PopularTvLoading(), PopularTvError()],
  );
}
