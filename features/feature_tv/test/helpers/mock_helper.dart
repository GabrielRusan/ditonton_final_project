import 'package:bloc_test/bloc_test.dart';
import 'package:feature_tv/presentation/cubit/airing_today_tv_cubit/airing_today_tv_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockAiringTodayTvCubit extends MockCubit<AiringTodayTvState>
    implements AiringTodayTvCubit {}

class MockAiringTodayTvState extends Fake implements AiringTodayTvState {}
