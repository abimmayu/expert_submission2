import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:television/television.dart';

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.dart';

void main() {
  late FakeTopRatedTvBloc fakeTopRatedTvBloc;

  setUp(() {
    fakeTopRatedTvBloc = FakeTopRatedTvBloc();
    registerFallbackValue(FakeTopRatedTvE());
    registerFallbackValue(FakeTopRatedTvS());
  });

  tearDown(() {
    fakeTopRatedTvBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<TopRatedsTvsBloc>(
      create: (_) => fakeTopRatedTvBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTvBloc.state).thenReturn(TopRatedsTvsLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester
        .pumpWidget(_createTestableWidget(const TopRatedTelevisionPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'Should display AppBar, ListView, TvCardList, and TopRatedTvPage when data fetched successfully',
      (WidgetTester tester) async {
    when(() => fakeTopRatedTvBloc.state)
        .thenReturn(TopRatedsTvsLoaded(tvTestList));
    await tester
        .pumpWidget(_createTestableWidget(const TopRatedTelevisionPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
    expect(find.byKey(const Key('Top rated TV series page')), findsOneWidget);
  });
}
