import 'package:feature_movie/presentations/bloc/popular_movie_bloc/popular_movie_bloc.dart';
import 'package:feature_movie/presentations/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  const PopularMoviesPage({super.key});

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularMovieBloc>().add(FetchPopularMovie()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
            builder: (context, state) {
              if (state is PopularMovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularMovieHasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.result[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.result.length,
                );
              } else {
                return const Center(
                  key: Key('error_message'),
                  child: Text('An Error Occured :('),
                );
              }
            },
          )),
    );
  }
}
