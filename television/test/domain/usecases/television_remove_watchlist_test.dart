import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:television/television.dart' show RemoveWatchlistTv;

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.mocks.dart';

void main() {
  late RemoveWatchlistTv tvUsecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    tvUsecase = RemoveWatchlistTv(mockTvRepository);
  });

  test('should remove watchlist TV series from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlistTv(tvDetailTest))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await tvUsecase.execute(tvDetailTest);
    // assert
    verify(mockTvRepository.removeWatchlistTv(tvDetailTest));
    expect(result, const Right('Removed from watchlist'));
  });
}
