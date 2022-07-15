import 'package:core/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:television/domain/entities/television_detail.dart';
import 'package:television/domain/repositories/television_repository.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
