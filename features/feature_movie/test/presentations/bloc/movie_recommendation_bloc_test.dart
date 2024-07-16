import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/presentations/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late MovieRecommendationBloc movieRecommendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendation;

  setUp(() {
    mockGetMovieRecommendation = MockGetMovieRecommendations();
    movieRecommendationBloc =
        MovieRecommendationBloc(mockGetMovieRecommendation);
  });

  const int tId = 1;

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

  test('Initial state should be MovieRecommendationEmpty', () {
    expect(movieRecommendationBloc.state, MovieRecommendationEmpty());
  });

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, Loaded] when data is gotten successfuly',
    build: () {
      when(mockGetMovieRecommendation.execute(tId))
          .thenAnswer((_) async => Right(tMovieList));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieRecommendation(id: tId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationHasData(result: tMovieList)
    ],
  );
  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, Empty] when data is gotten successfuly but empty',
    build: () {
      when(mockGetMovieRecommendation.execute(tId))
          .thenAnswer((_) async => const Right([]));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieRecommendation(id: tId)),
    expect: () => [MovieRecommendationLoading(), MovieRecommendationEmpty()],
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, Error] when data is gotten successfuly',
    build: () {
      when(mockGetMovieRecommendation.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Error')));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieRecommendation(id: tId)),
    expect: () => [MovieRecommendationLoading(), MovieRecommendationError()],
  );
}
