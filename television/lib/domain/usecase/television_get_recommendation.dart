import 'package:core/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:television/domain/entities/television.dart';
import 'package:television/domain/repositories/television_repository.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
