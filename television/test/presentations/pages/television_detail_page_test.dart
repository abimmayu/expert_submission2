import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:television/presentation/bloc/television_detail/television_detail_bloc.dart';
import 'package:television/presentation/bloc/television_recommend/television_recommend_bloc.dart';
import 'package:television/presentation/bloc/television_watchlist/television_watchlist_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:television/presentation/pages/television_detail_page.dart';

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.dart';

void main() {
  late FakeDetailTvBloc fakeDetailTvBloc;
  late FakeRecommendationTvBloc fakeRecommendationTvBloc;
  late FakeWatchlistTvBloc fakeWatchlistTvBloc;

  setUp(() {
    fakeDetailTvBloc = FakeDetailTvBloc();
    registerFallbackValue(FakeDetailTvE());
    registerFallbackValue(FakeDetailTvS());
    fakeRecommendationTvBloc = FakeRecommendationTvBloc();
    registerFallbackValue(FakeRecommendationTvE());
    registerFallbackValue(FakeRecommendationTvS());
    fakeWatchlistTvBloc = FakeWatchlistTvBloc();
    registerFallbackValue(FakeWatchlistTvE());
    registerFallbackValue(FakeWatchlistTvS());
  });

  tearDown(() {
    fakeDetailTvBloc.close();
    fakeRecommendationTvBloc.close();
    fakeWatchlistTvBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailsTvsBloc>(
          create: (context) => fakeDetailTvBloc,
        ),
        BlocProvider<RecommendTvsBloc>(
          create: (context) => fakeRecommendationTvBloc,
        ),
        BlocProvider<WatchlistTvsBloc>(
          create: (context) => fakeWatchlistTvBloc,
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
    when(() => fakeDetailTvBloc.state).thenReturn(DetailsTvsLoading());
    when(() => fakeRecommendationTvBloc.state)
        .thenReturn(RecommendTvsLoading());
    when(() => fakeWatchlistTvBloc.state).thenReturn(WatchlistTvsLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const TelevisionDetailPage(
      id: idTest,
    )));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('Should widget display which all required',
      (WidgetTester tester) async {
    when(() => fakeDetailTvBloc.state)
        .thenReturn(const DetailTvsLoaded(tvDetailTest));
    when(() => fakeRecommendationTvBloc.state)
        .thenReturn(RecommendTvsLoaded(tvTestList));
    when(() => fakeWatchlistTvBloc.state)
        .thenReturn(WatchlistTvsLoaded(tvTestList));
    await tester.pumpWidget(
        _createTestableWidget(const TelevisionDetailPage(id: idTest)));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byKey(const Key('tv detail content')), findsOneWidget);
  });
}
