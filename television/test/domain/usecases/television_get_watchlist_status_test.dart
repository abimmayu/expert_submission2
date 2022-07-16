import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:television/television.dart' show GetWatchListStatusTv;

import '../../helpers/test_television_helpers.mocks.dart';

void main() {
  late GetWatchListStatusTv tvUsecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    tvUsecase = GetWatchListStatusTv(mockTvRepository);
  });

  test('should get watchlist TV series status from repository', () async {
    // arrange
    when(mockTvRepository.isAddedToWatchlistTv(1))
        .thenAnswer((_) async => true);
    // act
    final result = await tvUsecase.execute(1);
    // assert
    expect(result, true);
  });
}
