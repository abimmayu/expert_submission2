import 'package:dartz/dartz.dart';
import 'package:muse/common/failure.dart';
import 'package:muse/domain/entities/movie.dart';
import 'package:muse/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
