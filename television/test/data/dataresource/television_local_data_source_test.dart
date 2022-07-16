import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:television/television.dart';

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelperTelevision mockDatabaseHelperTv;

  setUp(() {
    mockDatabaseHelperTv = MockDatabaseHelperTelevision();
    dataSource = TvLocalDataSourceImpl(databaseHelpertv: mockDatabaseHelperTv);
  });

  group('save watchlist Tv', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTv.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlistTv(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTv.insertWatchlistTv(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlistTv(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist Tv', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTv.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlistTv(testTvTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTv.removeWatchlistTv(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistTv(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Detail By Id', () {
    const tvId = 23;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTvById(tvId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTvById(tvId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTvById(tvId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvById(tvId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist Tv', () {
    test('should return list of TvTable from database', () async {
      // arrange
      when(mockDatabaseHelperTv.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTv();
      // assert
      expect(result, [testTvTable]);
    });
  });
}
