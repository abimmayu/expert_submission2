import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:muse/domain/usecases/get_tv_watchlist_status.dart';

import '../../helpers/test_tv_helper.mocks.dart';

void main() {
  late GetWatchListStatusTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchListStatusTv(mockTvRepository);
  });

  test('should get watchlist tv status from repository', () async {
    when(mockTvRepository.isAddedToWatchlistTv(1))
        .thenAnswer((_) async => true);
    final result = await usecase.execute(1);
    expect(result, true);
  });
}
