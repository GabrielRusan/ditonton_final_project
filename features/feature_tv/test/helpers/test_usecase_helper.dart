import 'package:feature_tv/domain/usecases/get_airing_today_tv.dart';
import 'package:feature_tv/domain/usecases/get_popular_tv.dart';
import 'package:feature_tv/domain/usecases/get_season_detail.dart';
import 'package:feature_tv/domain/usecases/get_top_rated_tv.dart';
import 'package:feature_tv/domain/usecases/get_tv_detail.dart';
import 'package:feature_tv/domain/usecases/get_tv_recommendations.dart';
import 'package:feature_tv/domain/usecases/get_tv_watchlist_status.dart';
import 'package:feature_tv/domain/usecases/get_watchlist_tvs.dart';
import 'package:feature_tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:feature_tv/domain/usecases/save_watchlist_tv.dart';
import 'package:feature_tv/domain/usecases/search_tvs.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GetAiringTodayTv,
  GetPopularTv,
  GetTopRatedTv,
  GetTvRecommendations,
  GetTvWatchlistStatus,
  GetSeasonDetail,
  GetWatchlistTvs,
  RemoveWatchlistTv,
  SaveWatchlistTv,
  SearchTvs,
  GetTvDetail,
])
void main() {}
