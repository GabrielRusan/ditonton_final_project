import 'package:core/common_entities/genre.dart';
import 'package:feature_tv/data/models/genre_model.dart';
import 'package:feature_tv/data/models/season_detail_model.dart';
import 'package:feature_tv/data/models/season_model.dart';
import 'package:feature_tv/data/models/tv_detail_model.dart';
import 'package:feature_tv/data/models/tv_table.dart';
import 'package:feature_tv/domain/entities/episode.dart';
import 'package:feature_tv/domain/entities/season.dart';
import 'package:feature_tv/domain/entities/season_detail.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/domain/entities/tv_detail.dart';

final testTv = Tv(
  adult: false,
  backdropPath: 'backdropPath',
  genreIds: const [1],
  id: 1,
  originCountry: const ['US'],
  originalLanguage: 'En',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
);

final testTvList = [testTv];

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

const testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'posterPath': 'posterPath',
  'overview': 'overview',
  'name': 'name',
};

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final tTvDetailResponse = TvDetailResponse(
  adult: false,
  backdropPath: 'backdropPath',
  episodeRunTime: const [1],
  firstAirDate: DateTime(2024, 1, 1),
  genres: const [GenreModel(id: 1, name: 'Scifi')],
  homepage: 'homepage',
  id: 1,
  inProduction: true,
  languages: const ['En'],
  lastAirDate: DateTime(2024, 1, 1),
  name: 'name',
  nextEpisodeToAir: 1,
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: const ['US'],
  originalLanguage: 'En',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  seasons: const [
    SeasonModel(
        airDate: "2024-01-01",
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
        voteAverage: 1)
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1,
  voteCount: 1,
);

final tTvDetail = TvDetail(
  adult: false,
  backdropPath: 'backdropPath',
  episodeRunTime: const [1],
  firstAirDate: DateTime(2024, 1, 1),
  genres: const [Genre(id: 1, name: 'Scifi')],
  homepage: 'homepage',
  id: 1,
  inProduction: true,
  languages: const ['En'],
  lastAirDate: DateTime(2024, 1, 1),
  name: 'name',
  nextEpisodeToAir: 1,
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: const ['US'],
  originalLanguage: 'En',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  seasons: const [
    Season(
        airDate: "2024-01-01",
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
        voteAverage: 1)
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1,
  voteCount: 1,
);

const tSeasonDetail = SeasonDetail(
    id: '1',
    airDate: '2024-01-01',
    episodes: [
      Episode(
          airDate: '2024-01-01',
          episodeNumber: 1,
          episodeType: 'episodeType',
          id: 1,
          name: 'name',
          overview: 'overview',
          productionCode: 'productionCode',
          runtime: 1,
          seasonNumber: 1,
          showId: 1,
          stillPath: 'stillPath',
          voteAverage: 1,
          voteCount: 1)
    ],
    name: 'name',
    overview: "overview",
    seasonDetailModelId: 1,
    posterPath: "posterPath",
    seasonNumber: 1,
    voteAverage: 1);

const tSeasonDetailModel = SeasonDetailModel(
    id: '1',
    airDate: '2024-01-01',
    episodes: [
      EpisodeModel(
          airDate: '2024-01-01',
          episodeNumber: 1,
          episodeType: 'episodeType',
          id: 1,
          name: 'name',
          overview: 'overview',
          productionCode: 'productionCode',
          runtime: 1,
          seasonNumber: 1,
          showId: 1,
          stillPath: 'stillPath',
          voteAverage: 1,
          voteCount: 1)
    ],
    name: 'name',
    overview: 'overview',
    seasonDetailModelId: 1,
    posterPath: 'posterPath',
    seasonNumber: 1,
    voteAverage: 1);
