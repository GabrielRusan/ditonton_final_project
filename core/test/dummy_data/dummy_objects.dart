import 'package:core/data/models/episode.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/season_detail_model.dart';
import 'package:core/data/models/season_model.dart';
import 'package:core/data/models/tv_detail_model.dart';
import 'package:core/data/models/tv_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/season_detail.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

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

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

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
