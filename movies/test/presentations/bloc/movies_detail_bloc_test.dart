import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/bloc/detail_movie/detail_movie_bloc.dart';

import '../../dummy_object/dummy_movies_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late DetailsMoviesBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailsMoviesBloc(mockGetMovieDetail);
  });

  const idTest = 1;

  test("DetailMovieBloc initial state should be empty", () {
    expect(detailMovieBloc.state, MoviesDetailsEmpty());
  });

  group('Detail movie test', () {
    blocTest<DetailsMoviesBloc, DetailsMoviesState>(
      'Should emit [Loading, Loaded] when movie detail data is fetched successfully',
      build: () {
        when(mockGetMovieDetail.execute(idTest))
            .thenAnswer((_) async => const Right(testMovieDetail));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(GetDetailsMoviesEvent(idTest)),
      expect: () =>
          [MoviesDetailsLoading(), MoviesDetailsLoaded(testMovieDetail)],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(idTest));
      },
    );

    blocTest<DetailsMoviesBloc, DetailsMoviesState>(
      'Should emit [Loading, Error] when detail movie data is failed to fetched',
      build: () {
        when(mockGetMovieDetail.execute(idTest)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return detailMovieBloc;
      },
      act: (bloc) => bloc.add(GetDetailsMoviesEvent(idTest)),
      expect: () =>
          [MoviesDetailsLoading(), MoviesDetailsError('Server Failure')],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(idTest));
      },
    );
  });
}
