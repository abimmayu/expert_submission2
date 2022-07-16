import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:television/domain/entities/television.dart';
import 'package:television/presentation/bloc/television_recommend/television_recommend_bloc.dart';

import '../../helpers/test_television_helpers.mocks.dart';

void main() {
  late RecommendTvsBloc recommendationTvBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    recommendationTvBloc = RecommendTvsBloc(
      getTvRecommendations: mockGetTvRecommendations,
    );
  });

  const idTest = 1;
  final tvTest = <Tv>[];

  test("RecommendationTvBloc initial state should be empty", () {
    expect(recommendationTvBloc.state, RecommendTvsEmpty());
  });

  group(
    'Recommendation TV series Test',
    () {
      blocTest<RecommendTvsBloc, RecommendTvsState>(
        'Should emit [Loading, Loaded] when recommendation TV series data is fetched successfully',
        build: () {
          when(mockGetTvRecommendations.execute(idTest))
              .thenAnswer((_) async => Right(tvTest));
          return recommendationTvBloc;
        },
        act: (bloc) => bloc.add(const GetRecommendTvsEvent(idTest)),
        expect: () => [RecommendTvsLoading(), RecommendTvsLoaded(tvTest)],
        verify: (bloc) {
          verify(mockGetTvRecommendations.execute(idTest));
        },
      );

      blocTest<RecommendTvsBloc, RecommendTvsState>(
        'Should emit [Loading, Error] when get recommendation TV series data is failed to fetch',
        build: () {
          when(mockGetTvRecommendations.execute(idTest)).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return recommendationTvBloc;
        },
        act: (bloc) => bloc.add(const GetRecommendTvsEvent(idTest)),
        expect: () =>
            [RecommendTvsLoading(), const RecommendTvsError('Server Failure')],
        verify: (bloc) {
          verify(mockGetTvRecommendations.execute(idTest));
        },
      );

      blocTest<RecommendTvsBloc, RecommendTvsState>(
        'should emits [Loading, Empty] when recommendation TV series data is empty',
        build: () {
          when(mockGetTvRecommendations.execute(idTest))
              .thenAnswer((_) async => const Right([]));
          return recommendationTvBloc;
        },
        act: (bloc) => bloc.add(const GetRecommendTvsEvent(idTest)),
        expect: () => <RecommendTvsState>[
          RecommendTvsLoading(),
          const RecommendTvsLoaded([]),
        ],
      );
    },
  );
}
