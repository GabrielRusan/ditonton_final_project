import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/presentations/bloc/top_rated_movie_bloc/top_rated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
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
    expect(topRatedMovieBloc.state, TopRatedMovieEmpty());
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, Loaded] when data is gotten successfuly',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovieEvent()),
    expect: () =>
        [TopRatedMovieLoading(), TopRatedMovieHasData(result: tMovieList)],
  );
  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, Empty] when data is gotten successfuly but empty',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovieEvent()),
    expect: () => [TopRatedMovieLoading(), TopRatedMovieEmpty()],
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, Error] when data is gotten successfuly',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Error')));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovieEvent()),
    expect: () => [TopRatedMovieLoading(), TopRatedMovieError()],
  );
}
