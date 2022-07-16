import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/bloc/now_playing/now_playing_movies_bloc.dart';

import '../../dummy_object/dummy_movies_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late NowPlayingsMoviesBloc nowPlayingsMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingsMoviesBloc = NowPlayingsMoviesBloc(mockGetNowPlayingMovies);
  });

  test('the initial state should be NowPlayingsMoviesEmpty', () {
    expect(nowPlayingsMoviesBloc.state, NowPlayingsMoviesEmpty());
  });

  blocTest<NowPlayingsMoviesBloc, NowPlayingsMoviesState>(
    'should emit [Loading, Loaded] when NowPlayingsMoviesGetEvent is added',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return nowPlayingsMoviesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingsMoviesGetEvent()),
    expect: () =>
        [NowPlayingsMoviesLoading(), NowPlayingsMoviesLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
      return nowPlayingsMoviesBloc.state.props;
    },
  );

  blocTest<NowPlayingsMoviesBloc, NowPlayingsMoviesState>(
    'Should emit [Loading, Error] when NowPlayingsMoviesGetEvent is added',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (_) async => const Left(ServerFailure('The Server is Failure')));
      return nowPlayingsMoviesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingsMoviesGetEvent()),
    expect: () => [
      NowPlayingsMoviesLoading(),
      NowPlayingsMoviesError('The Server is Failure')
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
      return nowPlayingsMoviesBloc.state.props;
    },
  );
}
