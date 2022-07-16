import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_object/dummy_movies_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedsMoviesBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovie;

  setUp(() {
    mockGetTopRatedMovie = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedsMoviesBloc(mockGetTopRatedMovie);
  });

  test('the initial state should be TopRatedsMoviesEmpty', () {
    expect(topRatedMovieBloc.state, TopRatedsMoviesEmpty());
  });

  blocTest<TopRatedsMoviesBloc, TopRatedsMoviesState>(
    'should emit [Loading, Loaded] when TopRatedsMoviesGetEvent is added',
    build: () {
      when(mockGetTopRatedMovie.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(TopRatedsMoviesGetEvent()),
    expect: () =>
        [TopRatedsMoviesLoading(), TopRatedsMoviesLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
      return topRatedMovieBloc.state.props;
    },
  );

  blocTest<TopRatedsMoviesBloc, TopRatedsMoviesState>(
    'Should emit [Loading, Error] when TopRatedsMoviesGetEvent is added',
    build: () {
      when(mockGetTopRatedMovie.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('The Server is Failure')));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(TopRatedsMoviesGetEvent()),
    expect: () => [
      TopRatedsMoviesLoading(),
      TopRatedsMoviesError('The Server is Failure')
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovie.execute());
    },
  );
}
