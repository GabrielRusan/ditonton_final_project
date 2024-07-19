import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/presentation/bloc/tv_watchlist_status_bloc/tv_watchlist_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late TvWatchlistStatusBloc bloc;
  late MockGetTvWatchlistStatus mockGetTvWatchlistStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetTvWatchlistStatus = MockGetTvWatchlistStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    bloc = TvWatchlistStatusBloc(
        mockGetTvWatchlistStatus, mockSaveWatchlistTv, mockRemoveWatchlistTv);
  });

  test('initial state should be TvWatchlistStatusLoading(false)', () {
    expect(
        bloc.state, const TvWatchlistStatusLoaded(isAddedToWatchlist: false));
  });

  blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
    'should emit [Loaded(true)] when tv is in watchlist',
    build: () {
      when(mockGetTvWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistStatus(id: 1)),
    expect: () => [const TvWatchlistStatusLoaded(isAddedToWatchlist: true)],
  );

  blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
    'should emit [Loaded(false)] when tv is not in watchlist',
    build: () {
      when(mockGetTvWatchlistStatus.execute(1)).thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistStatus(id: 1)),
    expect: () => [const TvWatchlistStatusLoaded(isAddedToWatchlist: false)],
  );

  blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
    'should emit [SuccessAdd, Loaded(true)] when saving tv to watchlist is succesful',
    build: () {
      when(mockSaveWatchlistTv.execute(tTvDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetTvWatchlistStatus.execute(tTvDetail.id))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(AddToWatchlist(tv: tTvDetail)),
    expect: () => [
      SuccessAddTv(),
      const TvWatchlistStatusLoaded(isAddedToWatchlist: true)
    ],
  );

  blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
    'should emit [FailAdd, Loaded(false)] when saving tv to watchlist is not success',
    build: () {
      when(mockSaveWatchlistTv.execute(tTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('')));
      when(mockGetTvWatchlistStatus.execute(tTvDetail.id))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(AddToWatchlist(tv: tTvDetail)),
    expect: () =>
        [FailAddTv(), const TvWatchlistStatusLoaded(isAddedToWatchlist: false)],
  );

  blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
    'should emit [SuccessRemove, Loaded(false)] when removing tv from watchlist is success',
    build: () {
      when(mockRemoveWatchlistTv.execute(tTvDetail))
          .thenAnswer((_) async => const Right(''));
      when(mockGetTvWatchlistStatus.execute(tTvDetail.id))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(tv: tTvDetail)),
    expect: () => [
      SuccessRemoveTv(),
      const TvWatchlistStatusLoaded(isAddedToWatchlist: false)
    ],
  );
  blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
    'should emit [FailRemove, Loaded(true)] when remove tv from watchlist is not success',
    build: () {
      when(mockRemoveWatchlistTv.execute(tTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('')));
      when(mockGetTvWatchlistStatus.execute(tTvDetail.id))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(tv: tTvDetail)),
    expect: () => [
      FailRemoveTv(),
      const TvWatchlistStatusLoaded(isAddedToWatchlist: true)
    ],
  );
}
