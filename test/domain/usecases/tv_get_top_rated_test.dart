import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:muse/domain/entities/tv.dart';
import 'package:muse/domain/usecases/get_tv_top_rate.dart';

import '../../helpers/test_tv_helper.mocks.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTopRatedTv(mockTvRepository);
  });

  final tMovies = <Tv>[];

  test('should get list of movies from repository', () async {
    when(mockTvRepository.getTopRatedTv())
        .thenAnswer((_) async => Right(tMovies));
    final result = await usecase.execute();
    expect(result, Right(tMovies));
  });
}
