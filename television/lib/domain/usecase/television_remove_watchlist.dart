import 'package:core/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:television/domain/entities/television_detail.dart';
import 'package:television/domain/repositories/television_repository.dart';

class RemoveWatchlistTv {
  final TvRepository repository;

  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeWatchlistTv(tv);
  }
}
