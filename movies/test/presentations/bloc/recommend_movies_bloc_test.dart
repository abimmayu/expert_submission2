import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/bloc/recommend_movie/recommended_movies_bloc.dart';

import '../../dummy_object/dummy_movies_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RecommendMoviesBloc recommendationMovieBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMovieBloc = RecommendMoviesBloc(mockGetMovieRecommendations);
  });

  const id = 1;

  test('the initial state should be RecommendMoviesEmpty', () {
    expect(recommendationMovieBloc.state, RecommendMoviesEmpty());
  });

  blocTest<RecommendMoviesBloc, RecommendMoviesState>(
    'should emit [Loading, Loaded] when GetRecommendMoviesEvent is added',
    build: () {
      when(mockGetMovieRecommendations.execute(id))
          .thenAnswer((_) async => Right(testMovieList));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(GetRecommendMoviesEvent(id)),
    expect: () =>
        [RecommendMoviesLoading(), RecommendMoviesLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(id));
      return recommendationMovieBloc.state.props;
    },
  );

  blocTest<RecommendMoviesBloc, RecommendMoviesState>(
    'Should emit [Loading, Error] when GetRecommendMoviesEvent is added',
    build: () {
      when(mockGetMovieRecommendations.execute(id)).thenAnswer(
          (_) async => const Left(ServerFailure('The Server is Failure')));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(GetRecommendMoviesEvent(id)),
    expect: () => [
      RecommendMoviesLoading(),
      RecommendMoviesError('The Server is Failure')
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(id));
      return recommendationMovieBloc.state.props;
    },
  );
}
