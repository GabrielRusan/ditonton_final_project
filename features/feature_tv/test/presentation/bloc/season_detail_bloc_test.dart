import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/presentation/bloc/season_detail_bloc/season_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late SeasonDetailBloc seasonDetailBloc;
  late MockGetSeasonDetail mockGetSeasonDetail;
  setUp(() {
    mockGetSeasonDetail = MockGetSeasonDetail();
    seasonDetailBloc = SeasonDetailBloc(mockGetSeasonDetail);
  });

  test('Initial state should be SeasonDetailEmpty', () {
    expect(seasonDetailBloc.state, SeasonDetailEmpty());
  });

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetSeasonDetail.execute(1, 1))
          .thenAnswer((_) async => const Right(tSeasonDetail));
      return seasonDetailBloc;
    },
    act: (bloc) =>
        bloc.add(const FetchSeasonDetails(id: 1, numberOfSeasons: 1)),
    expect: () => [
      SeasonDetailLoading(),
      const SeasonDetailHasData(result: [tSeasonDetail]),
    ],
  );

  blocTest<SeasonDetailBloc, SeasonDetailState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      return seasonDetailBloc;
    },
    act: (bloc) =>
        bloc.add(const FetchSeasonDetails(id: 1, numberOfSeasons: 0)),
    expect: () => [
      SeasonDetailLoading(),
      SeasonDetailEmpty(),
    ],
  );
}
