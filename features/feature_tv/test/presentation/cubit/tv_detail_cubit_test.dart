import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/presentation/cubit/tv_detail_cubit/tv_detail_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late TvDetailCubit cubit;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    cubit = TvDetailCubit(mockGetTvDetail);
  });

  test('initial state should be TvDetailLoading', () {
    expect(cubit.state, TvDetailLoading());
  });

  blocTest<TvDetailCubit, TvDetailState>(
    'should emit [Loading, HasData] when fetching data is success',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((_) async => Right(tTvDetail));
      return cubit;
    },
    act: (bloc) async => await bloc.fetchTvDetail(1),
    expect: () => [TvDetailLoading(), TvDetailHasData(result: tTvDetail)],
  );

  blocTest<TvDetailCubit, TvDetailState>(
    'should emit [Loading, Error] when fetching data is not success',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure('')));
      return cubit;
    },
    act: (bloc) async => await bloc.fetchTvDetail(1),
    expect: () => [TvDetailLoading(), TvDetailError()],
  );
}
