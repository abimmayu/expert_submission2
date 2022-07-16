import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:television/television.dart';

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.dart';

void main() {
  late FakeNowPlayingTvBloc fakeNowPlayingTvBloc;
  late FakePopularTvBloc fakePopularTvBloc;
  late FakeTopRatedTvBloc fakeTopRatedTvBloc;

  setUp(() {
    fakeNowPlayingTvBloc = FakeNowPlayingTvBloc();
    registerFallbackValue(FakeNowPlayingTvE());
    registerFallbackValue(FakeNowPlayingTvS());
    fakePopularTvBloc = FakePopularTvBloc();
    registerFallbackValue(FakePopularTvE());
    registerFallbackValue(FakePopularTvS());
    fakeTopRatedTvBloc = FakeTopRatedTvBloc();
    registerFallbackValue(FakeTopRatedTvE());
    registerFallbackValue(FakeTopRatedTvS());
  });

  tearDown(() {
    fakeNowPlayingTvBloc.close();
    fakePopularTvBloc.close();
    fakeTopRatedTvBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnAirsTvsBloc>(
          create: (context) => fakeNowPlayingTvBloc,
        ),
        BlocProvider<PopularsTvsBloc>(
          create: (context) => fakePopularTvBloc,
        ),
        BlocProvider<TopRatedsTvsBloc>(
          create: (context) => fakeTopRatedTvBloc,
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
      'page should display listview of [Now Playing Movie, Popular Movie, Top Rated Movie] when HasData state is happen',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingTvBloc.state)
        .thenReturn(OnAirsTvsLoaded(tvTestList));
    when(() => fakePopularTvBloc.state)
        .thenReturn(PopularsTvsLoaded(tvTestList));
    when(() => fakeTopRatedTvBloc.state)
        .thenReturn(TopRatedsTvsLoaded(tvTestList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const HomeTelevisionPage()));

    expect(listViewFinder, findsWidgets);
  });
}
