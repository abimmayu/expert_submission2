import 'package:dartz/dartz.dart';
import 'package:muse/domain/entities/movie.dart';
import 'package:muse/domain/repositories/movie_repository.dart';
import 'package:muse/common/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
