import 'package:dartz/dartz.dart';
import 'package:muse/domain/repositories/tv_repository.dart';

import '../../common/failure.dart';
import '../entities/tv_detail.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
