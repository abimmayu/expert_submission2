import 'package:dartz/dartz.dart';
import 'package:muse/domain/entities/movie.dart';
import 'package:muse/domain/repositories/movie_repository.dart';
import 'package:muse/common/failure.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
