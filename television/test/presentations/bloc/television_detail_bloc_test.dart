import 'package:core/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:television/presentation/bloc/television_detail/television_detail_bloc.dart';

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.mocks.dart';

void main() {
  late DetailsTvsBloc detailTvBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    detailTvBloc = DetailsTvsBloc(getTvDetail: mockGetTvDetail);
  });

  const idTest = 1;
  test("DetailMovieBloc initial state should be empty", () {
    expect(detailTvBloc.state, DetailsTvsEmpty());
  });

  group('Detail movie test', () {
    blocTest<DetailsTvsBloc, DetailsTvsState>(
      'Should emit [Loading, Loaded] when TV series detail data is fetched successfully',
      build: () {
        when(mockGetTvDetail.execute(idTest))
            .thenAnswer((_) async => const Right(tvDetailTest));
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(const GetDetailsTvsEvent(idTest)),
      expect: () => [DetailsTvsLoading(), const DetailTvsLoaded(tvDetailTest)],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(idTest));
      },
    );

    blocTest<DetailsTvsBloc, DetailsTvsState>(
      'Should emit [Loading, Error] when detail movie data is failed to fetch',
      build: () {
        when(mockGetTvDetail.execute(idTest)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(const GetDetailsTvsEvent(idTest)),
      expect: () =>
          [DetailsTvsLoading(), const DetailsTvsError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(idTest));
      },
    );
  });
}
