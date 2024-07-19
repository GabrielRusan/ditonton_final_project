import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_movie/presentations/bloc/movie_watchlist_status_bloc/movie_watchlist_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late MovieWatchlistStatusBloc bloc;
  late MockGetWatchListStatus mockGetMovieWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlistMovie;
  late MockRemoveWatchlist mockRemoveWatchlistMovie;

  setUp(() {
    mockGetMovieWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlistMovie = MockSaveWatchlist();
    mockRemoveWatchlistMovie = MockRemoveWatchlist();
    bloc = MovieWatchlistStatusBloc(mockGetMovieWatchlistStatus,
        mockSaveWatchlistMovie, mockRemoveWatchlistMovie);
  });

  test('initial state should be MovieWatchlistStatusLoading(false)', () {
    expect(bloc.state,
        const MovieWatchlistStatusLoaded(isAddedToWatchlist: false));
  });

  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
    'should emit [Loaded(true)] when movie is in watchlist',
    build: () {
      when(mockGetMovieWatchlistStatus.execute(1))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistStatus(id: 1)),
    expect: () => [const MovieWatchlistStatusLoaded(isAddedToWatchlist: true)],
  );

  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
    'should emit [Loaded(false)] when movie is not in watchlist',
    build: () {
      when(mockGetMovieWatchlistStatus.execute(1))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistStatus(id: 1)),
    expect: () => [const MovieWatchlistStatusLoaded(isAddedToWatchlist: false)],
  );

  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
    'should emit [SuccessAdd, Loaded(true)] when saving movie to watchlist is succesful',
    build: () {
      when(mockSaveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetMovieWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(const AddToWatchlist(movie: testMovieDetail)),
    expect: () => [
      SuccessAddMovie(),
      const MovieWatchlistStatusLoaded(isAddedToWatchlist: true)
    ],
  );

  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
    'should emit [FailAdd, Loaded(false)] when saving movie to watchlist is not success',
    build: () {
      when(mockSaveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('')));
      when(mockGetMovieWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(const AddToWatchlist(movie: testMovieDetail)),
    expect: () => [
      FailAddMovie(),
      const MovieWatchlistStatusLoaded(isAddedToWatchlist: false)
    ],
  );

  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
    'should emit [SuccessRemove, Loaded(false)] when removing movie from watchlist is success',
    build: () {
      when(mockRemoveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => const Right(''));
      when(mockGetMovieWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(const RemoveFromWatchlist(movie: testMovieDetail)),
    expect: () => [
      SuccessRemoveMovie(),
      const MovieWatchlistStatusLoaded(isAddedToWatchlist: false)
    ],
  );
  blocTest<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
    'should emit [FailRemove, Loaded(true)] when remove movie from watchlist is not success',
    build: () {
      when(mockRemoveWatchlistMovie.execute(testMovieDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('')));
      when(mockGetMovieWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(const RemoveFromWatchlist(movie: testMovieDetail)),
    expect: () => [
      FailRemoveMovie(),
      const MovieWatchlistStatusLoaded(isAddedToWatchlist: true)
    ],
  );
}
