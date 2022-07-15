part of 'recommended_movies_bloc.dart';

@immutable
abstract class RecommendMoviesState extends Equatable {}

class RecommendMoviesEmpty extends RecommendMoviesState {
  @override
  List<Object> get props => [];
}

class RecommendMoviesLoading extends RecommendMoviesState {
  @override
  List<Object> get props => [];
}

class RecommendMoviesLoaded extends RecommendMoviesState {
  final List<Movie> movies;
  RecommendMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class RecommendMoviesError extends RecommendMoviesState {
  @override
  List<Object> get props => [message];

  final String message;
  RecommendMoviesError(this.message);
}
