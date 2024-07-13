import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:feature_tv/data/models/tv_model.dart';
import 'package:feature_tv/data/repositories/tv_repository_impl.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

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
}
