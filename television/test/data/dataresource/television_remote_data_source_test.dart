import 'dart:convert';

import 'package:core/common/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:television/data/datasources/television_remote_data_source.dart';
import 'package:television/data/models/television_model_detail.dart';
import 'package:television/data/models/television_response.dart';

import '../../helpers/test_television_helpers.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSourcetv;

  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();

    dataSourcetv = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On Air Tv', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_object/on_the_air_tv.json')))
        .tvList;

    test('Return list of Tv Model if the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_object/on_the_air_tv.json'), 200));

      // act
      final result = await dataSourcetv.getNowPlayingTv();

      // assert
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // act
      final call = dataSourcetv.getNowPlayingTv();

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get on Popular TV', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_object/popular_tv.json')))
        .tvList;

    test('Return if list of tv when response is success (200)', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_object/popular_tv.json'), 200));

      // act
      final result = await dataSourcetv.getPopularTv();

      // assert
      expect(result, tTvList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // act
      final call = dataSourcetv.getPopularTv();

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get the Top Rated Tv', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_object/top_rated_tv.json')))
        .tvList;

    test('should return list of tv when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_object/top_rated_tv.json'), 200));

      // act
      final result = await dataSourcetv.getTopRatedTv();

      // assert
      expect(result, tTvList);
    });

    test('Throw if ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // act
      final call = dataSourcetv.getTopRatedTv();

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get the tv detail', () {
    const tId = 1;
    final tTvDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_object/detail_tv.json')));

    test('Return if movie detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_object/detail_tv.json'), 200));

      // act
      final result = await dataSourcetv.getTvDetail(tId);

      // assert
      expect(result, equals(tTvDetail));
    });

    test('Throw if Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // act
      final call = dataSourcetv.getTvDetail(tId);

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get the tv recommendations', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_object/recommendations_tv.json')))
        .tvList;

    const tId = 1;

    test('Return if list of Tv Model when the response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_object/recommendations_tv.json'), 200));

      // act
      final result = await dataSourcetv.getTvRecommendations(tId);

      // assert
      expect(result, equals(tTvList));
    });

    test('Throw if Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // act
      final call = dataSourcetv.getTvRecommendations(tId);

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search the tv', () {
    final tSearchResult = TvResponse.fromJson(
            json.decode(readJson('dummy_object/search_spy_x_family_tv.json')))
        .tvList;

    const tQuery = 'Spiderman';

    test('Return if list of tv when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_object/search_spy_x_family_tv.json'), 200));

      // act
      final result = await dataSourcetv.searchTv(tQuery);

      // assert
      expect(result, tSearchResult);
    });

    test('Throw if ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // act
      final call = dataSourcetv.searchTv(tQuery);

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
