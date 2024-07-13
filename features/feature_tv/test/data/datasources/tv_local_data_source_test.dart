import 'package:core/core.dart';
import 'package:feature_tv/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

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
}
