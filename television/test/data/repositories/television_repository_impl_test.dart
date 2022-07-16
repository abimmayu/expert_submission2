import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:television/television.dart';

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.mocks.dart';

void main() {
  late TelevisionRepositoryImpl tvRepository;
  late MockTelevisionRemoteDataSource mockTvRemoteDataSource;
  late MockTelevisionLocalDataSource mockTvLocalDataSource;

  setUp(() {
    mockTvRemoteDataSource = MockTelevisionRemoteDataSource();
    mockTvLocalDataSource = MockTelevisionLocalDataSource();
    tvRepository = TelevisionRepositoryImpl(
      remoteDataSource: mockTvRemoteDataSource,
      localDataSource: mockTvLocalDataSource,
    );
  });

  // ignore: prefer_const_constructors
  final modelTvTest = TvModel(
    backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
    genreIds: const [10765, 10759, 18],
    id: 1399,
    originalName: 'Game of Thrones',
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 29.780826,
    posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
    firstAirDate: '2011-04-17',
    name: 'Game of Thrones',
    voteAverage: 7.91,
    voteCount: 1172,
  );

  final tvTest = Tv(
    backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
    genreIds: const [10765, 10759, 18],
    id: 1399,
    originalName: 'Game of Thrones',
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 29.780826,
    posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
    firstAirDate: '2011-04-17',
    name: 'Game of Thrones',
    voteAverage: 7.91,
    voteCount: 1172,
  );

  final tvModelListTest = <TvModel>[modelTvTest];
  final tvListTest = <Tv>[tvTest];

  group('Now Playing TV series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingTv())
          .thenAnswer((_) async => tvModelListTest);
      // act
      final result = await tvRepository.getNowPlayingTv();
      // assert
      verify(mockTvRemoteDataSource.getNowPlayingTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvListTest);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingTv())
          .thenThrow(ServerException());
      // act
      final result = await tvRepository.getNowPlayingTv();
      // assert
      verify(mockTvRemoteDataSource.getNowPlayingTv());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getNowPlayingTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepository.getNowPlayingTv();
      // assert
      verify(mockTvRemoteDataSource.getNowPlayingTv());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TV series', () {
    test('should return TV series list when call to data source is success',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tvModelListTest);
      // act
      final result = await tvRepository.getPopularTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvListTest);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv()).thenThrow(ServerException());
      // act
      final result = await tvRepository.getPopularTv();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepository.getPopularTv();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TV series', () {
    test('should return TV series list when call to data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => tvModelListTest);
      // act
      final result = await tvRepository.getTopRatedTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvListTest);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
      // act
      final result = await tvRepository.getTopRatedTv();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepository.getTopRatedTv();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TV series detail', () {
    const idTest = 5;
    // ignore: prefer_const_constructors
    final tvResponseTest = TvDetailResponse(
      backdropPath: 'backdropPath',
      genres: const [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      originalLanguage: 'en',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      status: 'Status',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      tagline: 'Tagline',
      name: 'name',
      type: 'type',
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return TV series detail data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(idTest))
          .thenAnswer((_) async => tvResponseTest);
      // act
      final result = await tvRepository.getTvDetail(idTest);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(idTest));
      expect(result, equals(const Right(tvDetailTest)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(idTest))
          .thenThrow(ServerException());
      // act
      final result = await tvRepository.getTvDetail(idTest);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(idTest));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(idTest))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepository.getTvDetail(idTest);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(idTest));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV series Recommendations', () {
    final tvListTest = <TvModel>[];
    const idTest = 1;

    test('should return TV series list data when the call is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(idTest))
          .thenAnswer((_) async => tvListTest);
      // act
      final result = await tvRepository.getTvRecommendations(idTest);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(idTest));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tvListTest));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(idTest))
          .thenThrow(ServerException());
      // act
      final result = await tvRepository.getTvRecommendations(idTest);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(idTest));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(idTest))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepository.getTvRecommendations(idTest);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(idTest));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search TV series data', () {
    const queryTest = 'spy x family';

    test('should return TV series list when call to data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(queryTest))
          .thenAnswer((_) async => tvModelListTest);
      // act
      final result = await tvRepository.searchTv(queryTest);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvListTest);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(queryTest))
          .thenThrow(ServerException());
      // act
      final result = await tvRepository.searchTv(queryTest);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTv(queryTest))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await tvRepository.searchTv(queryTest);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist TV series', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTvLocalDataSource.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await tvRepository.saveWatchlistTv(tvDetailTest);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return Database Failure when saving unsuccessful', () async {
      // arrange
      when(mockTvLocalDataSource.insertWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await tvRepository.saveWatchlistTv(tvDetailTest);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist TV series', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTvLocalDataSource.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await tvRepository.removeWatchlistTv(tvDetailTest);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return Database Failure when remove unsuccessful', () async {
      // arrange
      when(mockTvLocalDataSource.removeWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await tvRepository.removeWatchlistTv(tvDetailTest);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist TV series status', () {
    test('should return TV series watch status whether data is found',
        () async {
      // arrange
      const idTest = 3;
      when(mockTvLocalDataSource.getTvById(idTest))
          .thenAnswer((_) async => null);
      // act
      final result = await tvRepository.isAddedToWatchlistTv(idTest);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist TV series', () {
    test('should return list of TV series', () async {
      // arrange
      when(mockTvLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await tvRepository.getWatchlistTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [tvWatchlistTest]);
    });
  });
}
