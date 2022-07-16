import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_object/dummy_movies_object.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistMoviesBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMovieBloc = WatchlistMoviesBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
      getWatchListStatus: mockGetWatchListStatus,
      removeWatchlist: mockRemoveWatchlist,
      saveWatchlist: mockSaveWatchlist,
    );
  });

  const testMovieId = 1;
  test('initial state in watchlist movies should be empty', () {
    expect(watchlistMovieBloc.state, WatchlistMoviesEmpty());
  });

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [Loading, Loaded] when data is added',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testWatchlistMovieList));
        return watchlistMovieBloc;
      },
      act: (bloc) async => bloc.add(GetListEvent()),
      expect: () => [
            WatchlistMoviesLoading(),
            WatchlistMoviesLoaded(testWatchlistMovieList),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        return GetListEvent().props;
      });

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should emit [Loading, Error] when data is not added',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server is Failure')));
        return watchlistMovieBloc;
      },
      act: (bloc) async => bloc.add(GetListEvent()),
      expect: () => [
            WatchlistMoviesLoading(),
            const WatchlistMoviesError('Server is Failure'),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        return GetListEvent().props;
      });

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should emit [Loading, Loaded] when data is added',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieId))
            .thenAnswer((_) async => true);
        return watchlistMovieBloc;
      },
      act: (bloc) async => bloc.add(const GetStatusMovieEvent(testMovieId)),
      expect: () => [
            WatchlistMoviesLoading(),
            const MovieWatchlistStatusLoaded(true),
          ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(testMovieId));
        return const GetStatusMovieEvent(testMovieId).props;
      });

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should emit [Loading, Error] when get watchlist status is not added',
      build: () {
        when(mockGetWatchListStatus.execute(testMovieId))
            .thenAnswer((_) async => false);
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(const GetStatusMovieEvent(testMovieId)),
      expect: () => [
            WatchlistMoviesLoading(),
            const MovieWatchlistStatusLoaded(false),
          ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(testMovieId));
        return const GetStatusMovieEvent(testMovieId).props;
      });

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should emit [Loading, Loaded] when data is added',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(const AddItemMovieEvent(testMovieDetail)),
      expect: () => [
            const MovieWatchlistSuccess('Success'),
          ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        return const AddItemMovieEvent(testMovieDetail).props;
      });

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should emit [Loading, Error] when data is not added',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('add data Failed')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(const AddItemMovieEvent(testMovieDetail)),
      expect: () => [
            const WatchlistMoviesError('add data Failed'),
          ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        return const AddItemMovieEvent(testMovieDetail).props;
      });

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should emit [Loading, Removed] when data is Removed',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Remove Data Success'));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(const RemoveItemMovieEvent(testMovieDetail)),
      expect: () => [
            const MovieWatchlistSuccess('Remove Data Success'),
          ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        return const RemoveItemMovieEvent(testMovieDetail).props;
      });

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'should emit [Loading, Error] when data is not Removed',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Remove Data Failed')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(const RemoveItemMovieEvent(testMovieDetail)),
      expect: () => [
            const WatchlistMoviesError('Remove Data Failed'),
          ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        return const RemoveItemMovieEvent(testMovieDetail).props;
      });
}
