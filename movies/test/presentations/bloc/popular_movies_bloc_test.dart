import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/bloc/popular_movie/popular_movies_bloc.dart';

import '../../dummy_object/dummy_movies_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late PopularsMoviesBloc popularsMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularsMoviesBloc = PopularsMoviesBloc(mockGetPopularMovies);
  });

  test('the initial state should be PopularsMoviesEmpty', () {
    expect(popularsMoviesBloc.state, PopularsMoviesEmpty());
  });

  blocTest<PopularsMoviesBloc, PopularsMoviesState>(
    'should emit [Loading, Loaded] when PopularsMoviesGetEvent is added',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return popularsMoviesBloc;
    },
    act: (bloc) => bloc.add(PopularsMoviesGetEvent()),
    expect: () =>
        [PopularsMoviesLoading(), PopularsMoviesLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
      return popularsMoviesBloc.state.props;
    },
  );

  blocTest<PopularsMoviesBloc, PopularsMoviesState>(
    'Should emit [Loading, Error] when PopularsMoviesGetEvent is added',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('The Server is Failure')));
      return popularsMoviesBloc;
    },
    act: (bloc) => bloc.add(PopularsMoviesGetEvent()),
    expect: () =>
        [PopularsMoviesLoading(), PopularsMoviesError('The Server is Failure')],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
      return popularsMoviesBloc.state.props;
    },
  );
}
