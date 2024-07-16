import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/presentations/cubit/watchlist_movie/watchlist_movie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late WatchlistMovieCubit watchlistMovieCubit;
  late WatchlistMovieStatusCubit watchlistMovieStatusCubit;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    watchlistMovieCubit = WatchlistMovieCubit(
      mockGetWatchlistMovies,
    );
    watchlistMovieStatusCubit = WatchlistMovieStatusCubit(
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  final int tId = 1;

  group('Watchlist Movie Test', () {
    test('Initial State should be WatchlistMovieEmpty', () {
      expect(watchlistMovieCubit.state, WatchlistMovieEmpty());
    });

    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      "Should emit [Loading, HasData] when data is gotten successfuly",
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return watchlistMovieCubit;
      },
      act: (bloc) => bloc.fetchWatchlistMovie(),
      expect: () =>
          [WatchlistMovieLoading(), WatchlistMovieHasData(result: tMovieList)],
    );
    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      "Should emit [Loading, Error] when error occured",
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Error')));
        return watchlistMovieCubit;
      },
      act: (bloc) => bloc.fetchWatchlistMovie(),
      expect: () => [WatchlistMovieLoading(), WatchlistMovieError()],
    );
    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      "Should emit [Loading, Empty] when data is gotten successfuly but empty",
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([]));
        return watchlistMovieCubit;
      },
      act: (bloc) => bloc.fetchWatchlistMovie(),
      expect: () => [WatchlistMovieLoading(), WatchlistMovieEmpty()],
    );
  });

  group('Watchlist Status test', () {
    test('Initial state should WatchlistMovieStatus(false)', () {
      expect(watchlistMovieStatusCubit.state,
          const WatchlistMovieStatusLoaded(isAddedToWatchlist: false));
    });
    group("cek watchlist status test", () {
      blocTest<WatchlistMovieStatusCubit, WatchlistMovieStatusState>(
        "Should emit WatchlistMovieStatusLoaded(isAddedToWatchlist: false) when movie is not in watchlist",
        build: () {
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => false);
          return watchlistMovieStatusCubit;
        },
        act: (bloc) => bloc.loadWatchlistStatus(tId),
        expect: () =>
            [const WatchlistMovieStatusLoaded(isAddedToWatchlist: false)],
      );

      blocTest<WatchlistMovieStatusCubit, WatchlistMovieStatusState>(
        "Should emit WatchlistMovieStatusLoaded(isAddedToWatchlist: true) when movie is in watchlist",
        build: () {
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return watchlistMovieStatusCubit;
        },
        act: (bloc) => bloc.loadWatchlistStatus(tId),
        expect: () =>
            [const WatchlistMovieStatusLoaded(isAddedToWatchlist: true)],
      );
    });

    group("Save watchlist", () {
      blocTest<WatchlistMovieStatusCubit, WatchlistMovieStatusState>(
        "Should emit [AddedSuccess, Loaded(true)] when movie added to watchlist succesfuly",
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Success Add'));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return watchlistMovieStatusCubit;
        },
        act: (bloc) => bloc.saveToWatchlist(testMovieDetail),
        expect: () => [
          WatchlistAddedSuccess(),
          const WatchlistMovieStatusLoaded(isAddedToWatchlist: true)
        ],
      );

      blocTest<WatchlistMovieStatusCubit, WatchlistMovieStatusState>(
        "Should emit [AddedError, Loaded(false)] when failed to added to watchlist ",
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => false);
          return watchlistMovieStatusCubit;
        },
        act: (bloc) => bloc.saveToWatchlist(testMovieDetail),
        expect: () => [
          WatchlistAddedError(),
          const WatchlistMovieStatusLoaded(isAddedToWatchlist: false)
        ],
      );
    });

    group("Remove watchlist", () {
      blocTest<WatchlistMovieStatusCubit, WatchlistMovieStatusState>(
        "Should emit [RemovedSuccess, Loaded(false)] when movie removed from watchlist succesfuly",
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Removed Success'));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => false);
          return watchlistMovieStatusCubit;
        },
        act: (bloc) => bloc.removeFromWatchlist(testMovieDetail),
        expect: () => [
          WatchlistRemovedSuccess(),
          const WatchlistMovieStatusLoaded(isAddedToWatchlist: false)
        ],
      );

      blocTest<WatchlistMovieStatusCubit, WatchlistMovieStatusState>(
        "Should emit [RemovedError, Loaded(true)] when failed to added to watchlist ",
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Left(DatabaseFailure('Error')));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return watchlistMovieStatusCubit;
        },
        act: (bloc) => bloc.removeFromWatchlist(testMovieDetail),
        expect: () => [
          WatchlistRemovedError(),
          const WatchlistMovieStatusLoaded(isAddedToWatchlist: true)
        ],
      );
    });
  });
}
