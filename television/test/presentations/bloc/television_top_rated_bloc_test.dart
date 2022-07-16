import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:television/television.dart';

import '../../helpers/test_television_helpers.mocks.dart';

void main() {
  late TopRatedsTvsBloc topRatedTvBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedsTvsBloc(mockGetTopRatedTv);
  });

  test("TopRatedTvBloc initial state should be empty", () {
    expect(topRatedTvBloc.state, TopRatedsTvsEmpty());
  });

  final tvList = <Tv>[];
  group(
    'Top rated TV series test',
    () {
      blocTest<TopRatedsTvsBloc, TopRatedsTvsState>(
        'Should emit [Loading, Loaded] when top rated movie data is fetched successfully',
        build: () {
          when(mockGetTopRatedTv.execute())
              .thenAnswer((_) async => Right(tvList));
          return topRatedTvBloc;
        },
        act: (bloc) => bloc.add(TopRatedsTvsGetEvent()),
        expect: () => [TopRatedsTvsLoading(), TopRatedsTvsLoaded(tvList)],
        verify: (bloc) {
          verify(mockGetTopRatedTv.execute());
        },
      );

      blocTest<TopRatedsTvsBloc, TopRatedsTvsState>(
        'Should emit [Loading, Error] when get top rated movie data is failed to fetched',
        build: () {
          when(mockGetTopRatedTv.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return topRatedTvBloc;
        },
        act: (bloc) => bloc.add(TopRatedsTvsGetEvent()),
        expect: () =>
            [TopRatedsTvsLoading(), const TopRatedsTvsError('Server Failure')],
        verify: (bloc) {
          verify(mockGetTopRatedTv.execute());
        },
      );
    },
  );
}
