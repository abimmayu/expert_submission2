import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:muse/domain/usecases/get_tv_watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_tv_helper.mocks.dart';

void main() {
  late GetWatchlistTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistTv(mockTvRepository);
  });

  test('should get list of tv from the repository', () async {
    when(mockTvRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(testTvList));
    final result = await usecase.execute();
    expect(result, Right(testTvList));
  });
}
