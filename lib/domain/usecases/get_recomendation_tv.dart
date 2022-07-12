import 'package:dartz/dartz.dart';
import 'package:muse/domain/repositories/tv_repository.dart';

import '../../common/failure.dart';
import '../entities/tv.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
