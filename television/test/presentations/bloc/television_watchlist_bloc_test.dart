import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:television/television.dart';

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.mocks.dart';

void main() {
  late WatchlistTvsBloc watchlistTvBloc;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetWatchListStatusTv mockGetWatchlistTvStatus;
  late MockSaveWatchlistTv mockSaveTvWatchlist;
  late MockRemoveWatchlistTv mockRemoveTvWatchlist;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    mockGetWatchlistTvStatus = MockGetWatchListStatusTv();
    mockSaveTvWatchlist = MockSaveWatchlistTv();
    mockRemoveTvWatchlist = MockRemoveWatchlistTv();
    watchlistTvBloc = WatchlistTvsBloc(
        getWatchlistTv: mockGetWatchlistTv,
        getWatchListStatus: mockGetWatchlistTvStatus,
        removeWatchlist: mockRemoveTvWatchlist,
        saveWatchlist: mockSaveTvWatchlist);
  });
  test('WatchlistTvBloc initial state should be empty ', () {
    expect(watchlistTvBloc.state, WatchlistTvsEmpty());
  });

  group('Get watchlist TV series test', () {
    blocTest<WatchlistTvsBloc, WatchlistTvsState>(
      'should emits [Loading, Loaded] when watchlist TV series list data is successfully fetched',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Right([tvWatchlistTest]));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(GetListEvent()),
      expect: () => [
        WatchlistTvsLoading(),
        WatchlistTvsLoaded([tvWatchlistTest]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
        return GetListEvent().props;
      },
    );

    blocTest<WatchlistTvsBloc, WatchlistTvsState>(
      'should emits [Loading, Error] when watchlist TV series list data is failed to fetch',
      build: () {
        when(mockGetWatchlistTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(GetListEvent()),
      expect: () => <WatchlistTvsState>[
        WatchlistTvsLoading(),
        const WatchlistTvsError('Server Failure'),
      ],
      verify: (bloc) => WatchlistTvsLoading(),
    );
  });

  group('Get watchlist status TV series test', () {
    blocTest<WatchlistTvsBloc, WatchlistTvsState>(
      'should be return true when the TV series watchlist is also true',
      build: () {
        when(mockGetWatchlistTvStatus.execute(tvDetailTest.id))
            .thenAnswer((_) async => true);
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(GetStatusTvsEvent(tvDetailTest.id)),
      expect: () =>
          [WatchlistTvsLoading(), const WatchlistTvsStatusLoaded(true)],
      verify: (bloc) {
        verify(mockGetWatchlistTvStatus.execute(tvDetailTest.id));
        return GetStatusTvsEvent(tvDetailTest.id).props;
      },
    );

    blocTest<WatchlistTvsBloc, WatchlistTvsState>(
        'should be return false when the TV series watchlist is also false',
        build: () {
          when(mockGetWatchlistTvStatus.execute(tvDetailTest.id))
              .thenAnswer((_) async => false);
          return watchlistTvBloc;
        },
        act: (bloc) => bloc.add(GetStatusTvsEvent(tvDetailTest.id)),
        expect: () => <WatchlistTvsState>[
              WatchlistTvsLoading(),
              const WatchlistTvsStatusLoaded(false),
            ],
        verify: (bloc) {
          verify(mockGetWatchlistTvStatus.execute(tvDetailTest.id));
          return GetStatusTvsEvent(tvDetailTest.id).props;
        });
  });

  group('Add watchlist TV series test', () {
    blocTest<WatchlistTvsBloc, WatchlistTvsState>(
      'should update watchlist status when add movie to watchlist is successfully',
      build: () {
        when(mockSaveTvWatchlist.execute(tvDetailTest))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(const AddItemTvsEvent(tvDetailTest)),
      expect: () => [
        const WatchlistTvsSuccess('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveTvWatchlist.execute(tvDetailTest));
        return const AddItemTvsEvent(tvDetailTest).props;
      },
    );

    blocTest<WatchlistTvsBloc, WatchlistTvsState>(
      'should throw failure message status when failed to add TV series to watchlist',
      build: () {
        when(mockSaveTvWatchlist.execute(tvDetailTest)).thenAnswer((_) async =>
            const Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(const AddItemTvsEvent(tvDetailTest)),
      expect: () => [
        const WatchlistTvsError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveTvWatchlist.execute(tvDetailTest));
        return const AddItemTvsEvent(tvDetailTest).props;
      },
    );
  });

  group('Remove watchlist TV series test', () {
    blocTest<WatchlistTvsBloc, WatchlistTvsState>(
      'should update watchlist status when remove TV series from watchlist is successfully',
      build: () {
        when(mockRemoveTvWatchlist.execute(tvDetailTest))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(const RemoveItemTvsEvent(tvDetailTest)),
      expect: () => [
        const WatchlistTvsSuccess('Removed from Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveTvWatchlist.execute(tvDetailTest));
        return const RemoveItemTvsEvent(tvDetailTest).props;
      },
    );

    blocTest<WatchlistTvsBloc, WatchlistTvsState>(
      'should throw failure message status when failed to remove TV series from watchlist',
      build: () {
        when(mockRemoveTvWatchlist.execute(tvDetailTest)).thenAnswer(
            (_) async =>
                const Left(DatabaseFailure('can\'t add data to watchlist')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(const RemoveItemTvsEvent(tvDetailTest)),
      expect: () => [
        const WatchlistTvsError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveTvWatchlist.execute(tvDetailTest));
        return const RemoveItemTvsEvent(tvDetailTest).props;
      },
    );
  });
}
