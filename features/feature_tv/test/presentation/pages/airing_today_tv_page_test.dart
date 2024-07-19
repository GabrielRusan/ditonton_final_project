import 'package:bloc_test/bloc_test.dart';
import 'package:feature_tv/domain/entities/tv.dart';
import 'package:feature_tv/presentation/bloc/airing_today_tv_bloc/airing_today_tv_bloc.dart';
import 'package:feature_tv/presentation/pages/airing_today_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAiringTodayTvBloc
    extends MockBloc<AiringTodayTvEvent, AiringTodayTvState>
    implements AiringTodayTvBloc {}

void main() {
  late AiringTodayTvBloc mockBloc;
  setUp(() {
    mockBloc = MockAiringTodayTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<AiringTodayTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(AiringTodayTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const AiringTodayTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when HasData',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(const AiringTodayTvHasData(result: <Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const AiringTodayTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display Text when Error or Empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(AiringTodayTvError());

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const AiringTodayTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
