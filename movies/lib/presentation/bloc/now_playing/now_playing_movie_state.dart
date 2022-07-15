part of 'now_playing_movies_bloc.dart';

@immutable
abstract class NowPlayingsMoviesState extends Equatable {}

class NowPlayingsMoviesEmpty extends NowPlayingsMoviesState {
  @override
  List<Object> get props => [];
}

class NowPlayingsMoviesLoading extends NowPlayingsMoviesState {
  @override
  List<Object> get props => [];
}

class NowPlayingsMoviesLoaded extends NowPlayingsMoviesState {
  final List<Movie> movies;
  NowPlayingsMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class NowPlayingsMoviesError extends NowPlayingsMoviesState {
  @override
  List<Object> get props => [message];

  final String message;
  NowPlayingsMoviesError(this.message);
}
