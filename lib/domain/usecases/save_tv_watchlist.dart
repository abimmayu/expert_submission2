import 'package:dartz/dartz.dart';
import 'package:muse/domain/repositories/tv_repository.dart';

import '../../common/failure.dart';
import '../entities/tv_detail.dart';

class SaveTvWatchlist {
  final TvRepository repository;

  SaveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlistTv(tv);
  }
}
