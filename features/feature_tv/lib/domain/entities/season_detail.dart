import 'package:feature_tv/domain/entities/episode.dart';
import 'package:equatable/equatable.dart';

class SeasonDetail extends Equatable {
  final String? id;
  final String? airDate;
  final List<Episode>? episodes;
  final String? name;
  final String? overview;
  final int? seasonDetailModelId;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  const SeasonDetail({
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
