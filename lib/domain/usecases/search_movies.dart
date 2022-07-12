import 'package:dartz/dartz.dart';
import 'package:muse/common/failure.dart';
import 'package:muse/domain/entities/movie.dart';
import 'package:muse/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
