import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:television/television.dart';

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.mocks.dart';

void main() {
  late OnAirsTvsBloc nowPlayingTvBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    nowPlayingTvBloc = OnAirsTvsBloc(mockGetNowPlayingTv);
  });

  test('OnAirsTvsBloc initial state should be empty ', () {
    expect(nowPlayingTvBloc.state, OnAirsTvsEmpty());
  });

  group('Now playing TV series test', () {
    blocTest<OnAirsTvsBloc, OnAirsTvsState>(
        'should emits [Loading, Loaded] when data is successfully fetched.',
        build: () {
          when(mockGetNowPlayingTv.execute())
              .thenAnswer((_) async => Right(tvTestList));
          return nowPlayingTvBloc;
        },
        act: (bloc) => bloc.add(OnAirsTvsGetEvent()),
        expect: () => <OnAirsTvsState>[
              OnAirsTvsLoading(),
              OnAirsTvsLoaded(tvTestList),
            ],
        verify: (bloc) {
          verify(mockGetNowPlayingTv.execute());
          return nowPlayingTvBloc.state.props;
        });

    blocTest<OnAirsTvsBloc, OnAirsTvsState>(
      'should emits [Loading, Error] when now playing TV series data is failed to fetch',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(OnAirsTvsGetEvent()),
      expect: () => <OnAirsTvsState>[
        OnAirsTvsLoading(),
        const OnAirsTvsError('Server Failure'),
      ],
      verify: (bloc) => OnAirsTvsLoading(),
    );
  });
}
