part of 'search_tvs_bloc.dart';

sealed class SearchTvsEvent extends Equatable {
  const SearchTvsEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends SearchTvsEvent {
  final String query;

  const OnQueryChanged({required this.query});

  @override
  List<Object> get props => [query];
}
