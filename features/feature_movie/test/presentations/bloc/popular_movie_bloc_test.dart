import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/presentations/bloc/popular_movie_bloc/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovies mockGetPopularMovie;

  setUp(() {
    mockGetPopularMovie = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockGetPopularMovie);
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
    popularity: 1,
    video: false,
  );

  final tMovieList = <Movie>[tMovie];

  test('Initial state should be TopRatedMovieEmpty', () {
    expect(popularMovieBloc.state, PopularMovieEmpty());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfuly',
    build: () {
      when(mockGetPopularMovie.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovie()),
    expect: () =>
        [PopularMovieLoading(), PopularMovieHasData(result: tMovieList)],
  );
  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, Empty] when data is gotten successfuly but empty',
    build: () {
      when(mockGetPopularMovie.execute())
          .thenAnswer((_) async => const Right([]));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovie()),
    expect: () => [PopularMovieLoading(), PopularMovieEmpty()],
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, Error] when data is gotten successfuly',
    build: () {
      when(mockGetPopularMovie.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Error')));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovie()),
    expect: () => [PopularMovieLoading(), PopularMovieError()],
  );
}
