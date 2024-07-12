import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/data/models/movie_model.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/tv_model.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
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

  final tMovie = Movie(
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

  const tTvModel = TvModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    name: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    voteAverage: 7.2,
    voteCount: 13507,
    originCountry: ["US"],
    originalLanguage: 'EN',
  );

  final tTv = Tv(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    name: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    voteAverage: 7.2,
    voteCount: 13507,
    originCountry: const ["US"],
    originalLanguage: 'EN',
  );

  const testMovieCache = MovieTable(
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    title: 'Spider-Man',
  );

  final testMovieFromCache = testMovieCache.toEntity();

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('Test Tv', () {
    group('Airing Today Tv', () {
      test(
          "Should return list of Tv when the call to remote data is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.getAiringTodayTV())
            .thenAnswer((_) async => [tTvModel]);
        // act
        final result = await repository.getAiringTodayTv();
        // assert
        verify(mockRemoteDataSource.getAiringTodayTV());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [tTv]);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAiringTodayTV())
            .thenThrow(ServerException());
        // act
        final result = await repository.getAiringTodayTv();
        // assert
        verify(mockRemoteDataSource.getAiringTodayTV());
        expect(result, equals(const Left(ServerFailure(''))));
      });

      test(
          'should return Connection Failure when device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getAiringTodayTV())
            .thenThrow(const SocketException(''));
        // act
        final result = await repository.getAiringTodayTv();
        // assert
        verify(mockRemoteDataSource.getAiringTodayTV());
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      });
    });

    group('get Popular Tvs', () {
      test(
          "Should return list of Tv when the call to remote data is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTv())
            .thenAnswer((_) async => [tTvModel]);
        // act
        final result = await repository.getPopularTv();
        // assert
        verify(mockRemoteDataSource.getPopularTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [tTv]);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTv()).thenThrow(ServerException());
        // act
        final result = await repository.getPopularTv();
        // assert
        verify(mockRemoteDataSource.getPopularTv());
        expect(result, equals(const Left(ServerFailure(''))));
      });

      test(
          'should return Connection Failure when device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularTv())
            .thenThrow(const SocketException(''));
        // act
        final result = await repository.getPopularTv();
        // assert
        verify(mockRemoteDataSource.getPopularTv());
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      });
    });

    group('get Top Rated Tvs', () {
      test(
          "Should return list of Tv when the call to remote data is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTv())
            .thenAnswer((_) async => [tTvModel]);
        // act
        final result = await repository.getTopRatedTv();
        // assert
        verify(mockRemoteDataSource.getTopRatedTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [tTv]);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedTv();
        // assert
        verify(mockRemoteDataSource.getTopRatedTv());
        expect(result, equals(const Left(ServerFailure(''))));
      });

      test(
          'should return Connection Failure when device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTv())
            .thenThrow(const SocketException(''));
        // act
        final result = await repository.getTopRatedTv();
        // assert
        verify(mockRemoteDataSource.getTopRatedTv());
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      });
    });
    group('get Tv Detail', () {
      test("Should return Tv data when the call to remote data is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.getTvDetail(1))
            .thenAnswer((_) async => tTvDetailResponse);
        // act
        final result = await repository.getTvDetail(1);
        // assert
        verify(mockRemoteDataSource.getTvDetail(1));
        expect(result, equals(Right(tTvDetail)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvDetail(1)).thenThrow(ServerException());
        // act
        final result = await repository.getTvDetail(1);
        // assert
        verify(mockRemoteDataSource.getTvDetail(1));
        expect(result, equals(const Left(ServerFailure(''))));
      });

      test(
          'should return Connection Failure when device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvDetail(1))
            .thenThrow(const SocketException(''));
        // act
        final result = await repository.getTvDetail(1);
        // assert
        verify(mockRemoteDataSource.getTvDetail(1));
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      });
    });

    group('get Tvs Recommendation', () {
      test(
          "Should return list of Tv when the call to remote data is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.getTvRecommendations(1))
            .thenAnswer((_) async => [tTvModel]);
        // act
        final result = await repository.getTvRecommendations(1);
        // assert
        verify(mockRemoteDataSource.getTvRecommendations(1));
        final resultList = result.getOrElse(() => []);
        expect(resultList, [tTv]);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvRecommendations(1))
            .thenThrow(ServerException());
        // act
        final result = await repository.getTvRecommendations(1);
        // assert
        verify(mockRemoteDataSource.getTvRecommendations(1));
        expect(result, equals(const Left(ServerFailure(''))));
      });

      test(
          'should return Connection Failure when device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getTvRecommendations(1))
            .thenThrow(const SocketException(''));
        // act
        final result = await repository.getTvRecommendations(1);
        // assert
        verify(mockRemoteDataSource.getTvRecommendations(1));
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      });
    });

    group('search tv', () {
      test(
          "Should return list of Tv when the call to remote data is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.searchTvs('The Boys'))
            .thenAnswer((_) async => [tTvModel]);
        // act
        final result = await repository.searchTvs('The Boys');
        // assert
        verify(mockRemoteDataSource.searchTvs('The Boys'));
        final resultList = result.getOrElse(() => []);
        expect(resultList, [tTv]);
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.searchTvs('The Boys'))
            .thenThrow(ServerException());
        // act
        final result = await repository.searchTvs('The Boys');
        // assert
        verify(mockRemoteDataSource.searchTvs('The Boys'));
        expect(result, equals(const Left(ServerFailure(''))));
      });

      test(
          'should return Connection Failure when device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.searchTvs('The Boys'))
            .thenThrow(const SocketException(''));
        // act
        final result = await repository.searchTvs('The Boys');
        // assert
        verify(mockRemoteDataSource.searchTvs('The Boys'));
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      });
    });

    group('is added to watchlist tv', () {
      test("Should return true when there is matched data in database",
          () async {
        // arrange
        when(mockLocalDataSource.getTvById(1))
            .thenAnswer((_) async => testTvTable);
        // act
        final result = await repository.isAddedToWatchlistTv(1);
        // assert
        verify(mockLocalDataSource.getTvById(1));
        expect(result, true);
      });

      test("Should return false when there is no matched data in database",
          () async {
        // arrange
        when(mockLocalDataSource.getTvById(1)).thenAnswer((_) async => null);
        // act
        final result = await repository.isAddedToWatchlistTv(1);
        // assert
        verify(mockLocalDataSource.getTvById(1));
        expect(result, false);
      });
    });

    group('insert watch list tv', () {
      test(
          "Should return 'Added to Watchlist' when succesful insert tv data to database",
          () async {
        // arrange
        when(mockLocalDataSource.insertWatchlistTv(testTvTable))
            .thenAnswer((_) async => 'Added to Watchlist');
        // act
        final result = await repository.saveWatchlistTv(tTvDetail);
        // assert
        verify(mockLocalDataSource.insertWatchlistTv(testTvTable));
        expect(result, equals(const Right("Added to Watchlist")));
      });

      test(
          'should return database failure when the call to local data source is unsuccessful',
          () async {
        // arrange
        when(mockLocalDataSource.insertWatchlistTv(testTvTable))
            .thenThrow(DatabaseException('Failed to add watchlist'));
        // act
        final result = await repository.saveWatchlistTv(tTvDetail);
        // assert
        verify(mockLocalDataSource.insertWatchlistTv(testTvTable));
        expect(result,
            equals(const Left(DatabaseFailure('Failed to add watchlist'))));
      });
    });

    group('remove watch list tv', () {
      test(
          "Should return 'Removed from Watchlist' when succesful insert tv data to database",
          () async {
        // arrange
        when(mockLocalDataSource.removeWatchlistTv(testTvTable))
            .thenAnswer((_) async => 'Removed from Watchlist');
        // act
        final result = await repository.removeWatchlistTv(tTvDetail);
        // assert
        verify(mockLocalDataSource.removeWatchlistTv(testTvTable));
        expect(result, equals(const Right("Removed from Watchlist")));
      });

      test(
          'should return database failure when the call to local data source is unsuccessful',
          () async {
        // arrange
        when(mockLocalDataSource.removeWatchlistTv(testTvTable))
            .thenThrow(DatabaseException('Failed to remove watchlist'));
        // act
        final result = await repository.removeWatchlistTv(tTvDetail);
        // assert
        verify(mockLocalDataSource.removeWatchlistTv(testTvTable));
        expect(result,
            equals(const Left(DatabaseFailure('Failed to remove watchlist'))));
      });
    });

    group('get watch list tv', () {
      test("Should return list of tv when succesful call data from database",
          () async {
        // arrange
        when(mockLocalDataSource.getWatchlistTvs())
            .thenAnswer((_) async => [testTvTable]);
        // act
        final result = await repository.getWatchlistTvs();
        // assert
        verify(mockLocalDataSource.getWatchlistTvs());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testWatchlistTv]);
      });

      test(
          'should return database failure when the call to local data source is unsuccessful',
          () async {
        // arrange
        when(mockLocalDataSource.getWatchlistTvs())
            .thenThrow(DatabaseException('Failed to get watchlist tv'));
        // act
        final result = await repository.getWatchlistTvs();
        // assert
        verify(mockLocalDataSource.getWatchlistTvs());
        expect(result,
            equals(const Left(DatabaseFailure('Failed to get watchlist tv'))));
      });
    });

    group('get Season Detail', () {
      test(
          "Should return season detail data when the call to remote data is successful",
          () async {
        // arrange
        when(mockRemoteDataSource.getSeasonDetail(1, 1))
            .thenAnswer((_) async => tSeasonDetailModel);
        // act
        final result = await repository.getSeasonDetail(1, 1);
        // assert
        verify(mockRemoteDataSource.getSeasonDetail(1, 1));
        expect(result, equals(Right(tSeasonDetail)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getSeasonDetail(1, 1))
            .thenThrow(ServerException());
        // act
        final result = await repository.getSeasonDetail(1, 1);
        // assert
        verify(mockRemoteDataSource.getSeasonDetail(1, 1));
        expect(result, equals(const Left(ServerFailure(''))));
      });

      test(
          'should return Connection Failure when device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getSeasonDetail(1, 1))
            .thenThrow(const SocketException(''));
        // act
        final result = await repository.getSeasonDetail(1, 1);
        // assert
        verify(mockRemoteDataSource.getSeasonDetail(1, 1));
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      });
    });
  });

  group('Test Movies', () {
    group('Now Playing Movies', () {
      test('should check if the device is online', () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenAnswer((_) async => []);
        // act
        await repository.getNowPlayingMovies();
        // assert
        verify(mockNetworkInfo.isConnected);
      });
      group('When device is online', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });

        test(
            'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingMovies())
              .thenAnswer((_) async => tMovieModelList);
          // act
          final result = await repository.getNowPlayingMovies();
          // assert
          verify(mockRemoteDataSource.getNowPlayingMovies());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tMovieList);
        });

        test(
            'should cache movies data when call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingMovies())
              .thenAnswer((_) async => tMovieModelList);

          // act
          await repository.getNowPlayingMovies();
          // assert
          verify(mockRemoteDataSource.getNowPlayingMovies());
          verify(mockLocalDataSource.cacheNowPlayingMovies([testMovieCache]));
        });

        test(
            'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingMovies())
              .thenThrow(ServerException());
          // act
          final result = await repository.getNowPlayingMovies();
          // assert
          verify(mockRemoteDataSource.getNowPlayingMovies());
          expect(result, equals(const Left(ServerFailure(''))));
        });
      });

      group('When device is offline', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });

        test(
            'should return cache data when the device is not connected to internet',
            () async {
          // arrange
          when(mockLocalDataSource.getCachedNowPlayingMovies())
              .thenAnswer((_) async => [testMovieCache]);

          // act
          final result = await repository.getNowPlayingMovies();

          // assert
          verify(mockLocalDataSource.getCachedNowPlayingMovies());
          final resultList = result.getOrElse(() => []);
          expect(resultList, [testMovieFromCache]);
        });

        test('should return CacheFailure when app has no cache', () async {
          // arrange
          when(mockLocalDataSource.getCachedNowPlayingMovies())
              .thenThrow(CacheException('No Cache'));
          // act
          final result = await repository.getNowPlayingMovies();
          // assert
          verify(mockLocalDataSource.getCachedNowPlayingMovies());
          expect(result, const Left(CacheFailure('No Cache')));
        });
      });
    });

    group('Popular Movies', () {
      test('should return movie list when call to data source is success',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenAnswer((_) async => tMovieModelList);
        // act
        final result = await repository.getPopularMovies();
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tMovieList);
      });

      test(
          'should return server failure when call to data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenThrow(ServerException());
        // act
        final result = await repository.getPopularMovies();
        // assert
        expect(result, const Left(ServerFailure('')));
      });

      test(
          'should return connection failure when device is not connected to the internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies()).thenThrow(
            const SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getPopularMovies();
        // assert
        expect(result,
            const Left(ConnectionFailure('Failed to connect to the network')));
      });
    });

    group('Top Rated Movies', () {
      test('should return movie list when call to data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenAnswer((_) async => tMovieModelList);
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tMovieList);
      });

      test(
          'should return ServerFailure when call to data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenThrow(ServerException());
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        expect(result, const Left(ServerFailure('')));
      });

      test(
          'should return ConnectionFailure when device is not connected to the internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies()).thenThrow(
            const SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        expect(result,
            const Left(ConnectionFailure('Failed to connect to the network')));
      });
    });

    group('Get Movie Detail', () {
      const tId = 1;
      const tMovieResponse = MovieDetailResponse(
        adult: false,
        backdropPath: 'backdropPath',
        budget: 100,
        genres: [GenreModel(id: 1, name: 'Action')],
        homepage: "https://google.com",
        id: 1,
        imdbId: 'imdb1',
        originalLanguage: 'en',
        originalTitle: 'originalTitle',
        overview: 'overview',
        popularity: 1,
        posterPath: 'posterPath',
        releaseDate: 'releaseDate',
        revenue: 12000,
        runtime: 120,
        status: 'Status',
        tagline: 'Tagline',
        title: 'title',
        video: false,
        voteAverage: 1,
        voteCount: 1,
      );

      test(
          'should return Movie data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getMovieDetail(tId))
            .thenAnswer((_) async => tMovieResponse);
        // act
        final result = await repository.getMovieDetail(tId);
        // assert
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(result, equals(Right(testMovieDetail)));
      });

      test(
          'should return Server Failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getMovieDetail(tId))
            .thenThrow(ServerException());
        // act
        final result = await repository.getMovieDetail(tId);
        // assert
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(result, equals(const Left(ServerFailure(''))));
      });

      test(
          'should return connection failure when the device is not connected to internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getMovieDetail(tId)).thenThrow(
            const SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getMovieDetail(tId);
        // assert
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      });
    });

    group('Get Movie Recommendations', () {
      final tMovieList = <MovieModel>[];
      const tId = 1;

      test('should return data (movie list) when the call is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getMovieRecommendations(tId))
            .thenAnswer((_) async => tMovieList);
        // act
        final result = await repository.getMovieRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getMovieRecommendations(tId));
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tMovieList));
      });

      test(
          'should return server failure when call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getMovieRecommendations(tId))
            .thenThrow(ServerException());
        // act
        final result = await repository.getMovieRecommendations(tId);
        // assertbuild runner
        verify(mockRemoteDataSource.getMovieRecommendations(tId));
        expect(result, equals(const Left(ServerFailure(''))));
      });

      test(
          'should return connection failure when the device is not connected to the internet',
          () async {
        // arrange
        when(mockRemoteDataSource.getMovieRecommendations(tId)).thenThrow(
            const SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getMovieRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getMovieRecommendations(tId));
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      });
    });

    group('Seach Movies', () {
      const tQuery = 'spiderman';

      test('should return movie list when call to data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.searchMovies(tQuery))
            .thenAnswer((_) async => tMovieModelList);
        // act
        final result = await repository.searchMovies(tQuery);
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tMovieList);
      });

      test(
          'should return ServerFailure when call to data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.searchMovies(tQuery))
            .thenThrow(ServerException());
        // act
        final result = await repository.searchMovies(tQuery);
        // assert
        expect(result, const Left(ServerFailure('')));
      });

      test(
          'should return ConnectionFailure when device is not connected to the internet',
          () async {
        // arrange
        when(mockRemoteDataSource.searchMovies(tQuery)).thenThrow(
            const SocketException('Failed to connect to the network'));
        // act
        final result = await repository.searchMovies(tQuery);
        // assert
        expect(result,
            const Left(ConnectionFailure('Failed to connect to the network')));
      });
    });

    group('save watchlist', () {
      test('should return success message when saving successful', () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(testMovieTable))
            .thenAnswer((_) async => 'Added to Watchlist');
        // act
        final result = await repository.saveWatchlist(testMovieDetail);
        // assert
        expect(result, const Right('Added to Watchlist'));
      });

      test('should return DatabaseFailure when saving unsuccessful', () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(testMovieTable))
            .thenThrow(DatabaseException('Failed to add watchlist'));
        // act
        final result = await repository.saveWatchlist(testMovieDetail);
        // assert
        expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
      });
    });

    group('remove watchlist', () {
      test('should return success message when remove successful', () async {
        // arrange
        when(mockLocalDataSource.removeWatchlist(testMovieTable))
            .thenAnswer((_) async => 'Removed from watchlist');
        // act
        final result = await repository.removeWatchlist(testMovieDetail);
        // assert
        expect(result, const Right('Removed from watchlist'));
      });

      test('should return DatabaseFailure when remove unsuccessful', () async {
        // arrange
        when(mockLocalDataSource.removeWatchlist(testMovieTable))
            .thenThrow(DatabaseException('Failed to remove watchlist'));
        // act
        final result = await repository.removeWatchlist(testMovieDetail);
        // assert
        expect(
            result, const Left(DatabaseFailure('Failed to remove watchlist')));
      });
    });

    group('get watchlist status', () {
      test('should return watch status whether data is found', () async {
        // arrange
        const tId = 1;
        when(mockLocalDataSource.getMovieById(tId))
            .thenAnswer((_) async => null);
        // act
        final result = await repository.isAddedToWatchlist(tId);
        // assert
        expect(result, false);
      });
    });

    group('get watchlist movies', () {
      test('should return list of Movies', () async {
        // arrange
        when(mockLocalDataSource.getWatchlistMovies())
            .thenAnswer((_) async => [testMovieTable]);
        // act
        final result = await repository.getWatchlistMovies();
        // assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testWatchlistMovie]);
      });
    });
  });
}
