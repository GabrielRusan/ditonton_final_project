import 'dart:convert';

import 'package:feature_tv/data/models/tv_model.dart';
import 'package:feature_tv/data/models/tv_response.dart';
import 'package:core/utils/json_reader.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testTvModel = TvModel(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1],
      id: 1,
      originCountry: ['En'],
      originalLanguage: 'originalLanguage',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      name: 'name',
      voteAverage: 1,
      voteCount: 1);

  const testTvResponseModel = TvResponse(tvList: <TvModel>[testTvModel]);

  group('fromJson', () {
    test('Should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_json.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, testTvResponseModel);
    });
  });

  group('to json', () {
    test('Should return a JSON map containing proper data', () {
      // arrange
      final expectedJsonMap = {
        "results": [
          {
            "adult": false,
            "backdrop_path": "backdropPath",
            "first_air_date": "firstAirDate",
            "genre_ids": [1],
            "id": 1,
            "name": "name",
            "origin_country": ["En"],
            "overview": "overview",
            "popularity": 1,
            "poster_path": "posterPath",
            "vote_average": 1,
            "vote_count": 1
          }
        ],
      };
      // act
      final result = testTvResponseModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });
}
