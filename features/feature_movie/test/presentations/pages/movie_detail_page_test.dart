import 'package:bloc_test/bloc_test.dart';
import 'package:feature_movie/presentations/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:feature_movie/presentations/bloc/movie_watchlist_status_bloc/movie_watchlist_status_bloc.dart';
import 'package:feature_movie/presentations/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MockMovieWatchlistStatusBloc
    extends MockBloc<MovieWatchlistStatusEvent, MovieWatchlistStatusState>
    implements MovieWatchlistStatusBloc {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieWatchlistStatusBloc mockMovieWatchlistStatusBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieWatchlistStatusBloc = MockMovieWatchlistStatusBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(create: (_) => mockMovieDetailBloc),
        BlocProvider<MovieWatchlistStatusBloc>(
            create: (_) => mockMovieWatchlistStatusBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('test adding movie to watchlist', () {
    testWidgets(
        'Watchlist button should display Snackbar when success added to watchlist',
        (WidgetTester tester) async {
      // arrange
      when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailLoaded(
        movieDetail: testMovieDetail,
        recommendationList: [],
      ));

      final expectedStates = [
        SuccessAddMovie(),
      ];

      whenListen(
          mockMovieWatchlistStatusBloc, Stream.fromIterable(expectedStates),
          initialState:
              const MovieWatchlistStatusLoaded(isAddedToWatchlist: false));

      // act
      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(find.byIcon(Icons.add), findsOneWidget);

      final watchlistButton = find.byType(ElevatedButton);

      await tester.tap(watchlistButton);
      await tester.pump();

      // assert
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Alert dialog when failed adding to watchlist',
        (WidgetTester tester) async {
      // arrange
      when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailLoaded(
        movieDetail: testMovieDetail,
        recommendationList: [],
      ));

      final expectedStates = [
        FailAddMovie(),
      ];

      whenListen(
          mockMovieWatchlistStatusBloc, Stream.fromIterable(expectedStates),
          initialState:
              const MovieWatchlistStatusLoaded(isAddedToWatchlist: false));

      // act
      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(find.byIcon(Icons.add), findsOneWidget);

      final watchlistButton = find.byType(ElevatedButton);

      await tester.tap(watchlistButton);
      await tester.pump();

      // assert
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed Adding Movie to Watchlist'), findsOneWidget);
    });
  });

  group('test removing movie from watchlist', () {
    testWidgets(
        'Watchlist button should display Snackbar when success Removing from watchlist',
        (WidgetTester tester) async {
      // arrange
      when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailLoaded(
        movieDetail: testMovieDetail,
        recommendationList: [],
      ));

      final expectedStates = [
        SuccessRemoveMovie(),
      ];

      whenListen(
          mockMovieWatchlistStatusBloc, Stream.fromIterable(expectedStates),
          initialState:
              const MovieWatchlistStatusLoaded(isAddedToWatchlist: true));

      // act
      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(find.byIcon(Icons.check), findsOneWidget);

      final watchlistButton = find.byType(ElevatedButton);

      await tester.tap(watchlistButton);
      await tester.pump();

      // assert
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Removed from Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Alert dialog when failed adding to watchlist',
        (WidgetTester tester) async {
      // arrange
      when(() => mockMovieDetailBloc.state).thenReturn(const MovieDetailLoaded(
        movieDetail: testMovieDetail,
        recommendationList: [],
      ));

      final expectedStates = [
        FailRemoveMovie(),
      ];

      whenListen(
          mockMovieWatchlistStatusBloc, Stream.fromIterable(expectedStates),
          initialState:
              const MovieWatchlistStatusLoaded(isAddedToWatchlist: true));

      // act
      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(find.byIcon(Icons.check), findsOneWidget);

      final watchlistButton = find.byType(ElevatedButton);

      await tester.tap(watchlistButton);
      await tester.pump();

      // assert
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(
          find.text('Failed to Remove Movie from Watchlist'), findsOneWidget);
    });
  });

  group('Test the display', () {
    group('Watchlist Button', () {
      testWidgets(
          'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(() => mockMovieDetailBloc.state)
            .thenReturn(const MovieDetailLoaded(
          movieDetail: testMovieDetail,
          recommendationList: [],
        ));
        when(() => mockMovieWatchlistStatusBloc.state).thenReturn(
            const MovieWatchlistStatusLoaded(isAddedToWatchlist: false));

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester
            .pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display check icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(() => mockMovieDetailBloc.state)
            .thenReturn(const MovieDetailLoaded(
          movieDetail: testMovieDetail,
          recommendationList: [],
        ));
        when(() => mockMovieWatchlistStatusBloc.state).thenReturn(
            const MovieWatchlistStatusLoaded(isAddedToWatchlist: true));

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester
            .pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });
    });

    group('Movie Recommendations', () {
      testWidgets(
          'should display ListView when succes get data movie recommendations',
          (WidgetTester tester) async {
        when(() => mockMovieDetailBloc.state)
            .thenReturn(const MovieDetailLoaded(
          movieDetail: testMovieDetail,
          recommendationList: [],
        ));
        when(() => mockMovieWatchlistStatusBloc.state).thenReturn(
            const MovieWatchlistStatusLoaded(isAddedToWatchlist: true));

        final listViewRecom = find.byKey(const Key('recommendation'));

        await tester
            .pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

        expect(listViewRecom, findsOneWidget);
      });
    });
  });
}
