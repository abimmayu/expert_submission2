import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_object/dummy_movies_object.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeNowPlayingMovieBloc fakeNowPlayingMovieBloc;
  late FakePopularMovieBloc fakePopularMovieBloc;
  late FakeTopRatedMovieBloc fakeTopRatedMovieBloc;

  setUp(() {
    fakeNowPlayingMovieBloc = FakeNowPlayingMovieBloc();
    registerFallbackValue(FakeNowPlayingMovieE());
    registerFallbackValue(FakeNowPlayingMovieS());
    fakePopularMovieBloc = FakePopularMovieBloc();
    registerFallbackValue(FakePopularMovieE());
    registerFallbackValue(FakePopularMovieS());
    fakeTopRatedMovieBloc = FakeTopRatedMovieBloc();
    registerFallbackValue(FakeTopRatedMovieE());
    registerFallbackValue(FakeTopRatedMovieS());
  });

  tearDown(() {
    fakeNowPlayingMovieBloc.close();
    fakePopularMovieBloc.close();
    fakeTopRatedMovieBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingsMoviesBloc>(
          create: (context) => fakeNowPlayingMovieBloc,
        ),
        BlocProvider<PopularsMoviesBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<TopRatedsMoviesBloc>(
          create: (context) => fakeTopRatedMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets(
      'page should display listview of [Now Playing Movie, Popular Movie, Top Rated Movie] when Loaded state is happen',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingMovieBloc.state)
        .thenReturn(NowPlayingsMoviesLoaded(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularsMoviesLoaded(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedsMoviesLoaded(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(listViewFinder, findsWidgets);
  });
}
