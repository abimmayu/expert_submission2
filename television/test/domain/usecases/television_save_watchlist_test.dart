import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:television/television.dart' show SaveWatchlistTv;

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.mocks.dart';

void main() {
  late SaveWatchlistTv tvUsecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    tvUsecase = SaveWatchlistTv(mockTvRepository);
  });

  test('should save watchlist TV series to repository', () async {
    // arrange
    when(mockTvRepository.saveWatchlistTv(tvDetailTest))
        .thenAnswer((_) async => const Right('Added from watchlist'));
    // act
    final result = await tvUsecase.execute(tvDetailTest);
    // assert
    verify(mockTvRepository.saveWatchlistTv(tvDetailTest));
    expect(result, const Right('Added from watchlist'));
  });
}
