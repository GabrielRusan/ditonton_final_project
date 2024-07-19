import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_movie/domain/entities/movie_detail.dart';
import 'package:feature_movie/presentations/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_usecase_helper.mocks.dart';

void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieDetailBloc =
        MovieDetailBloc(mockGetMovieDetail, mockGetMovieRecommendations);
  });

  const int tId = 1;

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 1,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  test('Initial state should be MovieDetailLoading', () {
    expect(movieDetailBloc.state, MovieDetailLoading());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Loaded] when data is gotten successfuly',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Right(tMovieDetail));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => const Right([]));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetail(id: tId)),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailLoaded(movieDetail: tMovieDetail, recommendationList: [])
    ],
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when data is gotten unsuccessfuly',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Error')));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => const Right([]));
      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchMovieDetail(id: tId)),
    expect: () => [MovieDetailLoading(), MovieDetailError()],
  );
}
