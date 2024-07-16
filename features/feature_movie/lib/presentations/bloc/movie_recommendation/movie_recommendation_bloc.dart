import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/domain/usecases/get_movie_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationBloc(this.getMovieRecommendations)
      : super(MovieRecommendationEmpty()) {
    on<FetchMovieRecommendation>((event, emit) async {
      emit(MovieRecommendationLoading());

      final result = await getMovieRecommendations.execute(event.id);

      result.fold((failure) {
        emit(MovieRecommendationError());
      }, (movieList) {
        if (movieList.isEmpty) {
          emit(MovieRecommendationEmpty());
        } else {
          emit(MovieRecommendationHasData(result: movieList));
        }
      });
    });
  }
}
