import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_object/dummy_movies_object.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeTopRatedMovieBloc fakeTopRatedMovieBloc;

  setUp(() {
    fakeTopRatedMovieBloc = FakeTopRatedMovieBloc();
    registerFallbackValue(FakeTopRatedMovieE());
    registerFallbackValue(FakeNowPlayingMovieS());
  });

  tearDown(() {
    fakeTopRatedMovieBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<TopRatedsMoviesBloc>(
      create: (_) => fakeTopRatedMovieBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedsMoviesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const TopRatedMoviesPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'Should display AppBar, ListView, MovieCard, and TopRatedMoviesPage when data fetched successfully',
      (WidgetTester tester) async {
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedsMoviesLoaded(testMovieList));
    await tester.pumpWidget(_createTestableWidget(const TopRatedMoviesPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(MovieCard), findsOneWidget);
    expect(find.byKey(const Key('Top rated movie page')), findsOneWidget);
  });
}
