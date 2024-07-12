import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:search/presentation/bloc/transformers/transformers.dart';

part 'search_tvs_event.dart';
part 'search_tvs_state.dart';

class SearchTvsBloc extends Bloc<SearchTvsEvent, SearchTvsState> {
  final SearchTvs searchTvs;
  SearchTvsBloc(this.searchTvs) : super(SearchTvsEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchTvsLoading());
      final result = await searchTvs.execute(query);

      result.fold((failure) {
        emit(SearchTvsError(failure.message));
      }, (tvList) {
        if (tvList.isEmpty) {
          emit(SearchTvsEmpty());
        } else {
          emit(SearchTvsHasData(result: tvList));
        }
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}