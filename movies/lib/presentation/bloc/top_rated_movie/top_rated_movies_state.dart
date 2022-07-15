part of 'top_rated_movies_bloc.dart';

@immutable
abstract class TopRatedsMoviesState extends Equatable {}

class TopRatedsMoviesEmpty extends TopRatedsMoviesState {
  @override
  List<Object> get props => [];
}

class TopRatedsMoviesLoading extends TopRatedsMoviesState {
  @override
  List<Object> get props => [];
}

class TopRatedsMoviesLoaded extends TopRatedsMoviesState {
  final List<Movie> result;
  TopRatedsMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedsMoviesError extends TopRatedsMoviesState {
  @override
  List<Object> get props => [message];

  final String message;
  TopRatedsMoviesError(this.message);
}
