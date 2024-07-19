part of 'season_detail_bloc.dart';

sealed class SeasonDetailEvent extends Equatable {
  const SeasonDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchSeasonDetails extends SeasonDetailEvent {
  final int id;
  final int numberOfSeasons;

  const FetchSeasonDetails({required this.id, required this.numberOfSeasons});

  @override
  List<Object> get props => [id, numberOfSeasons];
}
