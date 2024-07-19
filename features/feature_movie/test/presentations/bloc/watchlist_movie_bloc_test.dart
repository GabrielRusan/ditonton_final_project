import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/presentations/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovie;

  setUp(() {
    mockGetWatchlistMovie = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovie);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
    genreIds: const [],
    video: false,
    popularity: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test('Initial state should be TopRatedMovieEmpty', () {
    expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfuly',
    build: () {
      when(mockGetWatchlistMovie.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () =>
        [WatchlistMovieLoading(), WatchlistMovieHasData(result: tMovieList)],
  );
  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Empty] when data is gotten successfuly but empty',
    build: () {
      when(mockGetWatchlistMovie.execute())
          .thenAnswer((_) async => const Right([]));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [WatchlistMovieLoading(), WatchlistMovieEmpty()],
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Error] when data is gotten successfuly',
    build: () {
      when(mockGetWatchlistMovie.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Error')));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [WatchlistMovieLoading(), WatchlistMovieError()],
  );
}
