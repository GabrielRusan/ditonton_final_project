import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/presentation/cubit/watchlist_tv_status_cubit/watchlist_tv_status_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late WatchlistTvStatusCubit cubit;
  late MockGetTvWatchlistStatus mockGetWatchlistTvStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetWatchlistTvStatus = MockGetTvWatchlistStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    cubit = WatchlistTvStatusCubit(
        mockGetWatchlistTvStatus, mockSaveWatchlistTv, mockRemoveWatchlistTv);
  });

  test('initial state should be WatchlistTvStatusLoading(false)', () {
    expect(
        cubit.state, const WatchlistTvStatusLoaded(isAddedToWatchlist: false));
  });

  blocTest<WatchlistTvStatusCubit, WatchlistTvStatusState>(
    'should emit [SuccessAdd, Loaded(true)] when saving tv to watchlist is succesful',
    build: () {
      when(mockSaveWatchlistTv.execute(tTvDetail))
          .thenAnswer((_) async => const Right(''));
      when(mockGetWatchlistTvStatus.execute(tTvDetail.id))
          .thenAnswer((_) async => true);
      return cubit;
    },
    act: (bloc) async => await bloc.addTvToWatchlist(tTvDetail),
    expect: () => [
      SuccessAddTv(),
      const WatchlistTvStatusLoaded(isAddedToWatchlist: true)
    ],
  );

  blocTest<WatchlistTvStatusCubit, WatchlistTvStatusState>(
    'should emit [FailAdd, Loaded(false)] when saving tv to watchlist is not success',
    build: () {
      when(mockSaveWatchlistTv.execute(tTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('')));
      when(mockGetWatchlistTvStatus.execute(tTvDetail.id))
          .thenAnswer((_) async => false);
      return cubit;
    },
    act: (bloc) async => await bloc.addTvToWatchlist(tTvDetail),
    expect: () =>
        [FailAddTv(), const WatchlistTvStatusLoaded(isAddedToWatchlist: false)],
  );

  blocTest<WatchlistTvStatusCubit, WatchlistTvStatusState>(
    'should emit [SuccessRemove, Loaded(false)] when removing tv from watchlist is success',
    build: () {
      when(mockRemoveWatchlistTv.execute(tTvDetail))
          .thenAnswer((_) async => const Right(''));
      when(mockGetWatchlistTvStatus.execute(tTvDetail.id))
          .thenAnswer((_) async => false);
      return cubit;
    },
    act: (bloc) async => await bloc.removeTvFromWatchlist(tTvDetail),
    expect: () => [
      SuccessRemoveTv(),
      const WatchlistTvStatusLoaded(isAddedToWatchlist: false)
    ],
  );
  blocTest<WatchlistTvStatusCubit, WatchlistTvStatusState>(
    'should emit [FailRemove, Loaded(true)] when remove tv from watchlist is not success',
    build: () {
      when(mockRemoveWatchlistTv.execute(tTvDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('')));
      when(mockGetWatchlistTvStatus.execute(tTvDetail.id))
          .thenAnswer((_) async => true);
      return cubit;
    },
    act: (bloc) async => await bloc.removeTvFromWatchlist(tTvDetail),
    expect: () => [
      FailRemoveTv(),
      const WatchlistTvStatusLoaded(isAddedToWatchlist: true)
    ],
  );
}
