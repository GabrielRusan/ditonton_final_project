part of 'popular_tv_bloc.dart';

sealed class PopularTvEvent extends Equatable {
  const PopularTvEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularTv extends PopularTvEvent {}
