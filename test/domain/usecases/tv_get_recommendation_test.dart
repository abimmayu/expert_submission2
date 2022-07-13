import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:muse/domain/entities/tv.dart';
import 'package:muse/domain/usecases/get_recomendation_tv.dart';

import '../../helpers/test_tv_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTvRepository);
  });

  final tId = 1;
  final tMovies = <Tv>[];

  test('should get list of movie recommendations from the repository',
      () async {
    when(mockTvRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tMovies));
    final result = await usecase.execute(tId);
    expect(result, Right(tMovies));
  });
}
