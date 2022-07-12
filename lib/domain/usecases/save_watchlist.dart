import 'package:dartz/dartz.dart';
import 'package:muse/common/failure.dart';
import 'package:muse/domain/entities/movie_detail.dart';
import 'package:muse/domain/repositories/movie_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
