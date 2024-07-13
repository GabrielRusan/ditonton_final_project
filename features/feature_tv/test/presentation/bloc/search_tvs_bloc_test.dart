import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/domain/usecases/search_tvs.dart';
import 'package:feature_tv/presentation/bloc/search_tvs_bloc/search_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tvs_bloc_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late SearchTvsBloc searchTvsBloc;
  late MockSearchTvs mockSearchTvs;
  setUp(() {
    mockSearchTvs = MockSearchTvs();
    searchTvsBloc = SearchTvsBloc(mockSearchTvs);
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
  const tQuery = 'spiderman';

  test('Initial state should be SearchTvsEmpty', () {
    expect(searchTvsBloc.state, SearchTvsEmpty());
  });

  blocTest<SearchTvsBloc, SearchTvsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchTvsBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(query: tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvsLoading(),
      SearchTvsHasData(result: tTvList),
    ],
  );

  blocTest<SearchTvsBloc, SearchTvsState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => const Right(<Tv>[]));
      return searchTvsBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(query: tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvsLoading(),
      SearchTvsEmpty(),
    ],
  );

  blocTest<SearchTvsBloc, SearchTvsState>(
    'Should emit [Loading, Error] when get search is unsuccesful',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchTvsBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(query: tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvsLoading(),
      const SearchTvsError('Server Failure'),
    ],
  );
}
