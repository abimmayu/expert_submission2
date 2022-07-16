part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesEmpty extends WatchlistMoviesState {
  final String message = 'Watchlist Movies are Empty';
}

class WatchlistMoviesLoading extends WatchlistMoviesState {
  final String message = 'Watchlist Movies are Loading';
}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;
  const WatchlistMoviesError(this.message);
  @override
  List<Object> get props => [message];
}

class WatchlistMoviesLoaded extends WatchlistMoviesState {
  final List<Movie> result;
  const WatchlistMoviesLoaded(this.result);
  @override
  List<Object> get props => [result];
}

class MovieWatchlistSuccess extends WatchlistMoviesState {
  final String message;
  const MovieWatchlistSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class MovieWatchlistStatusLoaded extends WatchlistMoviesState {
  final bool result;
  const MovieWatchlistStatusLoaded(this.result);
  @override
  List<Object> get props => [result];
}
