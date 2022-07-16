import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';
import 'package:television/television.dart';

import '../../helpers/test_search_helpers.mocks.dart';

void main() {
  late SearchTvsBloc tvSearchBloc;
  late MockSearchTv mockSearchTv;

  final tvModelTest = Tv(
      backdropPath: 'backdropPath',
      genreIds: const [1, 3],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 10.9,
      posterPath: 'posterPath',
      firstAirDate: '2019-09-17',
      name: 'name',
      voteAverage: 18.76,
      voteCount: 877);

  final tvListTest = <Tv>[tvModelTest];
  const queryTest = 'Spy x Family';

  setUp(() {
    mockSearchTv = MockSearchTv();
    tvSearchBloc = SearchTvsBloc(searchTv: mockSearchTv);
  });

  group('Search TV series with bloc', () {
    test('initial state should be empty', () {
      expect(tvSearchBloc.state, SearchTvsEmpty());
    });

    blocTest<SearchTvsBloc, SearchTvsState>(
      'Should emit [Loading, Loaded] when search TV series data is successfully',
      build: () {
        when(mockSearchTv.execute(queryTest))
            .thenAnswer((_) async => Right(tvListTest));
        return tvSearchBloc;
      },
      act: (bloc) => bloc.add(const TvSearchQueryEvent(queryTest)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvsLoading(),
        SearchTvsLoaded(tvListTest),
      ],
      verify: (bloc) {
        verify(mockSearchTv.execute(queryTest));
      },
    );

    blocTest<SearchTvsBloc, SearchTvsState>(
      'Should emit [Loading, Error] when get TV series search is unsuccessful',
      build: () {
        when(mockSearchTv.execute(queryTest)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvSearchBloc;
      },
      act: (bloc) => bloc.add(const TvSearchQueryEvent(queryTest)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchTvsLoading(),
        const SearchTvsError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTv.execute(queryTest));
      },
    );
  });
}
