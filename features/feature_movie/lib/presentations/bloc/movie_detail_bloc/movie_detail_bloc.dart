import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/entities/movie_detail.dart';
import 'package:feature_movie/domain/usecases/get_movie_detail.dart';
import 'package:feature_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;

  MovieDetailBloc(
    this._getMovieDetail,
    this._getMovieRecommendations,
  ) : super(MovieDetailLoading()) {
    on<FetchMovieDetail>(onFetchMovieDetail);
  }

  Future<void> onFetchMovieDetail(
      FetchMovieDetail event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());

    final movieDetailResult = await _getMovieDetail.execute(event.id);
    final recommendationResult =
        await _getMovieRecommendations.execute(event.id);

    late MovieDetail movieDetailValue;
    List<Movie> recommendations = [];

    movieDetailResult.fold((failure) {
      emit(MovieDetailError());
    }, (movieDetail) {
      movieDetailValue = movieDetail;

      recommendationResult.fold((failure) {}, (movieList) {
        recommendations = movieList;
      });
    });

    if (state is! MovieDetailError) {
      emit(MovieDetailLoaded(
        movieDetail: movieDetailValue,
        recommendationList: recommendations,
      ));
    }
  }
}
