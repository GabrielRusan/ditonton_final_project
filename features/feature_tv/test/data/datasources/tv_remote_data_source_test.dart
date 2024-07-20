import 'dart:convert';
import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:feature_tv/data/datasources/tv_remote_data_source.dart';
import 'package:feature_tv/data/models/season_detail_model.dart';
import 'package:feature_tv/data/models/tv_detail_model.dart';
import 'package:feature_tv/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('TV Series Test', () {
    group('get Airing Today TV', () {
      final tTvList = TvResponse.fromJson(
              json.decode(readJson('dummy_data/tv_airing_today.json')))
          .tvList;

      test('should return list of Tv Model when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient
                .get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_airing_today.json'),
                  200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8'
                  },
                ));
        // act
        final result = await dataSource.getAiringTodayTV();
        // assert
        expect(result, equals(tTvList));
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient
                .get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getAiringTodayTV();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });

    group('get Popular TV', () {
      final tTvList = TvResponse.fromJson(
              json.decode(readJson('dummy_data/tv_popular.json')))
          .tvList;

      test('should return list of Tv Model when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_popular.json'),
                  200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8'
                  },
                ));
        // act
        final result = await dataSource.getPopularTv();
        // assert
        expect(result, equals(tTvList));
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getPopularTv();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });

    group('get Top Rated TV', () {
      final tTvList = TvResponse.fromJson(
              json.decode(readJson('dummy_data/tv_top_rated.json')))
          .tvList;

      test('should return list of Tv Model when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_top_rated.json'),
                  200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8'
                  },
                ));
        // act
        final result = await dataSource.getTopRatedTv();
        // assert
        expect(result, equals(tTvList));
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTopRatedTv();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });

    group('get TV Detail', () {
      const tTvId = 1;
      final tTvDetail = TvDetailResponse.fromJson(
          json.decode(readJson('dummy_data/tv_detail.json')));

      test('should return TV Detail Model when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient
                .get(Uri.parse('$BASE_URL/tv/${tTvId.toString()}?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_detail.json'),
                  200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8'
                  },
                ));
        // act
        final result = await dataSource.getTvDetail(tTvId);
        // assert
        expect(result, equals(tTvDetail));
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient
                .get(Uri.parse('$BASE_URL/tv/${tTvId.toString()}?$API_KEY')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvDetail(tTvId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });

    group('get TV Recomendations', () {
      const tTvId = 1;
      final tTvList = TvResponse.fromJson(
              json.decode(readJson('dummy_data/tv_recommendations.json')))
          .tvList;

      test('should return List of Tv Model when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(
                '$BASE_URL/tv/${tTvId.toString()}/recommendations?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_recommendations.json'),
                  200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8'
                  },
                ));
        // act
        final result = await dataSource.getTvRecommendations(tTvId);
        // assert
        expect(result, equals(tTvList));
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(
                '$BASE_URL/tv/${tTvId.toString()}/recommendations?$API_KEY')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvRecommendations(tTvId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });

    // group('search Tvs', () {
    //   final tSearchResult = TvResponse.fromJson(
    //           json.decode(readJson('dummy_data/search_the_boys_tv.json')))
    //       .tvList;
    //   const tQuery = 'The Boys';

    //   test('should return list of movies when response code is 200', () async {
    //     // arrange
    //     when(mockHttpClient
    //             .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
    //         .thenAnswer((_) async => http.Response(
    //               readJson('dummy_data/search_the_boys_tv.json'),
    //               200,
    //               headers: {
    //                 HttpHeaders.contentTypeHeader:
    //                     'application/json; charset=utf-8'
    //               },
    //             ));
    //     // act
    //     final result = await dataSource.searchTvs(tQuery);
    //     // assert
    //     expect(result, tSearchResult);
    //   });

    //   test('should throw ServerException when response code is other than 200',
    //       () async {
    //     // arrange
    //     when(mockHttpClient.get(
    //             Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
    //         .thenAnswer((_) async => http.Response('Not Found', 404));
    //     // act
    //     final call = dataSource.searchMovies(tQuery);
    //     // assert
    //     expect(() => call, throwsA(isA<ServerException>()));
    //   });
    // });

    group('get season detail', () {
      final tSeasonModel = SeasonDetailModel.fromJson(
          json.decode(readJson('dummy_data/season_detail.json')));

      test('should return list of movies when response code is 200', () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/1/season/1?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/season_detail.json'),
                  200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8'
                  },
                ));
        // act
        final result = await dataSource.getSeasonDetail(1, 1);
        // assert
        expect(result, tSeasonModel);
      });

      test('should throw ServerException when response code is other than 200',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/1/season/1?$API_KEY')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getSeasonDetail(1, 1);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });
  });
}
