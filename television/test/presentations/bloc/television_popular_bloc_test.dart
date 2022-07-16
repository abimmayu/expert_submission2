import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:television/domain/entities/television.dart';
import 'package:television/presentation/bloc/television_popular/television_popular_bloc.dart';

import '../../helpers/test_television_helpers.mocks.dart';

void main() {
  late PopularsTvsBloc popularTvBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularsTvsBloc(mockGetPopularTv);
  });

  final tvList = <Tv>[];

  test("PopularsTvsBloc initial state should be empty", () {
    expect(popularTvBloc.state, PopularsTvsEmpty());
  });

  group('Popular TV series test', () {
    blocTest<PopularsTvsBloc, PopularsTvsState>(
        'Should emit [Loading, Loaded] when popular TV series data is fetched successfully',
        build: () {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Right(tvList));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(PopularsTvsGetEvent()),
        expect: () => [PopularsTvsLoading(), PopularsTvsLoaded(tvList)],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        });

    blocTest<PopularsTvsBloc, PopularsTvsState>(
        'Should emit [Loading, Error] when popular TV series data is failed to fetch',
        build: () {
          when(mockGetPopularTv.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(PopularsTvsGetEvent()),
        expect: () =>
            [PopularsTvsLoading(), const PopularsTvsError('Server Failure')],
        verify: (bloc) {
          verify(mockGetPopularTv.execute());
        });
  });
}
