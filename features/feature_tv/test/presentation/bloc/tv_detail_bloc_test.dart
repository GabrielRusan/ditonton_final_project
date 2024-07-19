import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetSeasonDetail mockGetSeasonDetail;
  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetSeasonDetail = MockGetSeasonDetail();
    tvDetailBloc = TvDetailBloc(
      mockGetTvDetail,
      mockGetTvRecommendations,
      mockGetSeasonDetail,
    );
  });

  test('Initial state should be TvDetailEmpty', () {
    expect(tvDetailBloc.state, TvDetailLoading());
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((_) async => Right(tTvDetail));
      when(mockGetTvRecommendations.execute(1))
          .thenAnswer((_) async => Right(testTvList));
      when(mockGetSeasonDetail.execute(1, 1))
          .thenAnswer((_) async => const Right(tSeasonDetail));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTvDetail(id: 1)),
    expect: () => [
      TvDetailLoading(),
      TvDetailLoaded(
          tvDetail: tTvDetail,
          recommendationList: testTvList,
          seasonDetailList: const [tSeasonDetail]),
    ],
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when get data is unsuccesful',
    build: () {
      when(mockGetTvDetail.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetTvRecommendations.execute(1))
          .thenAnswer((_) async => Right(testTvList));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTvDetail(id: 1)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvDetailLoading(),
      TvDetailError(),
    ],
  );
}
