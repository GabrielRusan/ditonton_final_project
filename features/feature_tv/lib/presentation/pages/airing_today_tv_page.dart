import 'package:feature_tv/presentation/bloc/airing_today_tv_bloc/airing_today_tv_bloc.dart';
import 'package:feature_tv/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiringTodayTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-today-tv';

  const AiringTodayTvPage({super.key});

  @override
  State<AiringTodayTvPage> createState() => _AiringTodayTvPageState();
}

class _AiringTodayTvPageState extends State<AiringTodayTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<AiringTodayTvBloc>().add(FetchAiringTodayTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringTodayTvBloc, AiringTodayTvState>(
          builder: (context, state) {
            if (state is AiringTodayTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AiringTodayTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('An Error Just Occurred :('),
              );
            }
          },
        ),
      ),
    );
  }
}
