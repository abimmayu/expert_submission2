import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_object/dummy_movies_object.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeWatchlistMovieBloc fakeWatchlistMovieBloc;

  setUp(() {
    fakeWatchlistMovieBloc = FakeWatchlistMovieBloc();
    registerFallbackValue(FakeWatchlistMovieE());
    registerFallbackValue(FakeRecommendationMovieS());
  });

  tearDown(() {
    fakeWatchlistMovieBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<WatchlistMoviesBloc>(
      create: (_) => fakeWatchlistMovieBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(WatchlistMoviesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const WatchlistMoviesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'Should display AppBar, ListView, MovieCard, and WatchlistMoviesPage when data is fetched successfully',
      (WidgetTester tester) async {
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(WatchlistMoviesLoaded(testMovieList));
    await tester.pumpWidget(_createTestableWidget(const WatchlistMoviesPage()));
    await tester.pump();

    expect(find.byType(Padding), findsWidgets);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
    expect(find.byKey(const Key('watchlist movie page')), findsOneWidget);
  });

  testWidgets('Should display text with message when error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(const WatchlistMoviesError(errorMessage));

    final textMessageKeyFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_createTestableWidget(const WatchlistMoviesPage()));
    await tester.pump();

    expect(textMessageKeyFinder, findsOneWidget);
  });
}
