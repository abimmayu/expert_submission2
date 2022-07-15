import 'package:core/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:television/domain/entities/television.dart';
import 'package:television/domain/repositories/television_repository.dart';

class GetNowPlayingTv {
  final TvRepository repository;

  GetNowPlayingTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTv();
  }
}
