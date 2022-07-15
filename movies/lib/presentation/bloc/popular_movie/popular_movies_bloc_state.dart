part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularsMoviesState extends Equatable {}

class PopularsMoviesEmpty extends PopularsMoviesState {
  @override
  List<Object> get props => [];
}

class PopularsMoviesLoading extends PopularsMoviesState {
  @override
  List<Object> get props => [];
}

class PopularsMoviesLoaded extends PopularsMoviesState {
  final List<Movie> result;
  PopularsMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class PopularsMoviesError extends PopularsMoviesState {
  @override
  List<Object> get props => [message];

  final String message;
  PopularsMoviesError(this.message);
}
