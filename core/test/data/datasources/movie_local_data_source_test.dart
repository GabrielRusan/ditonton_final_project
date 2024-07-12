import 'package:core/core.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  const testMovieCache = MovieTable(
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    title: 'Spider-Man',
  );

  final testMovieCacheMap = {
    'id': 557,
    'overview':
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    'title': 'Spider-Man',
  };

  group('Test Tv', () {
    group('save watchlist tv', () {
      test('should return success message when insert to database is success',
          () async {
        // arrange
        when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
            .thenAnswer((_) async => 1);
        // act
        final result = await dataSource.insertWatchlistTv(testTvTable);
        // assert
        verify(mockDatabaseHelper.insertWatchlistTv(testTvTable));
        expect(result, 'Added to Watchlist');
      });

      test('should throw DatabaseException when insert to database is failed',
          () async {
        // arrange
        when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
            .thenThrow(Exception());
        // act
        final call = dataSource.insertWatchlistTv(testTvTable);
        // assert
        verify(mockDatabaseHelper.insertWatchlistTv(testTvTable));
        expect(() => call, throwsA(isA<DatabaseException>()));
      });
    });

    group('remove watchlist tv', () {
      test(
          'should return success message when remove tv watchlist from database is success',
          () async {
        // arrange
        when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
            .thenAnswer((_) async => 1);
        // act
        final result = await dataSource.removeWatchlistTv(testTvTable);
        // assert
        verify(mockDatabaseHelper.removeWatchlistTv(testTvTable));
        expect(result, 'Removed from Watchlist');
      });

      test(
          'should throw DatabaseException when remove tv watchlist from database is failed',
          () async {
        // arrange
        when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
            .thenThrow(Exception());
        // act
        final call = dataSource.removeWatchlistTv(testTvTable);
        // assert
        verify(mockDatabaseHelper.removeWatchlistTv(testTvTable));
        expect(() => call, throwsA(isA<DatabaseException>()));
      });
    });
    group('get tv table by id', () {
      test('should return tv table when fetch from database is success',
          () async {
        // arrange
        when(mockDatabaseHelper.getTvById(1))
            .thenAnswer((_) async => testTvMap);
        // act
        final result = await dataSource.getTvById(1);
        // assert
        verify(mockDatabaseHelper.getTvById(1));
        expect(result, testTvTable);
      });

      test('should return null when no data matched from database', () async {
        // arrange
        when(mockDatabaseHelper.getTvById(1)).thenAnswer((_) async => null);
        // act
        final call = await dataSource.getTvById(1);
        // assert
        verify(mockDatabaseHelper.getTvById(1));
        expect(call, null);
      });
    });
    group('get watchlist tv', () {
      test(
          'should return success message when fetch tv watchlist from database is success',
          () async {
        // arrange
        when(mockDatabaseHelper.getWatchlistTvs())
            .thenAnswer((_) async => [testTvMap]);
        // act
        final result = await dataSource.getWatchlistTvs();
        // assert
        verify(mockDatabaseHelper.getWatchlistTvs());
        expect(result, [testTvTable]);
      });

      test(
          'should throw DatabaseException when remove tv watchlist from database is failed',
          () async {
        // arrange
        when(mockDatabaseHelper.getWatchlistTvs()).thenThrow(Exception());
        // act
        final call = dataSource.getWatchlistTvs();
        // assert
        verify(mockDatabaseHelper.getWatchlistTvs());
        expect(() => call, throwsA(isA<DatabaseException>()));
      });
    });
  });

  group('Test Movies', () {
    group('cache now playing movies', () {
      test('should call database helper to save data', () async {
        // arrange
        when(mockDatabaseHelper.clearCache('now playing'))
            .thenAnswer((_) async => 1);
        // act
        await dataSource.cacheNowPlayingMovies([testMovieCache]);
        // assert
        verify(mockDatabaseHelper.clearCache('now playing'));
        verify(mockDatabaseHelper
            .insertCacheTransaction([testMovieCache], 'now playing'));
      });

      test('should return list of movies from db when data exist', () async {
        // arrange
        when(mockDatabaseHelper.getCacheMovies('now playing'))
            .thenAnswer((_) async => [testMovieCacheMap]);
        // act
        final result = await dataSource.getCachedNowPlayingMovies();
        // assert
        expect(result, [testMovieCache]);
      });

      test('should throw CacheException when cache data is not exist',
          () async {
        // arrange
        when(mockDatabaseHelper.getCacheMovies('now playing'))
            .thenAnswer((_) async => []);
        // act
        final call = dataSource.getCachedNowPlayingMovies();
        // assert
        expect(() => call, throwsA(isA<CacheException>()));
      });
    });
    group('save watchlist', () {
      test('should return success message when insert to database is success',
          () async {
        // arrange
        when(mockDatabaseHelper.insertWatchlist(testMovieTable))
            .thenAnswer((_) async => 1);
        // act
        final result = await dataSource.insertWatchlist(testMovieTable);
        // assert
        expect(result, 'Added to Watchlist');
      });

      test('should throw DatabaseException when insert to database is failed',
          () async {
        // arrange
        when(mockDatabaseHelper.insertWatchlist(testMovieTable))
            .thenThrow(Exception());
        // act
        final call = dataSource.insertWatchlist(testMovieTable);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      });
    });

    group('remove watchlist', () {
      test('should return success message when remove from database is success',
          () async {
        // arrange
        when(mockDatabaseHelper.removeWatchlist(testMovieTable))
            .thenAnswer((_) async => 1);
        // act
        final result = await dataSource.removeWatchlist(testMovieTable);
        // assert
        expect(result, 'Removed from Watchlist');
      });

      test('should throw DatabaseException when remove from database is failed',
          () async {
        // arrange
        when(mockDatabaseHelper.removeWatchlist(testMovieTable))
            .thenThrow(Exception());
        // act
        final call = dataSource.removeWatchlist(testMovieTable);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      });
    });

    group('Get Movie Detail By Id', () {
      const tId = 1;

      test('should return Movie Detail Table when data is found', () async {
        // arrange
        when(mockDatabaseHelper.getMovieById(tId))
            .thenAnswer((_) async => testMovieMap);
        // act
        final result = await dataSource.getMovieById(tId);
        // assert
        expect(result, testMovieTable);
      });

      test('should return null when data is not found', () async {
        // arrange
        when(mockDatabaseHelper.getMovieById(tId))
            .thenAnswer((_) async => null);
        // act
        final result = await dataSource.getMovieById(tId);
        // assert
        expect(result, null);
      });
    });

    group('get watchlist movies', () {
      test('should return list of MovieTable from database', () async {
        // arrange
        when(mockDatabaseHelper.getWatchlistMovies())
            .thenAnswer((_) async => [testMovieMap]);
        // act
        final result = await dataSource.getWatchlistMovies();
        // assert
        expect(result, [testMovieTable]);
      });
    });
  });
}
