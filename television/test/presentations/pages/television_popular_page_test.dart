import 'package:core/presentations/widget/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:television/presentation/bloc/television_popular/television_popular_bloc.dart';
import 'package:television/presentation/pages/television_popular_page.dart';

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.dart';

void main() {
  late FakePopularTvBloc fakePopularTvBloc;

  setUp(() {
    fakePopularTvBloc = FakePopularTvBloc();
    registerFallbackValue(FakePopularTvE());
    registerFallbackValue(FakePopularTvS());
  });

  tearDown(() {
    fakePopularTvBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<PopularsTvsBloc>(
      create: (_) => fakePopularTvBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakePopularTvBloc.state).thenReturn(PopularsTvsLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester
        .pumpWidget(_createTestableWidget(const PopularTelevisionPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'Should display AppBar, ListView, TvCardList, and PopularTvPage when data fetched successfully',
      (WidgetTester tester) async {
    when(() => fakePopularTvBloc.state)
        .thenReturn(PopularsTvsLoaded(tvTestList));
    await tester
        .pumpWidget(_createTestableWidget(const PopularTelevisionPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCard), findsOneWidget);
    expect(find.byKey(const Key('Popular TV series page')), findsOneWidget);
  });
}
