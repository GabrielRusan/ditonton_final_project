part of 'search_tvs_bloc.dart';

sealed class SearchTvsState extends Equatable {
  const SearchTvsState();

  @override
  List<Object> get props => [];
}

final class SearchTvsInitial extends SearchTvsState {}

final class SearchTvsEmpty extends SearchTvsState {}

final class SearchTvsLoading extends SearchTvsState {}

final class SearchTvsError extends SearchTvsState {
  final String message;

  const SearchTvsError(this.message);

  @override
  List<Object> get props => [message];
}

final class SearchTvsHasData extends SearchTvsState {
  final List<Tv> result;

  const SearchTvsHasData({required this.result});

  @override
  List<Object> get props => [result];
}
