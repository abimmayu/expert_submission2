import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_object/dummy_movies_object.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeDetailMovieBloc fakeDetailMovieBloc;
  late FakeRecommendationMovieBloc fakeRecommendationMovieBloc;
  late FakeWatchlistMovieBloc fakeWatchlistMovieBloc;

  setUp(() {
    fakeDetailMovieBloc = FakeDetailMovieBloc();
    registerFallbackValue(FakeDetailMovieE());
    registerFallbackValue(FakeDetailMovieS());
    fakeRecommendationMovieBloc = FakeRecommendationMovieBloc();
    registerFallbackValue(FakeRecommendationMovieE());
    registerFallbackValue(FakeRecommendationMovieS());
    fakeWatchlistMovieBloc = FakeWatchlistMovieBloc();
    registerFallbackValue(FakeWatchlistMovieE());
    registerFallbackValue(FakeWatchlistMovieS());
  });

  tearDown(() {
    fakeDetailMovieBloc.close();
    fakeRecommendationMovieBloc.close();
    fakeWatchlistMovieBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailsMoviesBloc>(
          create: (context) => fakeDetailMovieBloc,
        ),
        BlocProvider<RecommendMoviesBloc>(
          create: (context) => fakeRecommendationMovieBloc,
        ),
        BlocProvider<WatchlistMoviesBloc>(
          create: (context) => fakeWatchlistMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const idTest = 1;

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeDetailMovieBloc.state).thenReturn(MoviesDetailsLoading());
    when(() => fakeRecommendationMovieBloc.state)
        .thenReturn(RecommendMoviesLoading());
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(WatchlistMoviesLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const MovieDetailPage(
      id: idTest,
    )));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('Should widget display which all required',
      (WidgetTester tester) async {
    when(() => fakeDetailMovieBloc.state)
        .thenReturn(MoviesDetailsLoaded(testMovieDetail));
    when(() => fakeRecommendationMovieBloc.state)
        .thenReturn(RecommendMoviesLoaded(testMovieList));
    when(() => fakeWatchlistMovieBloc.state)
        .thenReturn(WatchlistMoviesLoaded(testMovieList));
    await tester
        .pumpWidget(_createTestableWidget(const MovieDetailPage(id: idTest)));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byKey(const Key('movies details content')), findsOneWidget);
  });
}
