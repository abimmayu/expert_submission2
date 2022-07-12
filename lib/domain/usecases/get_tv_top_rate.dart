import 'package:dartz/dartz.dart';
import 'package:muse/common/failure.dart';
import 'package:muse/domain/entities/tv.dart';
import 'package:muse/domain/repositories/tv_repository.dart';

class GetTopRatedTv {
  final TvRepository repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTv();
  }
}
