import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:television/television.dart';

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.mocks.dart';

void main() {
  late GetWatchlistTv tvUsecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    tvUsecase = GetWatchlistTv(mockTvRepository);
  });

  test('should get list of TV series from the repository', () async {
    // arrange
    when(mockTvRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(tvTestList));
    // act
    final result = await tvUsecase.execute();
    // assert
    expect(result, Right(tvTestList));
  });
}
