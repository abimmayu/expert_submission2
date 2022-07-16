import 'package:core/presentations/widget/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:television/presentation/bloc/television_watchlist/television_watchlist_bloc.dart';
import 'package:television/presentation/pages/television_watchlist_page.dart';

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.dart';

void main() {
  late FakeWatchlistTvBloc fakeWatchlistTvBloc;

  setUp(() {
    fakeWatchlistTvBloc = FakeWatchlistTvBloc();
    registerFallbackValue(FakeWatchlistTvE());
    registerFallbackValue(FakeWatchlistTvS());
  });

  tearDown(() {
    fakeWatchlistTvBloc.close();
  });
  Widget _createTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvsBloc>(
      create: (_) => fakeWatchlistTvBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeWatchlistTvBloc.state).thenReturn(WatchlistTvsLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester
        .pumpWidget(_createTestableWidget(const WatchlistTelevisionPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'Should display AppBar, ListView, TvCardList, and WatchlistTvPage when data is fetched successfully',
      (WidgetTester tester) async {
    when(() => fakeWatchlistTvBloc.state)
        .thenReturn(WatchlistTvsLoaded(tvTestList));
    await tester
        .pumpWidget(_createTestableWidget(const WatchlistTelevisionPage()));
    await tester.pump();

    expect(find.byType(Padding), findsWidgets);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
    expect(find.byKey(const Key('watchlist tv page')), findsOneWidget);
  });

  testWidgets('Should display text with message when error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakeWatchlistTvBloc.state)
        .thenReturn(const WatchlistTvsError(errorMessage));

    final textMessageKeyFinder = find.byKey(const Key('error_message'));
    await tester
        .pumpWidget(_createTestableWidget(const WatchlistTelevisionPage()));
    await tester.pump();

    expect(textMessageKeyFinder, findsOneWidget);
  });
}
