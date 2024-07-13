// To parse this JSON data, do
//
//     final seasonDetailModel = seasonDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:feature_tv/domain/entities/season_detail.dart';

import '../../domain/entities/episode.dart';

SeasonDetailModel seasonDetailModelFromJson(String str) =>
    SeasonDetailModel.fromJson(json.decode(str));

String seasonDetailModelToJson(SeasonDetailModel data) =>
    json.encode(data.toJson());

class SeasonDetailModel extends Equatable {
  final String? id;
  final String? airDate;
  final List<EpisodeModel>? episodes;
  final String? name;
  final String? overview;
  final int? seasonDetailModelId;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  const SeasonDetailModel({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonDetailModelId,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  SeasonDetail toEntity() => SeasonDetail(
      id: id,
      airDate: airDate,
      episodes: episodes?.map((episode) => episode.toEntity()).toList(),
      name: name,
      overview: overview,
      seasonDetailModelId: seasonDetailModelId,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
      voteAverage: voteAverage);

  factory SeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      SeasonDetailModel(
        id: json["_id"],
        airDate: json["air_date"],
        episodes: json["episodes"] == null
            ? []
            : List<EpisodeModel>.from(
                json["episodes"]!.map((x) => EpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        seasonDetailModelId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date": airDate,
        "episodes": episodes == null
            ? []
            : List<dynamic>.from(episodes!.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": seasonDetailModelId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        seasonDetailModelId,
        posterPath,
        seasonNumber,
        voteAverage,
      ];
}

class EpisodeModel extends Equatable {
  final String? airDate;
  final int? episodeNumber;
  final String? episodeType;
  final int? id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;
  final double? voteAverage;
  final int? voteCount;

  const EpisodeModel({
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  Episode toEntity() => Episode(
      airDate: airDate,
      episodeNumber: episodeNumber,
      episodeType: episodeType,
      id: id,
      name: name,
      overview: overview,
      productionCode: productionCode,
      runtime: runtime,
      seasonNumber: seasonNumber,
      showId: showId,
      stillPath: stillPath,
      voteAverage: voteAverage,
      voteCount: voteCount);

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        episodeType: json["episode_type"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        showId: json["show_id"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_number": episodeNumber,
        "episode_type": episodeType,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "show_id": showId,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        episodeType,
        id,
        name,
        overview,
        productionCode,
        runtime,
        seasonNumber,
        showId,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
