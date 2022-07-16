import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:television/domain/usecase/television_get_detail.dart';

import '../../dummy_object/dummy_tv_object.dart';
import '../../helpers/test_television_helpers.mocks.dart';

void main() {
  late GetTvDetail tvUsecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    tvUsecase = GetTvDetail(mockTvRepository);
  });

  const tId = 1;

  test('should get TV series detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvDetail(tId))
        .thenAnswer((_) async => const Right(tvDetailTest));
    // act
    final result = await tvUsecase.execute(tId);
    // assert
    expect(result, const Right(tvDetailTest));
  });
}
