import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/presentation/bloc/recommendation_tv_bloc/recommendation_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late RecommendationTvBloc popularTvBloc;
  late MockGetTvRecommendations mockGetRecommendationTv;
  setUp(() {
    mockGetRecommendationTv = MockGetTvRecommendations();
    popularTvBloc = RecommendationTvBloc(mockGetRecommendationTv);
  });

  final tTvModel = Tv(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
    originCountry: const ['IDN'],
    originalLanguage: 'Bahasa',
  );
  final tTvList = <Tv>[tTvModel];

  test('Initial state should be RecommendationTvEmpty', () {
    expect(popularTvBloc.state, RecommendationTvEmpty());
  });

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationTv.execute(1))
          .thenAnswer((_) async => Right(tTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTv(id: 1)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationTvLoading(),
      RecommendationTvHasData(result: tTvList),
    ],
  );

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetRecommendationTv.execute(1))
          .thenAnswer((_) async => const Right(<Tv>[]));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTv(id: 1)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationTvLoading(),
      RecommendationTvEmpty(),
    ],
  );

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [Loading, Error] when get data is unsuccesful',
    build: () {
      when(mockGetRecommendationTv.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTv(id: 1)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationTvLoading(),
      RecommendationTvError(),
    ],
  );
}
