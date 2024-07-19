import 'package:bloc_test/bloc_test.dart';
import 'package:feature_movie/domain/entities/movie.dart';
import 'package:feature_movie/presentations/bloc/search_movies_bloc/search_movies_bloc.dart';
import 'package:feature_movie/presentations/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchMovieBloc extends MockBloc<SearchMoviesEvent, SearchMoviesState>
    implements SearchMoviesBloc {}

void main() {
  late MockSearchMovieBloc mockBloc;

  setUp(() {
    mockBloc = MockSearchMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchMoviesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should find empty when initial',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchMoviesInitial());

    final expandedInitialFinder = find.byKey(const Key('initial'));

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(expandedInitialFinder, findsOneWidget);
  });

  testWidgets('Page should display text field input for searching',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchMoviesInitial());

    final textFieldFinder = find.byType(TextField);

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(textFieldFinder, findsOneWidget);
  });

  testWidgets('Page should display circular progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(const SearchMoviesHasData(result: <Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display Text when data is empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchMoviesEmpty());

    final textEmptyFinder = find.byKey(const Key('empty'));

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(textEmptyFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is empty',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(SearchMoviesEmpty());

    final textEmptyFinder = find.byKey(const Key('empty'));

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(textEmptyFinder, findsOneWidget);
  });
}
