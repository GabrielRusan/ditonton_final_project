import 'package:bloc_test/bloc_test.dart';
import 'package:feature_tv/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:feature_tv/presentation/bloc/tv_watchlist_status_bloc/tv_watchlist_status_bloc.dart';
import 'package:feature_tv/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class MockTvWatchlistStatusBloc
    extends MockBloc<TvWatchlistStatusEvent, TvWatchlistStatusState>
    implements TvWatchlistStatusBloc {}

void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvWatchlistStatusBloc mockTvWatchlistStatusBloc;

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvWatchlistStatusBloc = MockTvWatchlistStatusBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(create: (_) => mockTvDetailBloc),
        BlocProvider<TvWatchlistStatusBloc>(
            create: (_) => mockTvWatchlistStatusBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('test adding tv to watchlist', () {
    testWidgets(
        'Watchlist button should display Snackbar when success added to watchlist',
        (WidgetTester tester) async {
      // arrange
      when(() => mockTvDetailBloc.state).thenReturn(TvDetailLoaded(
          tvDetail: tTvDetail,
          recommendationList: const [],
          seasonDetailList: const []));

      final expectedStates = [
        SuccessAddTv(),
      ];

      whenListen(mockTvWatchlistStatusBloc, Stream.fromIterable(expectedStates),
          initialState:
              const TvWatchlistStatusLoaded(isAddedToWatchlist: false));

      // act
      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
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
      when(() => mockTvDetailBloc.state).thenReturn(TvDetailLoaded(
          tvDetail: tTvDetail,
          recommendationList: const [],
          seasonDetailList: const []));

      final expectedStates = [
        FailAddTv(),
      ];

      whenListen(mockTvWatchlistStatusBloc, Stream.fromIterable(expectedStates),
          initialState:
              const TvWatchlistStatusLoaded(isAddedToWatchlist: false));

      // act
      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
      expect(find.byIcon(Icons.add), findsOneWidget);

      final watchlistButton = find.byType(ElevatedButton);

      await tester.tap(watchlistButton);
      await tester.pump();

      // assert
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed Adding Tv to Watchlist'), findsOneWidget);
    });
  });

  group('test removing tv from watchlist', () {
    testWidgets(
        'Watchlist button should display Snackbar when success Removing from watchlist',
        (WidgetTester tester) async {
      // arrange
      when(() => mockTvDetailBloc.state).thenReturn(TvDetailLoaded(
          tvDetail: tTvDetail,
          recommendationList: const [],
          seasonDetailList: const []));

      final expectedStates = [
        SuccessRemoveTv(),
      ];

      whenListen(mockTvWatchlistStatusBloc, Stream.fromIterable(expectedStates),
          initialState:
              const TvWatchlistStatusLoaded(isAddedToWatchlist: true));

      // act
      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
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
      when(() => mockTvDetailBloc.state).thenReturn(TvDetailLoaded(
          tvDetail: tTvDetail,
          recommendationList: const [],
          seasonDetailList: const []));

      final expectedStates = [
        FailRemoveTv(),
      ];

      whenListen(mockTvWatchlistStatusBloc, Stream.fromIterable(expectedStates),
          initialState:
              const TvWatchlistStatusLoaded(isAddedToWatchlist: true));

      // act
      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
      expect(find.byIcon(Icons.check), findsOneWidget);

      final watchlistButton = find.byType(ElevatedButton);

      await tester.tap(watchlistButton);
      await tester.pump();

      // assert
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed to Remove Tv from Watchlist'), findsOneWidget);
    });
  });

  group('Test the display', () {
    group('Watchlist Button', () {
      testWidgets(
          'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(() => mockTvDetailBloc.state).thenReturn(TvDetailLoaded(
            tvDetail: tTvDetail,
            recommendationList: const [],
            seasonDetailList: const []));
        when(() => mockTvWatchlistStatusBloc.state).thenReturn(
            const TvWatchlistStatusLoaded(isAddedToWatchlist: false));

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display check icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(() => mockTvDetailBloc.state).thenReturn(TvDetailLoaded(
            tvDetail: tTvDetail,
            recommendationList: const [],
            seasonDetailList: const []));
        when(() => mockTvWatchlistStatusBloc.state).thenReturn(
            const TvWatchlistStatusLoaded(isAddedToWatchlist: true));

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });
    });

    group('Season Detail', () {
      testWidgets(
          'should display season detail when succes get data season detail',
          (WidgetTester tester) async {
        when(() => mockTvDetailBloc.state).thenReturn(TvDetailLoaded(
            tvDetail: tTvDetail,
            recommendationList: const [],
            seasonDetailList: const [tSeasonDetail]));
        when(() => mockTvWatchlistStatusBloc.state).thenReturn(
            const TvWatchlistStatusLoaded(isAddedToWatchlist: true));

        final columnSeason = find.byKey(Key('${tSeasonDetail.id}'));

        await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

        expect(columnSeason, findsOneWidget);
      });
    });

    group('Tv Recommendations', () {
      testWidgets(
          'should display ListView when succes get data tv recommendations',
          (WidgetTester tester) async {
        when(() => mockTvDetailBloc.state).thenReturn(TvDetailLoaded(
            tvDetail: tTvDetail,
            recommendationList: const [],
            seasonDetailList: const []));
        when(() => mockTvWatchlistStatusBloc.state).thenReturn(
            const TvWatchlistStatusLoaded(isAddedToWatchlist: true));

        final listViewRecom = find.byKey(const Key('recommendation'));

        await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

        expect(listViewRecom, findsOneWidget);
      });
    });
  });
}
